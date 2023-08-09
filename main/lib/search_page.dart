import 'package:flutter/material.dart';

//입력: 태그리스트, 최근검색어리스트, 출력://검색어, 태그리스트, 최근검색어리스트
class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  SearchPageState createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<String> tags = [
    '#한식',
    '#양식',
    '#일식',
    '#중식',
    '#아침',
    '#점심',
    '#저녁',
    '#주점',
    '#간식',
    '#소개팅',
    '#노브레이크타임',
    '#한식',
    '#혼밥가능',
    '#신촌역',
    '#대흥',
    '#후문',
    '#정문',
    '#남문',
    '#밥약추천'
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void clickTagBottons(String tag) {
    setState(() {
      selectedTags = ['선택된 태그:']; //[](빈 리스트)로 수정 예정
      for (int i = 0; i < isSelected.length; i++) {
        if (isSelected[i]) {
          selectedTags.add(tags[i].substring(1)); //#제외
        }
      }
    });
  }

  List<bool> isSelected = []; //태그들 선택여부 리스트
  List<String> selectedTags = ['선택된 태그:']; //선택된태그 리스트
  String searchText = '';
  List<String> recentSearches = []; //최근검색어 리스트

  @override
  void initState() {
    super.initState();
    isSelected = List.generate(tags.length, (index) => false); // isSelected 초기화
  }

  void _submitSearch() {
    setState(() {
      searchText = _searchController.text.trim();
      setState(() {
        // 최근 검색어 리스트에 새로운 검색어 추가
        if (searchText.isNotEmpty && !recentSearches.contains(searchText)) {
          recentSearches.insert(0, searchText);
        }
      });
    });
    // 검색 기능을 구현하는 로직을 추가
    //검색어, 태그리스트, 최근검색어리스트를 다른 페이지로 넘기기
  }

  void clickRecentSearches() {
    //최근검색어 눌렀을 때

    //클릭한 최근검색어, 빈 태그리스트, 최근검색어리스트를 다른 페이지로 넘기기
  }

  void _removeSearchKeyword(String keyword) {
    setState(() {
      recentSearches.remove(keyword);
    });
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
              width: 330,
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
        child: Column(
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
                          clickTagBottons(tags[i]);
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
            Row(
                //검색어 확인용, 지울 부분
                children: [Text('검색어: $searchText')]),
            const SizedBox(
              height: 30,
            ),
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
          ],
        ),
      ),
    );
  }
}