import 'package:flutter/material.dart';
import 'home_page.dart';
import 'info.dart';
import 'rand_condition.dart';
import 'result_page.dart';
import 'back/data_fetch.dart';
import 'search_recent.dart';
import 'search_tag.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Column(
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
              Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  children: [
                    ListTile(
                      title: const Text(
                        '홈',
                        style: TextStyle(
                          fontSize: 25,
                          fontFamily: 'NanumSquare_ac',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        if (ModalRoute.of(context)!.settings.name != '/') {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomePage()),
                              ((route) => false));
                        }
                      },
                    ),
                    const SizedBox(height: 15),
                    ListTile(
                      title: const Text(
                        '랜덤 추천',
                        style: TextStyle(
                          fontSize: 25,
                          fontFamily: 'NanumSquare_ac',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RandCondition()),
                        );
                      },
                    ),
                    const SizedBox(height: 15),
                    ListTile(
                      title: const Text(
                        '태그 검색',
                        style: TextStyle(
                          fontSize: 25,
                          fontFamily: 'NanumSquare_ac',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SearchTag()),
                            ((route) => route.settings.name == '/'));
                      },
                    ),
                    const SizedBox(height: 15),
                    ListTile(
                      title: const Text(
                        '일반 검색',
                        style: TextStyle(
                          fontSize: 25,
                          fontFamily: 'NanumSquare_ac',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SearchRecent()),
                            ((route) => route.settings.name == '/'));
                      },
                    ),
                    const SizedBox(height: 15),
                    ListTile(
                      title: const Text(
                        '즐겨찾기',
                        style: TextStyle(
                          fontSize: 25,
                          fontFamily: 'NanumSquare_ac',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    searchList(liked, "즐겨찾기")),
                            ((route) => route.settings.name == '/'));
                      },
                    ),
                    const SizedBox(height: 15),
                    ListTile(
                      title: const Text(
                        'Info',
                        style: TextStyle(
                          fontSize: 25,
                          fontFamily: 'NanumSquare_ac',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => Info()),
                            ((route) => route.settings.name == '/'));
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(30),
                child: SizedBox(
                  height: 50,
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      padding: const EdgeInsets.all(0),
                      child: InkWell(
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
          ),
        ],
      ),
    );
  }
}
