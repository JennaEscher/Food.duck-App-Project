import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  SearchPageState createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  final List<String> tags = [
    '#한식', '#양식', '#일식', '#중식', '#아침', '#점심', '#저녁', '#술약속',
    '#짧은태그3', '#몹시매우미칠듯이긴태그',
    '#한식', '#혼밥가능', '#신촌역', '#대흥', '#후문', '#정문', '#남문',
    // ... 다른 태그들 추가 ...
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _addTagToSearchBar(String tag) {
    setState(() {
      _searchController.text += "$tag ";
    });
  }

  String searchText = '';
  List<String> recentSearches = [];

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
    // 검색 기능을 구현하는 로직을 추가 or 검색어를 다른 페이지로 넘기기
    // 검색어 넘기면서 페이지 이동하는 코드작성
  }

  void _removeSearchKeyword(String keyword) {
    setState(() {
      recentSearches.remove(keyword);
    });
  }

  String _truncateWithEllipsis(String text, int maxLength) {
    if (text.length > maxLength) {
      return '${text.substring(0, maxLength - 3)}...';
    }
    return text;
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
                        color: const Color.fromARGB(255, 210, 210, 210),
                        border: Border.all(
                          color: const Color.fromARGB(255, 210, 210, 210),
                          width: 3,
                        ),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: InkWell(
                        onTap: () {
                          _addTagToSearchBar(tags[i]);
                        },
                        child: Text(tags[i]),
                      ),
                    ),
                ],
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
                        InkWell(
                          onTap: () {
                            _addTagToSearchBar(recentSearches[i]);
                          },
                          child: Text(
                            _truncateWithEllipsis(recentSearches[i], 24),
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
