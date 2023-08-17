import 'package:flutter/material.dart';
import 'package:project/widget.dart';

void main() => runApp(bookmarkResult());
final name = ["이태리부대찌개", "수저가", "홍원", "원더풀샤브샤브", "카페 나팔꽃", "가츠벤또", "야마노라멘", "정육면체", "신촌수제비", "네이버후드"];
final description = List<String>.generate(10, (i) => "$i");

class bookmarkResult extends StatelessWidget {
  const bookmarkResult({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food.duck()',
      home: searchList(name, description, [-1], "즐겨찾기"),
    );
  }
}