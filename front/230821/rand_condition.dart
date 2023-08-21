import 'package:flutter/material.dart';
import 'widget.dart';
import 'drawer.dart';

class RandCondition extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  RandCondition({super.key});

  @override
  Widget build(BuildContext context) {
    Widget textSection1 = Container(
      padding: const EdgeInsets.fromLTRB(22, 25, 22, 15),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SubText("1. 위치 선택", "음식점까지의 이동 범위를 설정할 수 있어요."),
          SizedBox(height: 20),
          LocationSlider(),
          SizedBox(height: 20),
        ],
      ),
    );

    Widget textSection2 = Container(
      padding: const EdgeInsets.fromLTRB(22, 10, 22, 15),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SubText("2. 메뉴 선택", "원하시는 메뉴를 선택할 수 있어요."),
          SizedBox(height: 20),
          DropdownChoice(listMenu),
          SizedBox(height: 20),
        ],
      ),
    );

    Widget mainSection = Container(
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      height: 550,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.transparent),
      ),
      child: Column(
        children: [
          SizedBox(height: 30),
          ButtonSection(Colors.deepOrange.shade100, "고르는 것도 귀찮아"),
          textSection1,
          textSection2,
          ButtonSection(Colors.amberAccent, "선택 완료"),
        ],
      ),
    );

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
            const TitleSection("랜덤 추천"),
            mainSection,
          ],
        ),
      ),
    );
  }
}
