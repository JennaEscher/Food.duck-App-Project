import 'package:flutter/material.dart';
import 'package:text_scroll/text_scroll.dart';
import 'package:url_launcher/url_launcher.dart';
import 'drawer.dart';
import 'widget.dart'; //appBar
import 'back/data_fetch.dart';

class resultlist extends StatefulWidget {
  final Idx;
  const resultlist(this.Idx);

  @override
  Result createState() => Result();
}

class Result extends State<resultlist> {
  var Index;
  late String storeName;
  late String menu;
  late String position;
  // String pricelevel = "1,000,000원 대";
  late String description;
  late String? storeimage;
  late List<dynamic> foodtag;
  late String? tagstring;
  late Image img;
  late String maplink;

  void initState() {
    Index = widget.Idx;
    storeName = listfood[Index]["name"];
    menu = listfood[Index]["category"];
    position = listfood[Index]["address"];
    description = listfood[Index]["OneLiner"];
    storeimage = listfood[Index]["image"];
    foodtag = List.generate(listfood[Index]["tags"].length,
            (index) => '#${listfood[Index]["tags"][index]}');
    tagstring = foodtag.join(" ");
    img = Image.network(
      storeimage!,
    );
    maplink = listfood[Index]["MapLink"];
    super.initState();
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  _launchURL() async {
    Uri _url = Uri.parse(maplink);
    if (await launchUrl(_url)) {
      await launchUrl(_url);
    } else {
      throw 'Could not launch $_url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
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
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: TextScroll(
                        storeName,
                        velocity: Velocity(pixelsPerSecond: Offset(30, 0)),
                        pauseBetween: Duration(milliseconds: 1000),
                        mode: TextScrollMode.bouncing,
                        fadedBorder: true,
                        fadeBorderVisibility: FadeBorderVisibility.auto,
                        fadeBorderSide: FadeBorderSide.right,
                        style: TextStyle(
                          fontSize: 36,
                          fontFamily: "NanumSquare_ac",
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        liked.contains(Index) ? Icons.star : Icons.star_border,
                        color: liked.contains(Index) ? Colors.amberAccent : null,
                        semanticLabel: liked.contains(Index)
                            ? 'Remove from saved'
                            : 'Save',
                        size: 36,
                      ),
                      onPressed: () async {
                        int flag = 0;
                        if (liked.contains(Index)) {
                          flag = 1;
                          await WriteCaches(listfood[Index]["name"], '0');
                        } else {
                          flag = 0;
                          await WriteCaches(listfood[Index]["name"], '1');
                        }
                        setState(() {
                          if (flag == 1) {
                            liked.remove(Index);
                          } else {
                            liked.add(Index);
                          }
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.transparent),
                ),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topCenter,
                      width: double.infinity,
                      margin: const EdgeInsets.fromLTRB(12, 20, 12, 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: img,
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 23),
                      child: Text(
                        tagstring!,
                        textAlign: TextAlign.justify,
                        style: const TextStyle(
                          fontSize: 16,
                          fontFamily: "NanumSquare_ac",
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.all(0),
                      margin: const EdgeInsets.fromLTRB(23, 10, 23, 5),
                      child: RichText(
                        text: TextSpan(
                            children: [
                              const TextSpan(
                                  text: "메뉴: ",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: "NanumSquare_ac",
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                    height: 1.5,
                                  )
                              ),
                              TextSpan(
                                  text: '$menu\n',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontFamily: "NanumSquare_ac",
                                    fontWeight: FontWeight.w200,
                                    color: Colors.black,
                                    height: 1.5,
                                  )
                              ),
                              const TextSpan(
                                  text: "위치: ",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: "NanumSquare_ac",
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                    height: 1.5,
                                  )
                              ),
                              TextSpan(
                                  text: '$position',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontFamily: "NanumSquare_ac",
                                    fontWeight: FontWeight.w200,
                                    color: Colors.black,
                                    height: 1.5,
                                  )
                              ),
                            ]
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: _launchURL,
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.redAccent.shade200, // Text Color
                      ),
                      child: const Text(
                        '식당 위치 지도로 보기',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: "NanumSquare_ac",
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white,
                      ),
                      alignment: Alignment.center,
                      width: double.infinity,
                      margin: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      child: Text(
                        description,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 18,
                          fontFamily: "NanumSquare_ac",
                          fontWeight: FontWeight.w400,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}