import 'package:flutter/material.dart';
import 'widget.dart';
import 'drawer.dart';

class NoResultText extends StatelessWidget {
  final String details;
  const NoResultText(this.details, {super.key});

  @override
  Widget build(BuildContext context) {
    double heightWithoutappBarNavBar = MediaQuery.of(context).size.height - 220;
    return SizedBox(
      height: heightWithoutappBarNavBar,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Transform.rotate(
            angle: 208*3.141592/180,
            child: Image.asset(
              'assets/images/icon.png',
              width: 70,
              alignment: Alignment.center,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            details,
            textAlign: TextAlign.start,
            style: const TextStyle(
              fontSize: 28,
              fontFamily: "NanumSquare_ac",
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

class NotFound extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  NotFound({super.key});

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
      body: SafeArea(
        child: ListView(
          children: [
            const titleSection("검색 결과"),
            NoResultText("! 검색 결과가 없습니다 !"),
          ],
        ),
      ),
    );
  }
}
