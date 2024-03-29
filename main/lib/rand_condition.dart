import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project2307/result_with.dart';
import 'back/data_fetch.dart';
import 'widget.dart';
import 'drawer.dart';
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
            // 카테고리 선택 UI
            onChanged: (String? value) {
              setState(() {
                dropdownValue = value!;
              });
            },
            // 카테고리 리스트
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
  const RandCondition({super.key});

  @override
  State<RandCondition> createState() => _RandConditionState();
}

class _RandConditionState extends State<RandCondition> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  late String dropdownValue;
  late double initialSliderValue;
  late double priceSliderValue;
  late List<String> list;
  late List<int> tmp;

  @override
  void initState() {
    initialSliderValue = 0.0;
    priceSliderValue = 0.0;
    dropdownValue = categorys[0];
    list = categorys.toList();
    list.add("전체");
    tmp = category[dropdownValue];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenwidth = MediaQuery.of(context).size.width;

    Widget locationSlider = SizedBox(
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
              //슬라이더 UI
              onChanged: (double value) {
                setState(() {
                  initialSliderValue = value;
                });
              },
            ),
          ),
          const SizedBox(height: 15),
          Text(
            //실제 출력
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
      padding: const EdgeInsets.fromLTRB(22, 15, 22, 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SubText("1. 위치 선택", "음식점까지의 이동 범위를 설정할 수 있어요."),
          const SizedBox(height: 20),
          locationSlider,
          const SizedBox(height: 20),
        ],
      ),
    );

    Widget dropdownChoice = Container(
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
      padding: const EdgeInsets.fromLTRB(22, 0, 22, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SubText("2. 메뉴 선택", "원하시는 메뉴를 선택할 수 있어요."),
          const SizedBox(height: 20),
          dropdownChoice,
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
            List<dynamic> leftlist =
                List<int>.generate(listfood.length, (i) => i);
            leftlist.toSet().toList().remove(rand);
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => resultlist_with(rand, leftlist)),
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
            if (dropdownValue == "전체") {
              tmp = List<int>.generate(listfood.length, (i) => i);
            } else {
              tmp = [...category[dropdownValue]];
              tmp = tmp.toSet().toList();
            }

            for (int dis = initialSliderValue.toInt() + 1; dis < 4; dis++) {
              if (trav_time.containsKey(dis)) {
                tmp.removeWhere((item) => trav_time[dis].contains(item));
              }
            }
            List<int> pricelist = [];
            for (int i = 0; i <= priceSliderValue.toInt(); i++) {
              pricelist.addAll(price[i]);
            }
            pricelist.toSet().toList();
            if (price.containsKey(priceSliderValue.toInt())) {
              tmp.removeWhere((item) => !pricelist.contains(item));
            }

            if (tmp.isNotEmpty) {
              var rand = tmp[Random().nextInt(tmp.length)];
              tmp.remove(rand);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => resultlist_with(rand, tmp)),
              );
            } else {
              Fluttertoast.showToast(
                  msg: "검색결과가 없습니다",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            }
          },
          child: const Text("선택 완료"),
        ),
      ],
    );

    Widget priceSlider = SizedBox(
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
              value: priceSliderValue,
              max: 3,
              divisions: 3,
              //label: sliderValIndicators[priceSliderValue.toInt()],
              onChanged: (double value) {
                setState(() {
                  priceSliderValue = value;
                });
              },
            ),
          ),
          const SizedBox(height: 15),
          Text(
            "가격대: ${PricesliderValIndicators[priceSliderValue.toInt()]}",
            textAlign: TextAlign.start,
            style: const TextStyle(
              fontSize: 18,
              fontFamily: "NanumSquare_ac",
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );

    Widget priceSection = Container(
      padding: const EdgeInsets.fromLTRB(22, 10, 22, 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SubText("3. 가격대 선택", "음식점의 가격대를 설정할 수 있어요."),
          const SizedBox(height: 20),
          priceSlider,
          const SizedBox(height: 20),
        ],
      ),
    );

    Widget mainSection = screenwidth < 600
        ? Container(
            margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: Colors.transparent),
            ),
            child: Column(
              children: [
                randombutton,
                textSection1,
                textSection2,
                priceSection,
                resultbutton
              ],
            ),
          )
        : Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(
                horizontal: screenwidth * 0.15, vertical: 20),
            child: FittedBox(
              child: ClipRRect(
                child: IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          textSection1,
                          textSection2,
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          priceSection,
                          resultbutton,
                          randombutton,
                          const SizedBox(height: 20)
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ));

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
      body: ListView(
        children: [
          Column(
            children: [
              const titleSection("랜덤 추천"),
              mainSection,
            ],
          ),
        ],
      ),
    );
  }
}
