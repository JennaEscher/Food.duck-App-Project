import 'package:flutter/material.dart';
import 'home_page.dart';
import 'back/data_fetch.dart';

_checkDataFetch() {
  CounterStorage storage = CounterStorage();
  var t = init(storage);
  print(t);
  print("name");
  name.forEach((key, value) => print('${key} : ${value}'));
  print("tag");
  tag.forEach((key, value) => print('${key} : ${value}'));
  print("category");
  category.forEach((key, value) => print('${key} : ${value}'));
  print("trav_time");
  trav_time.forEach((key, value) => print('${key} : ${value}'));
  print(tags);
  print(categorys);
}

void main() {
  _checkDataFetch();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}
