import 'package:flutter/material.dart';
import 'package:project/drawer.dart';

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
final liked = <String>[];

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

class ButtonSection extends StatelessWidget {
  final Color background;
  final String details;
  const ButtonSection(this.background, this.details, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            textStyle: const TextStyle(
              fontSize: 20,
              fontFamily: "NanumSquare_ac",
              fontWeight: FontWeight.w600,
            ),
            backgroundColor: background,
            foregroundColor: Colors.black,
            shadowColor: Colors.transparent,
            elevation: 0.0,
            fixedSize: const Size(310, 50),
          ),
          onPressed: () {},
          child: Text(details),
        ),
      ],
    );
  }
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
  //앱바 사용시 불필요
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
          const SizedBox(height: 25),
          Text(
            "소요 시간: ${sliderValIndicators[initialSliderValue.toInt()]}",
            textAlign: TextAlign.start,
            style: const TextStyle(
              fontSize: 18,
              fontFamily: "NanumSquare_ac",
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 10),
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

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const CustomAppBar({super.key, required this.scaffoldKey});

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 60,
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: Image.asset(
          'assets/images/icon.png',
        ),
      ),
      actions: [
        Container(
          constraints: const BoxConstraints(
            maxWidth: 100,
          ),
          child: Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: IconButton(
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
        ),
      ],
    );
  }
}

class searchList extends StatefulWidget {
  final List<String> resultName;
  final List<String> resultDesc;
  final List<int> listIndex;
  final String titleString;
  const searchList(this.resultName, this.resultDesc, this.listIndex, this.titleString);

  @override
  _searchListState createState() => _searchListState();
}

class _searchListState extends State<searchList> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  var names = <String>[];
  var descriptions = <String>[];
  var targetIndex = <int>[];
  var selectedName = <String>[];
  var selectedDesc = <String>[];

  @override
  void initState() {
    names = widget.resultName;
    descriptions = widget.resultDesc;
    targetIndex = widget.listIndex;
    if (targetIndex.isEmpty) {
      selectedName = names;
      selectedDesc = descriptions;
      // 이 부분의 경우 결과 없음이 나와야 함. 수정 필요함. 즐겨찾기 결과가 없는 경우에도 이리로 옴. 양쪽 다 쓸 수 있는 문구로!
    }
    else if (targetIndex[0] == -1) {
      selectedName = names;
      selectedDesc = descriptions;
      // 즐겨찾기
    }
    else {
      for (int i = 0; i < targetIndex.length; i++) {
        selectedName.add(names[targetIndex[i]]);
        selectedDesc.add(descriptions[targetIndex[i]]);
      }
    }
    super.initState();
  }

  Widget _resultList() {
    return ListView.separated(
      itemCount: selectedName.length+2,
      itemBuilder: (context, index) {
        if (index == 0) {
          return TitleSection(widget.titleString);
        }
        else if (index == selectedName.length + 1) {
          return Container();
        }
        else {
          return ListTile(
            title: Text(selectedName[index-1]),
            subtitle: Text(selectedDesc[index-1]),
            contentPadding: const EdgeInsets.symmetric(horizontal: 30),
            trailing: IconButton(
              icon: Icon(
                liked.contains(selectedName[index-1]) ? Icons.star : Icons.star_border,
                color: liked.contains(selectedName[index-1]) ? Colors.yellow : null,
                semanticLabel: liked.contains(selectedName[index-1]) ? 'Remove from saved' : 'Save',
                size: 35,
              ),
              onPressed: (){
                setState(() {
                  if (liked.contains(selectedName[index-1])) {
                    liked.remove(selectedName[index-1]);
                  } else {
                    liked.add(selectedName[index-1]);
                  }
                });
              },
            ),
          );
        }
      },
      separatorBuilder: (context, index) {
        return const Divider(thickness: 1.5, indent: 20, endIndent: 20,);
      },
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
    );
  }

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
      body: _resultList(),
    );
  }
}