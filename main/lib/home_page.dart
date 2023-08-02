import 'package:flutter/material.dart';
import 'drawer.dart';
import 'search_page.dart';

class HomePage extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      endDrawer: const SafeArea(
        child: Drawer(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50), bottomLeft: Radius.circular(50)),
          ),
          child: CustomDrawer(), // CustomDrawer 위젯 사용
        ),
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
                'assets/images/logo.jpg', //협의수정필요
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SearchPage()),
                      );
                    },
                    child: Container(
                      //검색창 (실시간 반영,제안:onChanged()/TextField)
                      height: 45,
                      width: 320,
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
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
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
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "I’m Feeling Hungry",
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'NanumSquareB.ttf', //협의수정필요
                    fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
