import 'package:flutter/material.dart';
import 'back/data_fetch.dart';
import 'widget.dart';
import 'drawer.dart';


class DropdownChoice extends StatefulWidget {
  List<String> list;
  DropdownChoice(this.list, {super.key});

  @override
  State<DropdownChoice> createState() => _DropdownChoiceState();
}

class _DropdownChoiceState extends State<DropdownChoice> {
  String dropdownValue = categorys[0];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320.0,
      height: 40.0,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 2, color: Colors.amber),
      ),
      child: DropdownButtonHideUnderline(
        child: ButtonTheme(
          alignedDropdown: true,
          child: DropdownButton(
            value: dropdownValue,
            icon: const Icon(Icons.keyboard_arrow_down),
            elevation: 10,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontFamily: "NanumSquare_ac",
              fontWeight: FontWeight.w400,
            ),
            onChanged: (String? value) {
              setState(() {
                dropdownValue = value!;
              });
            },
            items: widget.list.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}


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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SubText("2. 메뉴 선택", "원하시는 메뉴를 선택할 수 있어요."),
          const SizedBox(height: 20),
          DropdownChoice(categorys),
          const SizedBox(height: 20),
        ],
      ),
    );


    Widget randombutton = Column(
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
          onPressed: () {

          },
          child: const Text("선택 완료"),
        ),
      ],
    );

    Widget resultbutton = Container(
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
          randombutton,
          textSection1,
          textSection2,
          randombutton,
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
          const SizedBox(height: 30),
          randombutton,
          textSection1,
          textSection2,
          resultbutton,
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
            const titleSection("랜덤 추천"),
            mainSection,
          ],
        ),
      ),
    );
  }
}
