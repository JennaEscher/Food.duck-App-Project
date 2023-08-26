import 'dart:async';
import 'package:flutter/services.dart';

import 'home_page.dart';
import 'back/data_fetch.dart';
import 'package:flutter/material.dart';




class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);
  @override
  _LoadingPage createState() => _LoadingPage();
}

class _LoadingPage extends State<LoadingPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  var check;

  @override
  void initState() {
    super.initState();
    _checkDataFetch().then((value) {
      setState(() {
        check = value;
      });
      print("check : $check");
      Timer(Duration(seconds: 3), () {
        if(check == 0){
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage())
          );
        }else{
          SystemNavigator.pop();
        }
      });
    });

  }

  Future<int> _checkDataFetch() async{
    CounterStorage storage = CounterStorage();
    var t = await init(storage);
    print(t);
    print("name");
    name.forEach((key, value) => print('${key} : ${value}'));
    print("tag");
    tag.forEach((key, value) => print('${key} : ${value}'));
    print("category");
    category.forEach((key, value) => print('${key} : ${value}'));
    print("trav_time");
    trav_time.forEach((key, value) => print('${key} : ${value}'));
    print(tags);
    print(categorys);
    return t;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: Container(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/icon.png',
              height: MediaQuery.of(context).size.width * 0.4,
              width: MediaQuery.of(context).size.width * 0.4,
            ),
          ],
        ),
      ),
    );
  }
}
