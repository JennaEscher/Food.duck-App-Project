import 'dart:async';
import 'dart:io';
import 'dart:convert';

import 'package:path_provider/path_provider.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import '../firebase_options.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cache_manager/cache_manager.dart';

List<dynamic> listfood = [];
Map name = {};
Map category = {};
Map trav_time = {};
Map tag = {};
List<int> listmeta = [];
List<String> tags = [];
List<String> categorys = [];
List<String> recentSearches = []; //최근검색어 리스트
List<int> liked = [];

Future<int> makelist(var parsedList) async {
  int idx = 0;
  for (var i in parsedList) {
    name[i["name"]] = idx;
    if (category.containsKey(i["category"])) {
      category[i["category"]].add(idx);
    } else {
      categorys.add(i["category"]);
      category[i["category"]] = <int>[];

      category[i["category"]].add(idx);
    }
    if (trav_time.containsKey(i["trav_time"])) {
      trav_time[i["trav_time"]].add(idx);
    } else {
      trav_time[i["trav_time"]] = <int>[];
      trav_time[i["trav_time"]].add(idx);
    }
    for (var j in i["tags"]) {
      if (!tags.contains(j)) tags.add(j);
      if (tag.containsKey(j)) {
        tag[j].add(idx);
      } else {
        tag[j] = [];
        tag[j].add(idx);
      }
    }
    var tmp = await ReadCaches(i["name"]);
    if (tmp!.isEmpty) {
      WriteCaches(i["name"], '0');
    } else {
      if (tmp == '1') liked.add(idx);
      print("asdfasdf $tmp");
    }
    print(await ReadCaches(i["name"]));
    print(i["name"]);

    idx++;
  }
  print("즐찾 $liked");
  return 0;
}

Future<int> init(CounterStorage cs) async {
  print(recentSearches.length);
  bool result = await InternetConnection().hasInternetAccess;
  var cache = await ReadCaches('recentSearches'); // recentSearches 초기화
  if (cache!.isNotEmpty) {
    recentSearches = cache.split('\n');
  }
  print(recentSearches.length);
  if (result == true) {
    print("Internet Connected");
    try {
      /*
        fetch data from firebase
      */
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      print("Firebase Initialized");
      final datapath = FirebaseStorage.instance
          .refFromURL("gs://foodduck-23ca8.appspot.com/output.json");
      try {
        const oneMegabyte = 1024 * 1024;
        final data = await datapath.getData(oneMegabyte);
        final String fooddata = utf8.decode(data!);
        print(fooddata);

        await InitCaches('food');
        await WriteCaches('food', fooddata);

        listfood = jsonDecode(fooddata);
        print(listfood);
        await makelist(listfood);
        // Data for "images/island.jpg" is returned, use this as needed.
      } on FirebaseException catch (e) {
        print("{$e}");
        // Handle any errors.
      }

      InitCaches('recentSearches');

      return 0;
    } catch (e) {
      //로컬 파일이 없어서 생기는 오류(PathNotFoundException).
      print("Error : $e");
      return -1;
    }
  } else {
    try {
      /*
        fetch data from firebase
      */
      print("internet not found");
      try {
        if (await InitCaches('food') == 0) {
          throw 'data not found';
        }
        final String? fooddata = await ReadCaches('food');
        listfood = jsonDecode(fooddata!);
        await makelist(listfood);
      } on FirebaseException catch (e) {
        print("{$e}");
        // Handle any errors.
      }
      return 0;
    } catch (e) {
      print("Local Error : $e");
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
