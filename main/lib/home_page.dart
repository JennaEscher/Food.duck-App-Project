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

  @override
  void initState() {
    super.initState();
    setState(() {
      loaded = isloaded;
    });
    if (!loaded) {
      _checkDataFetch().then((value) {
        setState(() {
          check = value;
        });
        print("check : $check");
        Timer(const Duration(seconds: 3), () {
          if (check == 0) {
            setState(() {
              isloaded = true;
              loaded = true;
            });
          } else {
            SystemNavigator.pop();
          }
        });
      });
    }
  }

  Future<int> _checkDataFetch() async {
    CounterStorage storage = CounterStorage();
    var t = await init(storage);
    // print(t);
    // print("name");
    // name.forEach((key, value) => print('$key : $value'));
    // print("tag");
    // tag.forEach((key, value) => print('$key : $value'));
    // print("category");
    // category.forEach((key, value) => print('$key : $value'));
    // print("trav_time");
    // trav_time.forEach((key, value) => print('$key : $value'));
    // print(tags);
    // print(categorys);
    return t;
  }

  @override
  Widget build(BuildContext context) {
    var screenwidth = MediaQuery.of(context).size.width;
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
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SearchRecent()),
                            );
                          },
                          child: Container(
                            //검색창
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
                    InkWell(
                      onTap: () {
                        // 버튼을 클릭하면 다른 페이지로 이동
                        var rand = Random().nextInt(listfood.length);
                        List<dynamic> leftlist =
                            List<int>.generate(listfood.length, (i) => i);
                        leftlist.toSet().toList().remove(rand);
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
                            //color: Colors.grey[300],
                            // border: Border.all(
                            //   color: const Color.fromARGB(255, 180, 180, 180),
                            //   width: 1.5,
                            // ),
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
      return const LoadingPage();
    }
  }
}
