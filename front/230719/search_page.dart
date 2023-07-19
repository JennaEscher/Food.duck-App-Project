import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: MediaQuery.of(context).size.width,
        toolbarHeight: 80,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Row(
          //뒤로가기 화살표를 지우고 검색창 중앙->leading 지우고 title
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              //검색창 (실시간 반영,제안:onChanged()/TextField)
              height: 45,
              width: 330,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.amber,
                    width: 3,
                  ),
                  borderRadius: BorderRadius.circular(50)),
              child: const SizedBox(
                height: 35,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: 10),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: TextField(
                          maxLines: 1,
                          decoration: InputDecoration(
                            hintText: 'Search',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.search,
                        size: 20,
                        color: Colors.black,
                      ),
                      onPressed: null,
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
            Container(
              //최근검색어 개수 제한 필요
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.amber,
                ),
              ),
              child: const Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  children: [
                    Text(
                      '태그 검색', //기능에 대한 논의 필요
                      style: TextStyle(
                        fontSize: 25,
                        fontFamily: 'NanumSquareB.ttf',
                      ),
                    ),
                  ],
                ),
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
                  Container(
                      height: 30,
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width,
                      ),
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 210, 210, 210),
                          border: Border.all(
                            color: const Color.fromARGB(255, 210, 210, 210),
                            width: 3,
                          ),
                          borderRadius: BorderRadius.circular(50)),
                      alignment: Alignment.center,
                      child: const Text(
                        '#datadatadatadata',
                      )),
                  Container(
                      height: 30,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 210, 210, 210),
                          border: Border.all(
                            color: const Color.fromARGB(255, 210, 210, 210),
                            width: 3,
                          ),
                          borderRadius: BorderRadius.circular(50)),
                      alignment: Alignment.center,
                      child: const Text(
                        '#datadata',
                      )),
                  Container(
                      height: 30,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 210, 210, 210),
                          border: Border.all(
                            color: const Color.fromARGB(255, 210, 210, 210),
                            width: 3,
                          ),
                          borderRadius: BorderRadius.circular(50)),
                      alignment: Alignment.center,
                      child: const Text(
                        '#datadatadatadata',
                      )),
                  Container(
                      height: 30,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 210, 210, 210),
                          border: Border.all(
                            color: const Color.fromARGB(255, 210, 210, 210),
                            width: 3,
                          ),
                          borderRadius: BorderRadius.circular(50)),
                      alignment: Alignment.center,
                      child: const Text(
                        '#data',
                      )),
                  Container(
                      height: 30,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 210, 210, 210),
                          border: Border.all(
                            color: const Color.fromARGB(255, 210, 210, 210),
                            width: 3,
                          ),
                          borderRadius: BorderRadius.circular(50)),
                      alignment: Alignment.center,
                      child: const Text(
                        '#datadatadata',
                      ))
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.amber,
                ),
              ),
              child: const Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  children: [
                    Text(
                      '최근 검색', //로컬 파일, 최대저장개수지정필요
                      style: TextStyle(
                        fontSize: 25,
                        fontFamily: 'NanumSquareB.ttf',
                      ),
                    ),
                  ],
                ),
              ),
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
