import 'package:flutter/material.dart';
import 'back/data_fetch.dart';
import 'package:project2307/result_with.dart';
import 'widget.dart';
import 'drawer.dart';

class SearchTag extends StatefulWidget {
  const SearchTag({Key? key}) : super(key: key);

  @override
  SearchPageState createState() => SearchPageState();
}

class SearchPageState extends State<SearchTag> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  void clickBottons() {
    setState(() {
      List<int> tmpprice = [];
      for (int i in Iterable.generate(prices.length)) {
        if (isSelectedPrices[i]) tmpprice.addAll(price[i]);
      }
      tmpprice = tmpprice.toSet().toList();

      List<int> tmpplace = [];
      for (int i in Iterable.generate(places.length)) {
        if (isSelectedPlaces[i]) tmpplace.addAll(place[places[i]]);
      }
      tmpplace = tmpplace.toSet().toList();

      List<int> tmpcate = [];
      for (int i in Iterable.generate(categorys.length)) {
        if (isSelectedCate[i]) tmpcate.addAll(category[categorys[i]]);
      }
      tmpcate = tmpcate.toSet().toList();

      targetIndex = [];
      targetIndex.addAll(tmpprice);
      if (tmpplace.isNotEmpty && targetIndex.isNotEmpty) {
        targetIndex.removeWhere((item) => !tmpplace.contains(item));
      } else {
        targetIndex.addAll(tmpplace);
      }
      if (tmpcate.isNotEmpty && targetIndex.isNotEmpty) {
        targetIndex.removeWhere((item) => !tmpcate.contains(item));
      } else {
        targetIndex.addAll(tmpcate);
      }
      targetIndex.toSet().toList();
    });
  }

  List<bool> isSelectedPrices = []; //가격대 선택여부 리스트
  List<String> selectedPrices = []; //가격대 태그 리스트
  List<bool> isSelectedCate = []; //카테고리 선택여부 리스트
  List<String> selectedCates = []; //선택된 카테고리 리스트
  List<bool> isSelectedPlaces = []; //위치 선택여부 리스트
  List<String> selectedPlaces = []; //선택된 위치 리스트
  List<int> targetIndex = [];

  @override
  void initState() {
    super.initState();
    isSelectedPrices =
        List.generate(prices.length, (index) => false); // isSelectedPrices 초기화
    isSelectedCate =
        List.generate(categorys.length, (index) => false); // isSelectedCate 초기화
    isSelectedPlaces =
        List.generate(places.length, (index) => false); // isSelectedCate 초기화
    targetIndex = [];
  }

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
      body: ListView(
        children: [
          const titleSection("태그 검색"),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 0),
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: Column(
                  children: [
                    // 태그 선택하는 박스
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Column(
                          children: [
                            // 메뉴 선택 줄
                            Container(
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.grey,
                                    width: 0.5,
                                    style: BorderStyle.solid,
                                  ),
                                ),
                              ),
                              child: IntrinsicHeight(
                                child: Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Container(
                                      width: 80,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      alignment: Alignment.center,
                                      child: const Text(
                                        '메뉴',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: "NanumSquare_ac",
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 10,
                                        ),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Wrap(
                                            spacing: 15,
                                            runSpacing: 10,
                                            children: [
                                              for (int i = 0;
                                                  i < categorys.length;
                                                  i++)
                                                Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 10),
                                                  decoration: BoxDecoration(
                                                    color: isSelectedCate[i]
                                                        ? Colors.amber[300]
                                                        : Colors.grey[200],
                                                    border: Border.all(
                                                      color: isSelectedCate[i]
                                                          ? const Color
                                                              .fromARGB(
                                                              255, 255, 213, 79)
                                                          : const Color
                                                              .fromARGB(255,
                                                              238, 238, 238),
                                                      width: 3,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                  ),
                                                  child: InkWell(
                                                    onTap: () {
                                                      isSelectedCate[i] =
                                                          !isSelectedCate[i];
                                                      clickBottons();
                                                    },
                                                    child: Text(
                                                      categorys[i],
                                                      style: const TextStyle(
                                                        fontSize: 16,
                                                        fontFamily:
                                                            "NanumSquare_ac",
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // 장소 선택 줄
                            Container(
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.grey,
                                    width: 0.5,
                                    style: BorderStyle.solid,
                                  ),
                                ),
                              ),
                              child: IntrinsicHeight(
                                child: Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Container(
                                      width: 80,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      alignment: Alignment.center,
                                      child: const Text(
                                        '장소',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: "NanumSquare_ac",
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 10,
                                        ),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Wrap(
                                            spacing: 15,
                                            runSpacing: 10,
                                            children: [
                                              for (int i = 0;
                                                  i < places.length;
                                                  i++)
                                                Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 10),
                                                  decoration: BoxDecoration(
                                                    color: isSelectedPlaces[i]
                                                        ? Colors.amber[300]
                                                        : Colors.grey[200],
                                                    border: Border.all(
                                                      color: isSelectedPlaces[i]
                                                          ? const Color
                                                              .fromARGB(
                                                              255, 255, 213, 79)
                                                          : const Color
                                                              .fromARGB(255,
                                                              238, 238, 238),
                                                      width: 3,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                  ),
                                                  child: InkWell(
                                                    onTap: () {
                                                      isSelectedPlaces[i] =
                                                          !isSelectedPlaces[i];
                                                      clickBottons();
                                                    },
                                                    child: Text(
                                                      places[i],
                                                      style: const TextStyle(
                                                        fontSize: 16,
                                                        fontFamily:
                                                            "NanumSquare_ac",
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // 가격대 선택 줄
                            IntrinsicHeight(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Container(
                                    width: 80,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                    ),
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    alignment: Alignment.center,
                                    child: const Text(
                                      '가격대',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: "NanumSquare_ac",
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 10,
                                      ),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Wrap(
                                          spacing: 15,
                                          runSpacing: 10,
                                          children: [
                                            for (int i = 0;
                                                i < prices.length;
                                                i++)
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                decoration: BoxDecoration(
                                                  color: isSelectedPrices[i]
                                                      ? Colors.amber[300]
                                                      : Colors.grey[200],
                                                  border: Border.all(
                                                    color: isSelectedPrices[i]
                                                        ? const Color.fromARGB(
                                                            255, 255, 213, 79)
                                                        : const Color.fromARGB(
                                                            255, 238, 238, 238),
                                                    width: 3,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                ),
                                                child: InkWell(
                                                  onTap: () {
                                                    isSelectedPrices[i] =
                                                        !isSelectedPrices[i];
                                                    clickBottons();
                                                  },
                                                  child: Text(
                                                    PricesliderValIndicators[i],
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      fontFamily:
                                                          "NanumSquare_ac",
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(
                      thickness: 1.5,
                      indent: 20,
                      endIndent: 20,
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      itemCount: targetIndex.length + 1,
                      itemBuilder: (context, index) {
                        if (index == targetIndex.length) {
                          return Container();
                        } else {
                          return ListTile(
                            title: Text(listfood[targetIndex[index]]["name"]),
                            subtitle:
                                Text(listfood[targetIndex[index]]["OneLiner"]),
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 30),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => resultlist_with(
                                        targetIndex[index], null)),
                              );
                            },
                            trailing: IconButton(
                              padding: EdgeInsets.zero,
                              icon: Icon(
                                liked.contains(targetIndex[index])
                                    ? Icons.star
                                    : Icons.star_border,
                                color: liked.contains(targetIndex[index])
                                    ? Colors.yellow
                                    : null,
                                semanticLabel:
                                    liked.contains(targetIndex[index])
                                        ? 'Remove from saved'
                                        : 'Save',
                                size: 35,
                              ),
                              onPressed: () async {
                                int flag = 0;
                                if (liked.contains(targetIndex[index])) {
                                  flag = 1;
                                  await WriteCaches(
                                      listfood[targetIndex[index]]["name"],
                                      '0');
                                } else {
                                  flag = 0;
                                  await WriteCaches(
                                      listfood[targetIndex[index]]["name"],
                                      '1');
                                }
                                setState(() {
                                  if (flag == 1) {
                                    liked.remove(targetIndex[index]);
                                  } else {
                                    liked.add(targetIndex[index]);
                                  }
                                });
                                print(liked);
                              },
                            ),
                          );
                        }
                      },
                      separatorBuilder: (context, index) {
                        return const Divider(
                          thickness: 1.5,
                          indent: 20,
                          endIndent: 20,
                        );
                      },
                      scrollDirection: Axis.vertical,
                    )
                  ],
                ),
              ),
            ),
          ),
          // 검색결과 리스트
          //Container(child: _resultList,)
        ],
      ),
    );
  }
}
