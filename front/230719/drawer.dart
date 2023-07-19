import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 30.0),
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
                onTap: () {},
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
                onTap: () {},
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
                onTap: () {},
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
                onTap: () {},
              ),
              const SizedBox(height: 20),
              ListTile(
                title: const Text(
                  'Info',
                  style: TextStyle(fontSize: 30),
                ),
                onTap: () {},
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
                child: Image.asset(
                  'assets/images/icon.png',
                  height: 50,
                  width: 50,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
