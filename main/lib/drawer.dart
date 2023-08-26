import 'package:flutter/material.dart';
import 'home_page.dart';
import 'search_page.dart';
import 'info.dart';
import 'rand_condition.dart';
import 'result.dart';
import 'result_page.dart';
import 'back/data_fetch.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: AppBar(
            toolbarHeight: 60,
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.close,
                  size: 40,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.pop(context); // 드로어 닫기
                },
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(30),
            children: [
              ListTile(
                title: const Text(
                  '홈',
                  style: TextStyle(
                    fontSize: 30,
                    fontFamily: 'NanumSquareB.ttf',
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                },
              ),
              const SizedBox(height: 20),
              ListTile(
                title: const Text(
                  '랜덤 추천',
                  style: TextStyle(
                    fontSize: 30,
                    fontFamily: 'NanumSquareB.ttf',
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RandCondition()),
                  );
                },
              ),
              const SizedBox(height: 20),
              ListTile(
                title: const Text(
                  '검색',
                  style: TextStyle(
                    fontSize: 30,
                    fontFamily: 'NanumSquareB.ttf',
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SearchPage()),
                  );
                },
              ),
              const SizedBox(height: 20),
              ListTile(
                title: const Text(
                  '즐겨찾기',
                  style: TextStyle(
                    fontSize: 30,
                    fontFamily: 'NanumSquareB.ttf',
                  ),
                ),
                onTap: () {
                  Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => searchList(liked,"즐겨찾기")),
                  );
                },
              ),
              const SizedBox(height: 20),
              ListTile(
                title: const Text(
                  'Info',
                  style: TextStyle(fontSize: 30),
                ),
                onTap: () {
                  Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Info()),
                  );
                },
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(30),
          child: SizedBox(
            height: 100,
            child: Align(
              alignment: Alignment.bottomRight,
              child: Container(
                padding: const EdgeInsets.all(0),
                child: InkWell(
                  onTap: () {
                    // 여기에 이미지가 눌렸을 때 다른 페이지로 이동하는 코드를 작성합니다.
                    // 예를 들면:
                    /*
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Result()),
                    );*/
                  },
                  child: Image.asset(
                    'assets/images/icon.png',
                    height: 50,
                    width: 50,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
