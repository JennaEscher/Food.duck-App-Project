import 'package:flutter/material.dart';
import 'drawer.dart';

class Food {
  String? foodname;
  Food();
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return MaterialApp(
      home: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        appBar: AppBar(
          //drawer기능 때문에 Appbar 필요
          toolbarHeight: 60,
          backgroundColor: Colors.transparent,
          elevation: 0, // 그림자
          actions: [
            Padding(
              padding: const EdgeInsets.only(
                  right: 30.0), //top:10 하거나 Appbar의 height올릴수도 있음
              child: IconButton(
                icon: const Icon(
                  Icons.menu,
                  color: Colors.black,
                  size: 40,
                ),
                onPressed: () {
                  scaffoldKey.currentState?.openEndDrawer();
                },
              ),
            ),
          ],
        ),
        endDrawer: const Drawer(
          child: CustomDrawer(), // CustomDrawer 위젯 사용
        ),
        body: Padding(
          padding: const EdgeInsets.all(30),
          child: SingleChildScrollView(
            //34픽셀 오버플로우 때문(키보드올라오는것과 관련)
            child: Column(
              children: [
                const SizedBox(
                  height: 120,
                ),
                Image.asset(
                  'assets/images/icon.png',
                  height: 100,
                  width: 100,
                ),
                const SizedBox(
                  height: 10,
                ),
                Image.asset(
                  'assets/images/logo.jpg',
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Align(
                        child: Container(
                          //검색창 (실시간 반영,제안:onChanged()/TextField)
                          height: 40,
                          width: 320,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.amber,
                                width: 3,
                              ),
                              borderRadius: BorderRadius.circular(50)),
                          child: SizedBox(
                            height: 35,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: TextField(
                                      onChanged: (value) {
                                        // 검색어 변경 시 처리 로직 추가
                                      },
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      maxLines: 1,
                                      decoration: const InputDecoration(
                                        //hintText: '검색어를 입력하세요',
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.search,
                                    size: 20,
                                  ),
                                  onPressed: () {
                                    // 검색 기능 구현
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "I’m Feeling Hungry",
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
