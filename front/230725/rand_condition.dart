import 'package:flutter/material.dart';
import 'package:project2307/widget.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Widget textSection1 = Container(
      padding: const EdgeInsets.fromLTRB(22, 25, 22, 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          subText("1. 위치 선택", "음식점까지의 이동 범위를 설정할 수 있어요."),
          SizedBox(height: 15),
          const LocationSlider(),
          SizedBox(height: 15),
        ],
      ),
    );

    Widget textSection2 = Container(
      padding: const EdgeInsets.fromLTRB(22, 10, 22, 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          subText("2. 메뉴 선택", "원하시는 메뉴를 선택할 수 있어요."),
          SizedBox(height: 20),
          const DropdownChoice(listMenu),
          SizedBox(height: 15),
        ],
      ),
    );

    Widget textSection3 = Container(
      padding: const EdgeInsets.fromLTRB(22, 10, 22, 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          subText("3. 가격대 선택", "희망하시는 가격대를 선택할 수 있어요."),
          SizedBox(height: 20),
          const DropdownChoice(listCost),
          SizedBox(height: 20),
        ],
      ),
    );

    Widget buttonSection = Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              textStyle: const TextStyle(
                fontSize: 20,
                fontFamily: "NanumSquare_ac",
                fontWeight: FontWeight.w600,
              ),
              backgroundColor: Colors.amberAccent,
              foregroundColor: Colors.black,
              shadowColor: Colors.transparent,
              elevation: 0.0,
              fixedSize: const Size(310, 50),
            ),
            onPressed: () {},
            child: const Text("선택 완료"),
          ),
        ],
      ),
    );

    Widget mainSection = Container(
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      height: 590,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.transparent),
      ),
      child: Column(
        children: [
          textSection1,
          textSection2,
          textSection3,
          buttonSection,
        ],
      ),
    );

    return MaterialApp(
      title: 'Food.duck()',
      home: Scaffold(
        body: SafeArea(
          child: ListView(
            children: [
              const iconSection(),
              const titleSection("랜덤 추천"),
              mainSection,
            ],
          ),
        ),
      ),
    );
  }
}