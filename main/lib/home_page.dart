import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project2307/result_with.dart';
import 'loading.dart';
import 'drawer.dart';
import 'search_recent.dart';
import 'back/data_fetch.dart';
import 'dart:async';
import 'dart:math';

bool isloaded = false;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  late bool loaded;
  var check;

  //Widget Lifecycle : initState -> build -> dispose
  @override
  void initState() {
    super.initState();
    setState(() {
      loaded = isloaded;
    });
    if (!loaded) {
      //테스트 코드로 추측됨.
      _checkDataFetch().then((value) {
        setState(() {
          check = value;
        });
        //3초 대기
        Timer(const Duration(seconds: 3), () {
          //데이터 가져오기 성공
          if (check == 0) {
            setState(() {
              isloaded = true;
              loaded = true;
            });
          } else {
            //실패시 앱 종료
            SystemNavigator.pop();
          }
        });
      });
    }
  }

  //2번 실행??
  Future<int> _checkDataFetch() async {
    CounterStorage storage = CounterStorage();
    var t = await init(storage);
    return t;
  }

  @override
  Widget build(BuildContext context) {
    var screenwidth = MediaQuery.of(context).size.width;
    //데이터가 다 로드되면 화면을 그리고, 그렇지 않으면 로딩 페이지를 그림
    if (loaded) {
      return Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        appBar: AppBar(
          //drawer기능 때문에 Appbar 필요
          automaticallyImplyLeading: false,
          toolbarHeight: 60,
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            Padding(
              padding: const EdgeInsets.only(
                  right: 20.0), //top:10 하거나 Appbar의 height올릴수도 있음
              child: IconButton(
                padding: EdgeInsets.zero,
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
        //위젯 고정
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
        //UI 오버플로우 방지
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 80,
                child: Container(),
              ),
              SizedBox(
                height: 400,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
                      width: 320,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //검색창
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SearchRecent()),
                            );
                          },
                          child: Container(
                            height: 45,
                            width: screenwidth < 600 ? screenwidth - 80 : 520,
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
                    //I'm Feeling Hungry 랜덤 검색
                    InkWell(
                      onTap: () {
                        // 버튼을 클릭하면 다른 페이지로 이동
                        var rand = Random().nextInt(listfood.length);
                        List<dynamic> leftlist =
                            List<int>.generate(listfood.length, (i) => i);
                        //List->Set->List (중복제거), remove(rand) : rand번째 요소 제거 -> 한 번 뽑은 곳은 다시 뽑지 않음.
                        leftlist.toSet().toList().remove(rand);
                        //랜덤검색 페이지로 이동
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  resultlist_with(rand, leftlist)),
                        );
                      },
                      child: Container(
                        height: 50,
                        width: 250,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        child: const Text(
                          "I’m Feeling Hungry",
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: "NanumSquare_ac",
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 80,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      //로딩창 띄우기
      return const LoadingPage();
    }
  }
}
