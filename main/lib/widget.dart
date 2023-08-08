import 'package:flutter/material.dart';

const List<String> sliderValIndicators = ["5분", "10분", "20분", "30분", "30분 이상"];
const List<String> listMenu = <String>[
  "선택하세요.",
  "랜덤",
  "한식",
  "중식",
  "일식",
  "양식",
  "술",
  "디저트",
  "기타"
];
const List<String> listCost = <String>[
  "선택하세요.",
  "랜덤",
  "0원 ~ 5,000원",
  "5,000원 ~ 10,000원",
  "10,000원 ~ 15,000원",
  "15,000원 ~ 20,000원",
  "20,000원 이상"
];

String getDetails(time) {
  String result = "DEFAULT";

  if (time == 0) {
    result = "반경 300m: 학교 주변 음식점 포함";
  } else if (time == 1) {
    result = "반경 500m: 대흥, 신촌 주변 음식점 포함";
  } else if (time == 2) {
    result = "반경 1km: 신촌, 이대 주변 음식점 포함";
  } else if (time == 3) {
    result = "반경 1.5km: 홍대, 공덕 주변 음식점 포함";
  } else if (time == 4) {
    result = "반경 1.5km 이상: 학교에서 먼 음식점 포함";
  } else {
    result = "ERROR";
  }

  return result;
}

class SubText extends StatelessWidget {
  final String title;
  final String details;
  const SubText(this.title, this.details, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 330,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            textAlign: TextAlign.start,
            style: const TextStyle(
              fontSize: 22,
              fontFamily: "NanumSquare_ac",
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 7),
          Text(
            details,
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
  }
}

class IconSection extends StatelessWidget {
  const IconSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(25, 25, 20, 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            'assets/images/icon.png',
            width: 55.0,
            fit: BoxFit.cover,
          ),
          const Icon(Icons.menu, color: Colors.black, size: 45.0),
        ],
      ),
    );
  }
}

class TitleSection extends StatelessWidget {
  final String title;
  const TitleSection(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
                fontSize: 36,
                fontFamily: "NanumSquare_ac",
                fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
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
    return SizedBox(
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
  }
}

class DropdownChoice extends StatefulWidget {
  final List<String> list;
  const DropdownChoice(this.list, {super.key});

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
