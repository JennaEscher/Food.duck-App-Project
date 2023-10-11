import 'dart:async';
import 'dart:io';
import 'dart:convert';

import 'package:path_provider/path_provider.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import '../firebase_options.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cache_manager/cache_manager.dart';

//전체 데이터를 받는 리스트. JSON 객체 형태로 저장됨.
List<dynamic> listfood = [];

Map name = {};
Map category = {};
Map trav_time = {};
Map price = {};
Map place = {};
Map tag = {};
List<int> listmeta = [];
List<dynamic> tags = [];
List<dynamic> places = [];
List<dynamic> prices = [];
List<String> categorys = <String>[];
List<String> recentSearches = []; //최근검색어 리스트
List<int> liked = [];

/*
[
  name
  address
  category
  trav_time
  place
  avg_Price
  tags [

  ]
  times [
    
  ]

]
*/

Future<int> makelist(var parsedList) async {
  int idx = 0;
  liked = [];
  for (var i in parsedList) {
    name[i["name"]] = idx;
    if (category.containsKey(i["category"])) {
      //Map에 바로 대입
      category[i["category"]].add(idx);
    } else {
      //List에 추가
      categorys.add(i["category"]);

      //Map 초기화
      category[i["category"]] = <int>[];

      //Map에 대입
      category[i["category"]].add(idx);
    }
    if (trav_time.containsKey(i["trav_time"])) {
      //Map에 바로 대입
      trav_time[i["trav_time"]].add(idx);
    } else {
      //Map 초기화
      trav_time[i["trav_time"]] = <int>[];

      //Map에 대입
      trav_time[i["trav_time"]].add(idx);
    }

    //평균 가격이 데이터 안에 존재할 때
    if (i["avg_Price"] != 0) {
      //평균 가격대 설정
      var pp = ((i["avg_Price"]) / 10000).toInt();
      if (pp > 3) pp = 3;
      if (price.containsKey(pp)) {
        price[pp].add(idx);
      } else {
        price[pp] = <int>[];
        price[pp].add(idx);
      }
    } else {
      for (int i = 0; i < 4; i++) {
        if (!price.containsKey(i)) {
          price[i] = <int>[];
        }
        price[i].add(idx);
      }
    }
    if (place.containsKey(i["place"])) {
      place[i["place"]].add(idx);
    } else {
      place[i["place"]] = <int>[];
      place[i["place"]].add(idx);
    }
    for (var j in i["tags"]) {
      if (tag.containsKey(j)) {
        tag[j].add(idx);
      } else {
        tag[j] = [];
        tag[j].add(idx);
      }
    }
    var tmp = await ReadCaches(i["name"]);
    if (tmp!.isEmpty) {
      //음식점 이름으로 초기화. 즐겨찾기에 추가된 상태가 아니다.
      WriteCaches(i["name"], '0');
    } else {
      //liked: 즐겨찾기 리스트. 1이면 즐겨찾기에 추가된 상태.
      if (tmp == '1' && !liked.contains(idx)) liked.add(idx);
    }
    //Index Increment
    idx++;
  }

  //전체 데이터에서 place / tag / price에 대한 리스트를 추출.
  places = place.keys.toList();
  tags = tag.keys.toList();
  prices = price.keys.toList();
  //파싱 끝.

  return 0;
}

Future<int> init(CounterStorage cs) async {
  // 인터넷 접속 시도
  bool result = await InternetConnection().hasInternetAccess;
  // recentSearches 초기화
  await InitCaches('recentSearches');
  // 최근 검색어 불러오기. 동기화
  var cache = await ReadCaches('recentSearches');
  // 최근 검색어가 있으면 리스트로 변환
  if (cache!.isNotEmpty) {
    recentSearches = cache.split('\n');
  } else {
    // 없다면 빈 상태로 계속 진행
    recentSearches = [];
  }
  // 인터넷 접속에 성공
  if (result == true) {
    // Firebase 접속 시도
    try {
      // Firebase App 초기화
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      // Firebase Storage 접속, 데이터 파일 가져오기
      final datapath = FirebaseStorage.instance
          .refFromURL("gs://foodduck-23ca8.appspot.com/food_jason.json");
      // 데이터 파일 가져오기 시도
      try {
        const oneMegabyte = 1024 * 1024;
        final data = await datapath.getData(oneMegabyte);
        final String fooddata = utf8.decode(data!);
        // 데이터 파일을 캐시에 food로 저장
        await InitCaches('food');
        await WriteCaches('food', fooddata);
        // 데이터 파일을 json 객체로 변환
        listfood = jsonDecode(fooddata);
        //json 객체 형태의 파일을 파싱해서 리스트로 변환
        await makelist(listfood);
      } on FirebaseException catch (e) {
        // 이 과정에서 생기는 오류를 여기서 처리
      }

      return 0;
    } catch (e) {
      //로컬 파일이 없어서 생기는 오류(PathNotFoundException).
      return -1;
    }
  } else {
    // 인터넷 접속에 실패한 경우
    try {
      try {
        //캐시에서 데이터 가져오기
        if (await InitCaches('food') == 0) {
          //못 찾으면 오류 발생
          throw 'data not found';
        }
        //캐시에서 데이터 가져오기
        final String? fooddata = await ReadCaches('food');
        //json 객체 형태의 파일을 파싱해서 리스트로 변환
        listfood = jsonDecode(fooddata!);
        await makelist(listfood);
      } on FirebaseException catch (e) {
        // Firebase 오류 처리
      }
      return 0;
    } catch (e) {
      //나머지 오류 처리
      return -1;
    }
  }
}

Future<int?> InitCaches(var k) async {
  int CacheResult = 0;
  CacheManagerUtils.conditionalCache(
      key: k,
      valueType: ValueType.StringValue,
      actionIfNull: () {
        CacheResult = 0;
        recentSearches = [];
      },
      actionIfNotNull: () {
        CacheResult = 1;
      });
  return CacheResult;
}

Future<String?> WriteCaches(var k, var st) async {
  WriteCache.setString(key: k, value: st);
  return null;
}

Future<String?> ReadCaches(var k) async {
  dynamic DasData = '';
  var DasValue = await ReadCache.getString(key: k);
  DasData = DasValue.toString();
  if (DasData == 'null') DasData = '';
  return DasData;
}

class CounterStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/counter.json');
  }
}
