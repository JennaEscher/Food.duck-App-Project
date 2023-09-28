import 'package:flutter/material.dart';
import 'package:project2307/result_with.dart';
import 'drawer.dart';
import 'back/data_fetch.dart';
import 'widget.dart';

class searchList extends StatefulWidget {
  final List<dynamic> listIndex;
  final String titleString;
  const searchList(this.listIndex, this.titleString, {super.key});

  @override
  _searchListState createState() => _searchListState();
}

class _searchListState extends State<searchList> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  var names = <String>[];
  var descriptions = <String>[];
  var targetIndex = <dynamic>[];
  var selectedName = <String>[];
  var selectedDesc = <String>[];

  @override
  void initState() {
    targetIndex = widget.listIndex.toSet().toList();
    /*
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
    }*/
    super.initState();
  }

  Widget _resultList() {
    return ListView.separated(
      itemCount: targetIndex.length + 2,
      itemBuilder: (context, index) {
        if (index == 0) {
          return titleSection(widget.titleString);
        } else if (index == targetIndex.length + 1) {
          return Container();
        } else {
          return ListTile(
            title: Text(listfood[targetIndex[index - 1]]["name"]),
            subtitle: Text(listfood[targetIndex[index - 1]]["OneLiner"]),
            contentPadding: const EdgeInsets.symmetric(horizontal: 30),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => resultlist_with(targetIndex[index - 1],null)),
              );
            },
            trailing: IconButton(
              padding: EdgeInsets.zero,
              icon: Icon(
                liked.contains(targetIndex[index - 1])
                    ? Icons.star
                    : Icons.star_border,
                color: liked.contains(targetIndex[index - 1])
                    ? Colors.yellow
                    : null,
                semanticLabel: liked.contains(targetIndex[index - 1])
                    ? 'Remove from saved'
                    : 'Save',
                size: 35,
              ),
              onPressed: ()async{
                int flag = 0;
                if (liked.contains(targetIndex[index - 1])) {
                  flag = 1;
                  await WriteCaches(
                      listfood[targetIndex[index - 1]]["name"], '0');
                } else {
                  flag = 0;
                  await WriteCaches(
                      listfood[targetIndex[index - 1]]["name"], '1');
                }
                setState(() {
                  if (flag == 1) {
                    liked.remove(targetIndex[index - 1]);
                  } else {
                    liked.add(targetIndex[index - 1]);
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
      shrinkWrap: true,
    );
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
      body: _resultList(),
    );
  }
}
