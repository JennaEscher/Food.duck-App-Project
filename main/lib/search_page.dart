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
    recentSearches.forEach((element) => print(element));
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
    if(resultlist.isEmpty){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => NotFound()),
      );
    }else{
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => searchList(resultlist, "검색 결과")),
      );
    }
  }

  void clickRecentSearches() {
    //최근검색어 눌렀을 때
    changeSearchTerm(searchText, [], []);
    //검색어, 태그리스트, 최근검색어리스트를 다른 페이지로 넘기기

    if(resultlist.isEmpty){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => NotFound()),
      );
    }else{
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => searchList(resultlist, "검색 결과")),
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
    } else {
      terms = list;
    }
    print(terms);
    List<int> tmp = [];
    for (var i in terms) {
      tmp.add(name[i]);
    }
    print("idx $tmp");
    resultlist = tmp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: MediaQuery.of(context).size.width,
        toolbarHeight: 80,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              //검색창
              height: 45,
              width: MediaQuery.of(context).size.width -40,
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
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
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
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.bottomCenter,
                child: IconButton(
                  icon: const Icon(
                    Icons.close,
                    color: Colors.black,
                    size: 30,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
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
                            isSelectedCate[i] = !isSelectedCate[i];
                            clickCategoryBottons(i);
                          },
                          child: Text(categorys[i]),
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
                            isSelected[i] = !isSelected[i];
                            clickTagBottons(i);
                          },
                          child: Text(tags[i]),
                        ),
                      ),
                  ],
                ),
              ),
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
            ],
          ),
        ),
      ),
    );
  }
}
