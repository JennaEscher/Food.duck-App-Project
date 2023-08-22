import 'package:flutter/material.dart';
import 'widget.dart';
import 'drawer.dart';

class Info extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  Info({super.key});

  @override
  Widget build(BuildContext context) {
    Widget textSection = Container(
      padding: const EdgeInsets.fromLTRB(22, 25, 22, 15),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SubText("Developers", "SGCC 프로젝트"),
          SizedBox(height: 15),
          SubText("Contacts", "foodduck.app@gmail.com"),
        ],
      ),
    );

    Widget mainSection = Container(
      margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.35),
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

    return Scaffold(
      key: scaffoldKey,
      appBar: CustomAppBar(
        scaffoldKey: scaffoldKey,
        title: 'Info',
      ),
      endDrawer: const SafeArea(
        child: Drawer(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50), bottomLeft: Radius.circular(50)),
          ),
          child: CustomDrawer(), // CustomDrawer 위젯 사용
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            mainSection,
          ],
        ),
      ),
    );
  }
}
