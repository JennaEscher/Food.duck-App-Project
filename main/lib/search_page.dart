import 'package:flutter/material.dart';
import 'back/data_fetch.dart';
import 'package:korea_regexp/korea_regexp.dart';
import 'result_page.dart';
import 'not_found.dart';

//입력: 태그리스트, 최근검색어리스트, 출력://검색어, 태그리스트, 최근검색어리스트
class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  SearchPageState createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
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
    if (recentSearches.length >= 5) {
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

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    if (width < 1000) {
      return Scaffold(
        appBar: AppBar(
          leadingWidth: MediaQuery.of(context).size.width,
          toolbarHeight: 80,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 45,
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    size: 30,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Container(
                //검색창
                height: 45,
                width: MediaQuery.of(context).size.width - 80,
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
                          padding: const EdgeInsets.symmetric(horizontal: 10),
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
                width: 15,
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 25),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    children: [
                      Text(
                        '최근 검색',
                        style: TextStyle(
                            fontSize: 28,
                            fontFamily: "NanumSquare_ac",
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
                ListView(
                  shrinkWrap: true, // ListView 크기를 내용에 맞게 조절
                  children: [
                    for (int i = 0; i < recentSearches.length && i < 5; i++)
                      Container(
                        height: 35,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    searchText = recentSearches[i];
                                  });
                                  clickRecentSearches();
                                }
                                ,
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
                                _removeSearchKeyword(recentSearches[i]);
                              },
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    children: [
                      Text(
                        '태그 검색',
                        style: TextStyle(
                            fontSize: 28,
                            fontFamily: "NanumSquare_ac",
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Wrap(
                    spacing: 15,
                    runSpacing: 10,
                    children: [
                      for (int i = 0; i < categorys.length; i++)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: isSelectedCate[i]
                                ? Colors.amber[300]
                                : const Color.fromARGB(255, 210, 210, 210),
                            border: Border.all(
                              color: isSelectedCate[i]
                                  ? const Color.fromARGB(255, 255, 213, 79)
                                  : const Color.fromARGB(255, 210, 210, 210),
                              width: 3,
                            ),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => searchList(category[categorys[i]], categorys[i])),
                              );
                            },
                            child: Text(
                              categorys[i],
                              style: const TextStyle(
                                fontSize: 16,
                                fontFamily: "NanumSquare_ac",
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      for (int i = 0; i < tags.length; i++)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: isSelected[i]
                                ? Colors.amber[300]
                                : const Color.fromARGB(255, 210, 210, 210),
                            border: Border.all(
                              color: isSelected[i]
                                  ? const Color.fromARGB(255, 255, 213, 79)
                                  : const Color.fromARGB(255, 210, 210, 210),
                              width: 3,
                            ),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => searchList(tag[tags[i]], tags[i])),
                              );
                            },
                            child: Text(
                              tags[i],
                              style: const TextStyle(
                                fontSize: 16,
                                fontFamily: "NanumSquare_ac",
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                /*
              SizedBox(
                //태그리스트 확인용, 지울 부분
                child: Row(
                  children: [
                    for (String tag in selectedTags)
                      Container(
                        margin: const EdgeInsets.only(right: 1),
                        padding: const EdgeInsets.all(1),
                        child: Text(tag),
                      ),
                  ],
                ),
              ),
              */
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          leadingWidth: MediaQuery.of(context).size.width,
          toolbarHeight: 80,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 45,
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    size: 30,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Container(
                //검색창
                height: 45,
                width: MediaQuery.of(context).size.width * 0.4,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.amber,
                    width: 3,
                  ),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 10),
                    Expanded(
                      child: SizedBox(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: TextField(
                            textAlignVertical: TextAlignVertical.center,
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
              const SizedBox(
                width: 15,
              ),
            ],
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.05),
          child: SingleChildScrollView(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  height: MediaQuery.of(context).size.height * 0.85,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            children: [
                              Text(
                                '태그 검색',
                                style: TextStyle(
                                  fontSize: 25,
                                  fontFamily: 'NanumSquareB.ttf',
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Wrap(
                            spacing: 15,
                            runSpacing: 10,
                            children: [
                              for (int i = 0; i < categorys.length; i++)
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  decoration: BoxDecoration(
                                    color: isSelectedCate[i]
                                        ? Colors.amber[300]
                                        : const Color.fromARGB(
                                            255, 210, 210, 210),
                                    border: Border.all(
                                      color: isSelectedCate[i]
                                          ? const Color.fromARGB(
                                              255, 255, 213, 79)
                                          : const Color.fromARGB(
                                              255, 210, 210, 210),
                                      width: 3,
                                    ),
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => searchList(category[categorys[i]], categorys[i])),
                                      );
                                    },
                                    child: Text(categorys[i]),
                                  ),
                                ),
                              for (int i = 0; i < tags.length; i++)
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  decoration: BoxDecoration(
                                    color: isSelected[i]
                                        ? Colors.amber[300]
                                        : const Color.fromARGB(
                                            255, 210, 210, 210),
                                    border: Border.all(
                                      color: isSelected[i]
                                          ? const Color.fromARGB(
                                              255, 255, 213, 79)
                                          : const Color.fromARGB(
                                              255, 210, 210, 210),
                                      width: 3,
                                    ),
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => searchList(tag[tags[i]], tags[i])),
                                      );
                                    },
                                    child: Text(tags[i]),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.2,
                  height: MediaQuery.of(context).size.height * 0.85,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            children: [
                              Text(
                                '최근 검색',
                                style: TextStyle(
                                  fontSize: 25,
                                  fontFamily: 'NanumSquareB.ttf',
                                ),
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
                                i < recentSearches.length && i < 5;
                                i++)
                              Container(
                                height: 35,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
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
                                        _removeSearchKeyword(recentSearches[i]);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
