import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'back/data_fetch.dart';
import 'widget.dart';
import 'drawer.dart';
import 'result.dart';
import 'dart:math';

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


class RandCondition extends StatefulWidget {
  RandCondition({super.key});

  @override
  State<RandCondition> createState() => _RandConditionState();
}


class _RandConditionState extends State<RandCondition> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  late String dropdownValue;
  late double initialSliderValue;
  late List<String> list;

  @override
  void initState() {
    initialSliderValue = 0.0;
    dropdownValue = categorys[0];
    list = categorys;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    Widget LocationSlider = SizedBox(
      width: 330,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SliderTheme(
            data: SliderThemeData(
              overlayShape: SliderComponentShape.noOverlay,
              trackHeight: 18,
              inactiveTrackColor: Colors.grey[350],
              activeTrackColor: Colors.amber,
              inactiveTickMarkColor: Colors.transparent,
              activeTickMarkColor: Colors.transparent,
              thumbColor: Colors.white,
            ),
            child: Slider(
              value: initialSliderValue,
              max: 4,
              divisions: 4,
              //label: sliderValIndicators[initialSliderValue.toInt()],
              onChanged: (double value) {
                setState(() {
                  initialSliderValue = value;
                });
              },
            ),
          ),
          const SizedBox(height: 15),
          Text(
            "소요 시간: ${sliderValIndicators[initialSliderValue.toInt()]}",
            textAlign: TextAlign.start,
            style: const TextStyle(
              fontSize: 18,
              fontFamily: "NanumSquare_ac",
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 7),
          Text(
            getDetails(initialSliderValue.toInt()),
            textAlign: TextAlign.start,
            style: const TextStyle(
              fontSize: 18,
              fontFamily: "NanumSquare_ac",
              fontWeight: FontWeight.w200,
            ),
          ),
        ],
      ),
    );


    Widget textSection1 = Container(
      padding: const EdgeInsets.fromLTRB(22, 25, 22, 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SubText("1. 위치 선택", "음식점까지의 이동 범위를 설정할 수 있어요."),
          const SizedBox(height: 20),
          LocationSlider,
          const SizedBox(height: 20),
        ],
      ),
    );

    Widget DropdownChoice = Container(
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
            items: list.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      ),
    );




    Widget textSection2 = Container(
      padding: const EdgeInsets.fromLTRB(22, 10, 22, 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SubText("2. 메뉴 선택", "원하시는 메뉴를 선택할 수 있어요."),
          const SizedBox(height: 20),
          DropdownChoice,
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
            backgroundColor: Colors.deepOrange.shade100,
            foregroundColor: Colors.black,
            shadowColor: Colors.transparent,
            elevation: 0.0,
            fixedSize: const Size(310, 50),
          ),
          onPressed: () {
            //without tag

            var rand = Random().nextInt(listfood.length);
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => resultlist(rand)),
            );
          },
          child: const Text("고르는 것도 귀찮아"),
        ),
      ],
    );

    Widget resultbutton = Column(
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
          //with tag
          List<String> result = [];
          List<int> tmp = Iterable<int>.generate(listfood.length).toList();

          tmp.removeWhere((item) => !category[dropdownValue].contains(item));
          tmp.removeWhere((item) => !trav_time[initialSliderValue].contains(item));
          print(tmp);
          if(tmp.length > 0) {
            var rand = Random().nextInt(tmp.length);
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => resultlist(tmp[rand])),
            );
          }else{
            Fluttertoast.showToast(
                msg: "검색결과가 없습니다",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0
            );
          }
        },
        child: const Text("선택 완료"),
      ),
    ],
  );

    Widget mainSection = Container(
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      height: MediaQuery.of(context).size.height - 200,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.transparent),
      ),
      child: FittedBox(
        child : Column(
          children: [
            const SizedBox(height: 30),
            randombutton,
            textSection1,
            textSection2,
            resultbutton,
            const SizedBox(height: 30)
          ],
        )
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
