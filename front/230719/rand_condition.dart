import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Widget _subText(String title, String details) {
      return Container(
        width: 330,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 22,
                fontFamily: "NanumSquare_ac",
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 7),
            Text(
              details,
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 18,
                fontFamily: "NanumSquare_ac",
                fontWeight: FontWeight.w200,
              ),
            ),
          ],
        ),
      );
    }

    Widget iconSection = Container(
      padding: const EdgeInsets.fromLTRB(25, 25, 20, 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            'assets/images/icon.png',
            width: 55.0,
            fit: BoxFit.cover,
          ),
          Icon(Icons.menu, color: Colors.black, size: 45.0),
        ],
      ),
    );

    Widget titleSection = Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "랜덤 추천",
            style: TextStyle(
              fontSize: 36,
              fontFamily: "NanumSquare_ac",
              fontWeight: FontWeight.w600
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
          _subText("1. 위치 선택", "음식점까지의 이동 범위를 설정할 수 있어요."),
          SizedBox(height: 20),
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
          _subText("2. 메뉴 선택", "원하시는 메뉴를 선택할 수 있어요."),
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
          _subText("3. 가격대 선택", "희망하시는 가격대를 선택할 수 있어요."),
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
      height: 600,
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
              iconSection,
              titleSection,
              mainSection,
            ],
          ),
        ),
      ),
    );
  }
}

const List<String> sliderValIndicators = ["5분", "10분", "20분", "30분", "30분 이상"];

String getDetails(time) {
  String result = "DEFAULT";

  if (time == 0)
    result = "반경 300m: 학교 주변 음식점";
  else if (time == 1)
    result = "반경 500m: 대흥, 신촌 주변 음식점";
  else if (time == 2)
    result = "반경 1km: 신촌, 이대 주변 음식점";
  else if (time == 3)
    result = "반경 1.5km: 홍대, 공덕 주변 음식점";
  else if (time == 4)
    result = "반경 1.5km 이상: 학교에서 먼 음식점";
  else
    result = "ERROR";

  return result;
}

class LocationSlider extends StatefulWidget {
  const LocationSlider({super.key});

  @override
  State<LocationSlider> createState() => _LocationSliderState();
}

class _LocationSliderState extends State<LocationSlider> {
  double initialSliderValue = 0.0;

  @override
  Widget build(BuildContext context) {
    return Container(
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
          SizedBox(height: 15),
          Text(
            "소요 시간: " + sliderValIndicators[initialSliderValue.toInt()],
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 18,
              fontFamily: "NanumSquare_ac",
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 7),
          Text(
            getDetails(initialSliderValue.toInt()),
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 18,
              fontFamily: "NanumSquare_ac",
              fontWeight: FontWeight.w200,
            ),
          ),
        ],
      ),
    );
  }
}

const List<String> listMenu = <String>["선택하세요.", "랜덤", "한식", "중식", "일식", "술", "디저트", "기타"];
const List<String> listCost = <String>["선택하세요.", "랜덤", "0원 ~ 5,000원", "5,000원 ~ 10,000원", "10,000원 ~ 15,000원", "15,000원 ~ 20,000원", "20,000원 이상"];

class DropdownChoice extends StatefulWidget {
  final List<String> list;
  const DropdownChoice(this.list);

  @override
  State<DropdownChoice> createState() => _DropdownChoiceState();
}

class _DropdownChoiceState extends State<DropdownChoice> {
  String dropdownValue = "선택하세요.";

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