import 'package:flutter/material.dart';
import 'package:project/widget.dart';

void main() => runApp(searchResult());
final name = ["이태리부대찌개", "수저가", "홍원", "원더풀샤브샤브", "카페 나팔꽃", "가츠벤또", "야마노라멘", "정육면체", "신촌수제비", "네이버후드"];
final description = List<String>.generate(10, (i) => "$i");
final listIndex = [1, 3, 5, 6, 9];

class searchResult extends StatelessWidget {
  const searchResult({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food.duck()',
      home: searchList(name, description, listIndex),
    );
  }
}

class searchList extends StatefulWidget {
  final List<String> resultName;
  final List<String> resultDesc;
  final List<int> listIndex;
  const searchList(this.resultName, this.resultDesc, this.listIndex);

  @override
  _searchListState createState() => _searchListState();
}

class _searchListState extends State<searchList> {
  var names = <String>[];
  var descriptions = <String>[];
  var targetIndex = <int>[];
  var selectedName = <String>[];
  var selectedDesc = <String>[];
  final _liked = <String>[];

  @override
  void initState() {
    names = widget.resultName;
    descriptions = widget.resultDesc;
    targetIndex = widget.listIndex;
    for (int i = 0; i < targetIndex.length; i++) {
      selectedName.add(names[targetIndex[i]]);
      selectedDesc.add(descriptions[targetIndex[i]]);
    }
    super.initState();
  }

  Widget _resultList() {
    return ListView.separated(
      itemCount: selectedName.length+2,
      itemBuilder: (context, index) {
        if (index == 0) {
          return const titleSection("검색 결과");
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
                _liked.contains(selectedName[index-1]) ? Icons.star : Icons.star_border,
                color: _liked.contains(selectedName[index-1]) ? Colors.yellow : null,
                semanticLabel: _liked.contains(selectedName[index-1]) ? 'Remove from saved' : 'Save',
                size: 35,
              ),
              onPressed: (){
                setState(() {
                  if (_liked.contains(selectedName[index-1])) {
                    _liked.remove(selectedName[index-1]);
                  } else {
                    _liked.add(selectedName[index-1]);
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
      appBar: AppBar(
        title: const Text("Food.duck()"),
      ),
      body: _resultList(),
    );
  }
}
