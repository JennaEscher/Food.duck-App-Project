import 'package:flutter/material.dart';
import 'back/data_fetch.dart';
import 'package:korea_regexp/korea_regexp.dart';
import 'result_page.dart';
import 'not_found.dart';
import 'widget.dart';
import 'drawer.dart';

class SearchRecent extends StatefulWidget {
  const SearchRecent({Key? key}) : super(key: key);

  @override
  SearchPageState createState() => SearchPageState();
}

class SearchPageState extends State<SearchRecent> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    WriteCaches('recentSearches', recentSearches.join('\n'));
    _searchController.dispose();
    super.dispose();
  }

  void clickTagBottons(int tag) {
    setState(() {
      // selectedTags = []; //[](빈 리스트)로 수정 예정
      // for (int i = 0; i < isSelected.length; i++) {
      //   if (isSelected[i]) {
      //     selectedTags.add(tags[i].substring(0)); //#제외
      //   }else{
      //     selectedTags.remove(tags[i].substring(0));
      //   }
      // }
      if (isSelected[tag]) {
        selectedTags.add(tags[tag]);
      } else {
        selectedTags.remove(tags[tag]);
      }
    });
  }

  void clickCategoryBottons(int cate) {
    setState(() {
      // selectedCates = []; //[](빈 리스트)로 수정 예정
      // for (int i = 0; i < isSelectedCate.length; i++) {
      //   if (isSelectedCate[i]) {
      //     selectedCates.add(cate[i].substring(0)); //#제외
      //   }else{
      //     selectedCates.remove(cate[i].substring(0));
      //   }
      // }
      if (isSelectedCate[cate]) {
        selectedCates.add(categorys[cate]);
      } else {
        selectedCates.remove(categorys[cate]);
      }
    });
  }

  List<bool> isSelected = []; //태그들 선택여부 리스트
  List<String> selectedTags = []; //선택된태그 리스트
  List<bool> isSelectedCate = []; //카테고리 선택여부 리스트
  List<String> selectedCates = []; //선택된카테고리 리스트
  String searchText = '';
  List<int> resultlist = [];

  @override
  void initState() {
    super.initState();
    isSelected = List.generate(tags.length, (index) => false); // isSelected 초기화
    isSelectedCate =
        List.generate(categorys.length, (index) => false); // isSelectedCate 초기화
    resultlist = [];
  }

  void _submitSearch() async {
    // 검색어 리스트가 5개 이상이면 가장 오래된 검색어 삭제
    if (recentSearches.length >= 15) {
      recentSearches.removeLast();
    }
    for (var element in recentSearches) {
      print(element);
    }
    setState(() {
      searchText = _searchController.text.trim();
      setState(() {
        // 최근 검색어 리스트에 새로운 검색어 추가
        if (searchText.isNotEmpty && !recentSearches.contains(searchText)) {
          recentSearches.insert(0, searchText);
        }
      });
    });
    // 최근 검색어 리스트를 캐시에 저장
    WriteCaches('recentSearches', recentSearches.join('\n'));
    // 검색 기능을 구현하는 로직을 추가

    changeSearchTerm(searchText, selectedTags, selectedCates);
    //검색어, 태그리스트, 최근검색어리스트를 다른 페이지로 넘기기
    if (resultlist.isEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => NotFound()),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => searchList(resultlist, "검색 결과")),
      );
    }
  }

  void clickRecentSearches() {
    //최근검색어 눌렀을 때
    changeSearchTerm(searchText, [], []);
    //검색어, 태그리스트, 최근검색어리스트를 다른 페이지로 넘기기

    if (resultlist.isEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => NotFound()),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => searchList(resultlist, "검색 결과")),
      );
    }
    //클릭한 최근검색어, 빈 태그리스트, 최근검색어리스트를 다른 페이지로 넘기기
  }

  void _removeSearchKeyword(String keyword) {
    setState(() {
      recentSearches.remove(keyword);
    });
    WriteCaches('recentSearches', recentSearches.join('\n'));
  }

  List<String> tag_check(List<String> tags, List<String> cate) {
    List<String> result = [];
    List<int> tmp = Iterable<int>.generate(listfood.length).toList();
    for (int i = 0; i < tags.length; i++) {
      tmp.removeWhere((item) => !tag[tags[i]].contains(item));
    }
    for (int i = 0; i < cate.length; i++) {
      tmp.removeWhere((item) => !category[cate[i]].contains(item));
    }
    for (int i = 0; i < tmp.length; i++) {
      result.add(listfood[tmp[i]]["name"]);
    }
    return result;
  }

  void changeSearchTerm(String text, List<String> tags, List<String> cate) {
    print("태그 $tags");
    print("카테고리 $cate");
    List<String> list = tag_check(tags, cate);
    late List<String> terms;
    List<int> tmp = [];
    print("리스트 $list");
    if (text.isNotEmpty) {
      RegExp regExp = getRegExp(
          text,
          RegExpOptions(
            initialSearch: true,
            startsWith: false,
            endsWith: false,
            fuzzy: false,
            ignoreSpace: true,
            ignoreCase: false,
          ));
      print(regExp);
      terms = list.where((element) => regExp.hasMatch(element)).toList();
      print(terms);
      for (var i in terms) {
        tmp.add(name[i]);
      }

      var catlist = category.keys.toList();
      List<dynamic> textcat =
          catlist.where((element) => regExp.hasMatch(element)).toList();
      for (var i in textcat) {
        for (var idx in category[i]) {
          if (!tmp.contains(idx)) {
            tmp.add(idx);
          }
        }
      }
      var taglist = tag.keys.toList();
      List<dynamic> texttag =
          taglist.where((element) => regExp.hasMatch(element)).toList();
      for (var i in texttag) {
        for (var idx in tag[i]) {
          if (!tmp.contains(idx)) {
            tmp.add(idx);
          }
        }
      }
      resultlist = tmp;
    } else {
      for (var restaurantname in list) {
        tmp.add(name[restaurantname]);
      }
      resultlist = tmp;
    }
    print("idx $resultlist");
  }

  Widget buildWidget(double width) {
    if (width < 1000) {
      return Container(
          // Container 위젯 설정
          );
    } else {
      return const SizedBox(
          // SizedBox 위젯 설정
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenwidth = MediaQuery.of(context).size.width;

    return Scaffold(
      key: scaffoldKey,
      appBar: CustomAppBar(scaffoldKey: scaffoldKey),
      endDrawer: const SafeArea(
        child: Drawer(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50), bottomLeft: Radius.circular(50)),
          ),
          child: CustomDrawer(), // CustomDrawer 위젯 사용
        ),
      ),
      body: ListView(
        children: [
          const titleSection("일반 검색"),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 25),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    //검색창
                    height: 45,
                    width: screenwidth < 600 ? screenwidth - 80 : 520,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.amber,
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: SizedBox(
                      height: 35,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(width: 10),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: TextField(
                                controller: _searchController,
                                maxLines: 1,
                                decoration: const InputDecoration(
                                  hintText: 'Search',
                                  border: InputBorder.none,
                                  isCollapsed: true,
                                ),
                                onSubmitted: (value) {
                                  _submitSearch(); // 엔터를 입력했을 때 동작
                                },
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.search,
                              size: 20,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              _submitSearch();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SingleChildScrollView(
                    child: SizedBox(
                      width: screenwidth < 600 ? screenwidth - 80 : 520,
                      child: Column(
                        children: [
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Column(
                              children: [
                                Text(
                                  '최근 검색',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: "NanumSquare_ac",
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ListView(
                            shrinkWrap: true, // ListView 크기를 내용에 맞게 조절
                            children: [
                              for (int i = 0;
                                  i < recentSearches.length && i < 8;
                                  i++)
                                Container(
                                  height: 35,
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              searchText = recentSearches[i];
                                            });
                                            clickRecentSearches();
                                          },
                                          child: Text(
                                            recentSearches[i],
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        icon: const Icon(
                                          Icons.close,
                                          size: 15,
                                          color: Colors.black,
                                        ),
                                        onPressed: () {
                                          _removeSearchKeyword(
                                              recentSearches[i]);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
