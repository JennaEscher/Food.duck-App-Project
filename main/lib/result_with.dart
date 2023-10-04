import 'package:flutter/material.dart';
import 'package:text_scroll/text_scroll.dart';
import 'drawer.dart';
import 'widget.dart'; //appBar
import 'back/data_fetch.dart';
import 'dart:html';
import 'dart:ui' as ui;
import 'dart:math';
import 'package:url_launcher/url_launcher.dart';
import 'package:fluttertoast/fluttertoast.dart';


class resultlist_with extends StatefulWidget {
  final Idx;
  final List<dynamic>? leftlist;
  const resultlist_with(this.Idx, this.leftlist, {super.key});

  @override
  Result_with createState() => Result_with();
}

class Result_with extends State<resultlist_with> {
  var Index;
  late String storeName;
  late String menu;
  late String position;
  // String pricelevel = "1,000,000원 대";
  late String description;
  late String storeimage;
  late List<dynamic> foodtag;
  late String tagstring;
  late Image img;
  late Uri _url;
  late Uri? maplink;
  late List<dynamic>? leftlist;
  late List<dynamic> times;

  @override
  void initState() {
    Index = widget.Idx;
    storeName = listfood[Index]["name"];
    menu = listfood[Index]["category"];
    position = listfood[Index]["address"];
    description = listfood[Index]["OneLiner"];
    if (listfood[Index]["image"] != null) {
      storeimage = listfood[Index]["image"];
      img = Image.network(
        storeimage!,
      );
    } else {
      img = Image.network("https://www.pulsecarshalton.co.uk/wp-content/uploads/2016/08/jk-placeholder-image.jpg");
    }
    foodtag = List.generate(listfood[Index]["tags"].length,
        (index) => '#${listfood[Index]["tags"][index]}');
    tagstring = foodtag.join(" ");
    _url = Uri.parse('https://forms.gle/J5nnWwScc6ehhUuQ6');
    if (listfood[Index]["NaverMap"] != null) {
      maplink = Uri.parse(listfood[Index]["NaverMap"]);
    } else {
      maplink = null;
    }
    if (widget.leftlist != null) {
      leftlist = widget.leftlist!.toSet().toList();
    } else {
      leftlist = widget.leftlist;
    }
    times = listfood[Index]["times"];
    super.initState();
  }

  Future<void> _launchUrl(Uri url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    //스트링 예시 리스트에서 각 변수로 넣으면 동작함
    const String letterstyle = 'NanumSquareB.ttf';
    var width = MediaQuery.of(context).size.width;

    if (width < 900) {
      return Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        appBar: CustomAppBar(scaffoldKey: scaffoldKey),
        endDrawer: const SafeArea(
          child: Drawer(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  bottomLeft: Radius.circular(50)),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: TextScroll(
                        storeName,
                        velocity:
                            const Velocity(pixelsPerSecond: Offset(30, 0)),
                        pauseBetween: const Duration(milliseconds: 1000),
                        mode: TextScrollMode.bouncing,
                        fadedBorder: false,
                        style: const TextStyle(
                          fontSize: 36,
                          fontFamily: "NanumSquare_ac",
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        if (leftlist != null)
                          InkWell(
                            onTap: () {
                              // 버튼을 클릭하면 다른 페이지로 이동
                              if (leftlist!.isNotEmpty) {
                                var rand = leftlist![
                                    Random().nextInt(leftlist!.length)];
                                leftlist!.remove(rand);
                                Navigator.pop(context);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          resultlist_with(rand, leftlist)),
                                );
                              } else {
                                Fluttertoast.showToast(
                                    msg: "남은 음식점이 없습니다.",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              }
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Colors.amberAccent,
                                  // border: Border.all(
                                  //   color: const Color.fromARGB(255, 180, 180, 180),
                                  //   width: 1.5,
                                  // ),
                                  borderRadius: BorderRadius.circular(10)),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.replay),
                                ],
                              ),
                            ),
                          ),
                        const SizedBox(
                          width: 10,
                        ),
                        IconButton(
                          padding: EdgeInsets.zero,
                          icon: Icon(
                            liked.contains(Index)
                                ? Icons.star
                                : Icons.star_border,
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
                  ],
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
                        margin: const EdgeInsets.symmetric(
                            vertical: 3, horizontal: 23),
                        child: Text(
                          tagstring,
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
                        alignment: Alignment.topLeft,
                        padding: const EdgeInsets.all(0),
                        margin: const EdgeInsets.fromLTRB(23, 10, 23, 5),
                        child: RichText(
                          text: TextSpan(children: <TextSpan>[
                            TextSpan(children: <TextSpan>[
                              const TextSpan(
                                  text: "메뉴: ",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: "NanumSquare_ac",
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                    height: 1.5,
                                  )),
                              TextSpan(
                                  text: '$menu\n',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontFamily: "NanumSquare_ac",
                                    fontWeight: FontWeight.w200,
                                    color: Colors.black,
                                    height: 1.5,
                                  )),
                              const TextSpan(
                                  text: "위치: ",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: "NanumSquare_ac",
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                    height: 1.5,
                                  )),
                              TextSpan(
                                  text: '$position\n',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontFamily: "NanumSquare_ac",
                                    fontWeight: FontWeight.w200,
                                    color: Colors.black,
                                    height: 1.5,
                                  ))
                            ]),
                            if (times.length == 4)
                              TextSpan(children: [
                                const TextSpan(
                                    text: "영업 시간: ",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: "NanumSquare_ac",
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                      height: 1.5,
                                    )),
                                TextSpan(
                                    text: '${times[0]} ~ ${times[3]}\n',
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontFamily: "NanumSquare_ac",
                                      fontWeight: FontWeight.w200,
                                      color: Colors.black,
                                      height: 1.5,
                                    )),
                                const TextSpan(
                                    text: "브레이크 타임: ",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: "NanumSquare_ac",
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                      height: 1.5,
                                    )),
                                TextSpan(
                                    text: '${times[1]} ~ ${times[2]}\n',
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontFamily: "NanumSquare_ac",
                                      fontWeight: FontWeight.w200,
                                      color: Colors.black,
                                      height: 1.5,
                                    ))
                              ]),
                            if (times.length == 2)
                              TextSpan(children: [
                                const TextSpan(
                                    text: "영업 시간: ",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: "NanumSquare_ac",
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                      height: 1.5,
                                    )),
                                TextSpan(
                                    text: '${times[0]} ~ ${times[1]}\n',
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontFamily: "NanumSquare_ac",
                                      fontWeight: FontWeight.w200,
                                      color: Colors.black,
                                      height: 1.5,
                                    ))
                              ])
                          ]),
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
                      TextButton(
                        onPressed: () {
                          if (maplink != null) {
                            _launchUrl(maplink!);
                          } else {
                            Fluttertoast.showToast(
                                msg: "음식점 링크가 없습니다.",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          }
                        },
                        style: TextButton.styleFrom(
                          foregroundColor:
                              Colors.redAccent.shade200, // Text Color
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
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () => _launchUrl(_url),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.grey[400],
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                child: const Text(
                                  "관리자에게 제보하기",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: "NanumSquare_ac",
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        appBar: CustomAppBar(scaffoldKey: scaffoldKey),
        endDrawer: const SafeArea(
          child: Drawer(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  bottomLeft: Radius.circular(50)),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: TextScroll(
                        storeName,
                        velocity:
                            const Velocity(pixelsPerSecond: Offset(30, 0)),
                        pauseBetween: const Duration(milliseconds: 1000),
                        mode: TextScrollMode.bouncing,
                        fadedBorder: true,
                        fadeBorderVisibility: FadeBorderVisibility.auto,
                        fadeBorderSide: FadeBorderSide.right,
                        style: const TextStyle(
                          fontSize: 36,
                          fontFamily: "NanumSquare_ac",
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        if (leftlist != null)
                          Container(
                            height: 40,
                            width: 150,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.grey[300],
                                // border: Border.all(
                                //   color: const Color.fromARGB(255, 180, 180, 180),
                                //   width: 1.5,
                                // ),
                                borderRadius: BorderRadius.circular(10)),
                            child: InkWell(
                                onTap: () {
                                  // 버튼을 클릭하면 다른 페이지로 이동
                                  if (leftlist!.isNotEmpty) {
                                    var rand = leftlist![
                                        Random().nextInt(leftlist!.length)];
                                    leftlist!.remove(rand);
                                    Navigator.pop(context);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              resultlist_with(rand, leftlist)),
                                    );
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: "남은 음식점이 없습니다.",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                  }
                                },
                                child: Container(
                                  height: 40,
                                  width: 150,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Colors.amberAccent,
                                      // border: Border.all(
                                      //   color: const Color.fromARGB(255, 180, 180, 180),
                                      //   width: 1.5,
                                      // ),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.replay),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "다시 뽑기",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontFamily: "NanumSquare_ac",
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                        const SizedBox(
                          width: 10,
                        ),
                        IconButton(
                          padding: EdgeInsets.zero,
                          icon: Icon(
                            liked.contains(Index)
                                ? Icons.star
                                : Icons.star_border,
                            color: liked.contains(Index) ? Colors.yellow : null,
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
                  ],
                ),
                const SizedBox(height: 12),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.transparent),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.45,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Container(
                                alignment: Alignment.topCenter,
                                width: double.infinity,
                                margin:
                                    const EdgeInsets.fromLTRB(12, 20, 12, 20),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: img,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.45,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              margin: const EdgeInsets.symmetric(
                                  vertical: 3, horizontal: 23),
                              child: Text(
                                tagstring,
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
                              alignment: Alignment.topLeft,
                              margin: const EdgeInsets.fromLTRB(23, 10, 23, 0),
                              child: RichText(
                                text: TextSpan(children: <TextSpan>[
                                  TextSpan(children: <TextSpan>[
                                    const TextSpan(
                                        text: "메뉴: ",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontFamily: "NanumSquare_ac",
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                          height: 1.5,
                                        )),
                                    TextSpan(
                                        text: '$menu\n',
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontFamily: "NanumSquare_ac",
                                          fontWeight: FontWeight.w200,
                                          color: Colors.black,
                                          height: 1.5,
                                        )),
                                    const TextSpan(
                                        text: "위치: ",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontFamily: "NanumSquare_ac",
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                          height: 1.5,
                                        )),
                                    TextSpan(
                                        text: '$position\n',
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontFamily: "NanumSquare_ac",
                                          fontWeight: FontWeight.w200,
                                          color: Colors.black,
                                          height: 1.5,
                                        ))
                                  ]),
                                  if (times.length == 4)
                                    TextSpan(children: [
                                      const TextSpan(
                                          text: "영업 시간: ",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontFamily: "NanumSquare_ac",
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                            height: 1.5,
                                          )),
                                      TextSpan(
                                          text: '${times[0]} ~ ${times[3]}\n',
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontFamily: "NanumSquare_ac",
                                            fontWeight: FontWeight.w200,
                                            color: Colors.black,
                                            height: 1.5,
                                          )),
                                      const TextSpan(
                                          text: "브레이크 타임: ",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontFamily: "NanumSquare_ac",
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                            height: 1.5,
                                          )),
                                      TextSpan(
                                          text: '${times[1]} ~ ${times[2]}\n',
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontFamily: "NanumSquare_ac",
                                            fontWeight: FontWeight.w200,
                                            color: Colors.black,
                                            height: 1.5,
                                          ))
                                    ]),
                                  if (times.length == 2)
                                    TextSpan(children: [
                                      const TextSpan(
                                          text: "영업 시간: ",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontFamily: "NanumSquare_ac",
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                            height: 1.5,
                                          )),
                                      TextSpan(
                                          text: '${times[0]} ~ ${times[1]}\n',
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontFamily: "NanumSquare_ac",
                                            fontWeight: FontWeight.w200,
                                            color: Colors.black,
                                            height: 1.5,
                                          ))
                                    ])
                                ]),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.white,
                              ),
                              alignment: Alignment.center,
                              width: double.infinity,
                              height: 120,
                              margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 15),
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
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      if (maplink != null) {
                                        _launchUrl(maplink!);
                                      } else {
                                        Fluttertoast.showToast(
                                            msg: "음식점 링크가 없습니다.",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.CENTER,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.red,
                                            textColor: Colors.white,
                                            fontSize: 16.0);
                                      }
                                    },
                                    style: TextButton.styleFrom(
                                      foregroundColor: Colors
                                          .redAccent.shade200, // Text Color
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
                                  InkWell(
                                    onTap: () => _launchUrl(_url),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: Colors.grey[400],
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      child: const Text(
                                        "관리자에게 제보하기",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontFamily: "NanumSquare_ac",
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
