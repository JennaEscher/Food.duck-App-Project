import 'package:flutter/material.dart';
import 'drawer.dart';
import 'widget.dart'; //appBar

class Result extends StatelessWidget {
  Result({super.key});

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    //스트링 예시 리스트에서 각 변수로 넣으면 동작함
    String storeName = "또솥";
    String menu = "인간사료 - 한솥";
    String position = "서강고등학교";
    String pricelevel = "1,000,000원 대";
    String description = "사각형 안의 사각형 안의 사각형 안의 사각형이 있소 열 두명의 아해가 두렵다고 그러오";
    String? storeimage;
    String? tagstring;

    tagstring = "#임의태그 #예시태그";
    storeimage = 'assets/images/sample.png'; //가게 이미지 경로 어떻게 넘어오는지 몰라서 일단 이렇게

    const String letterstyle = 'NanumSquareB.ttf';

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      appBar: CustomAppBar(scaffoldKey: scaffoldKey),
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
        //스크롤(열(컨테이너(행(가게이름,오리아이콘)),컨테이너(열(가게사진,설명,컨테이너(짧은설명문))))) 형태로 구성됨
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(storeName,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                            fontSize: 35,
                            fontFamily: letterstyle,
                            fontWeight: FontWeight.bold)),
                    IconButton(
                      icon: const Icon(
                        Icons.star,
                        color: Color.fromRGBO(220, 220, 220, 1),
                        size: 50,
                      ),
                      onPressed: () {
                        //좋아요 표시 작동
                      },
                    ),
                  ],
                ),
              ),
              Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: const Color.fromRGBO(243, 243, 243, 1),
                  ),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.topCenter,
                        width: double.infinity,
                        //color: const Color.fromRGBO(0, 0,0, 1),
                        margin: const EdgeInsets.fromLTRB(10, 15, 10, 10),

                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Image.asset(
                            storeimage,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        margin: const EdgeInsets.symmetric(horizontal: 30),
                        child: Text(tagstring,
                            textAlign: TextAlign.justify,
                            style: const TextStyle(
                                fontSize: 20 - 4,
                                fontFamily: letterstyle,
                                color: Color.fromRGBO(180, 180, 180, 1))),
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        margin: const EdgeInsets.fromLTRB(30, 20, 30, 0),
                        child: RichText(
                            text: TextSpan(children: <TextSpan>[
                          const TextSpan(
                            text: "메뉴: ",
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: letterstyle,
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(0, 0, 0, 1)),
                          ),
                          TextSpan(
                              text: '$menu\n',
                              style: const TextStyle(
                                fontSize: 20,
                                fontFamily: letterstyle,
                                color: Color.fromRGBO(0, 0, 0, 1),
                              )),
                          const TextSpan(
                              text: '\n',
                              style: TextStyle(
                                fontSize: 5,
                                fontFamily: letterstyle,
                                color: Color.fromRGBO(0, 0, 0, 1),
                              )),
                          const TextSpan(
                            text: "위치: ",
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: letterstyle,
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(0, 0, 0, 1)),
                          ),
                          TextSpan(
                              text: '$position\n',
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontFamily: letterstyle,
                                  color: Color.fromRGBO(0, 0, 0, 1))),
                          const TextSpan(
                              text: '\n',
                              style: TextStyle(
                                fontSize: 5,
                                fontFamily: letterstyle,
                                color: Color.fromRGBO(0, 0, 0, 1),
                              )),
                          const TextSpan(
                            text: "가격대: ",
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: letterstyle,
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(0, 0, 0, 1)),
                          ),
                          TextSpan(
                              text: '$pricelevel\n',
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontFamily: letterstyle,
                                  color: Color.fromRGBO(0, 0, 0, 1)))
                        ])),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: const Color.fromRGBO(255, 255, 255, 1),
                        ),
                        alignment: Alignment.center,
                        width: double.infinity,
                        height: 120,
                        margin: const EdgeInsets.fromLTRB(20, 0, 20, 25),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 15),
                        child: Text(description,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 20 - 2,
                              fontFamily: letterstyle,
                            )),
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
