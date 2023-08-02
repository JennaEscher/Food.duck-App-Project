import 'package:flutter/material.dart';
import 'widget.dart';

class Info extends StatelessWidget {
  const Info({super.key});

  @override
  Widget build(BuildContext context) {
    Widget textSection = Container(
      padding: const EdgeInsets.fromLTRB(22, 25, 22, 15),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          subText("Developers", "SGCC 프로젝트"),
          SizedBox(height: 15),
          subText("Contacts", "foodduck.app@gmail.com"),
        ],
      ),
    );

    Widget mainSection = Container(
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      height: 590,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.transparent),
      ),
      child: Column(
        children: [
          textSection,
        ],
      ),
    );

    return MaterialApp(
      title: 'Food.duck()',
      home: Scaffold(
        body: SafeArea(
          child: ListView(
            children: [
              const iconSection(),
              const titleSection("Info"),
              mainSection,
            ],
          ),
        ),
      ),
    );
  }
}
