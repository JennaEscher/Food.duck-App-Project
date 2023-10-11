import 'package:flutter/material.dart';
import 'home_page.dart';
import 'back/data_fetch.dart';

_checkDataFetch() {
  CounterStorage storage = CounterStorage();
  init(storage);
}

void main() {
  //Firebase에서 데이터 가져오기
  _checkDataFetch();
  //앱 실행
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}
