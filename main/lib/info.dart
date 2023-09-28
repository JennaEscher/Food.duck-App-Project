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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SubText2("Developers", "SGCC 프로젝트"),
          SizedBox(height: 20),
          SubText2("Contacts", "foodduck.app@gmail.com"),
        ],
      ),
    );

    Widget mainSection = Container(
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      height: MediaQuery.of(context).size.height * 0.72,
      decoration: BoxDecoration(
        color: Colors.transparent,
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
      body: SafeArea(
        child: ListView(
          children: [
            const titleSection("Info"),
            mainSection,
          ],
        ),
      ),
    );
  }
}
