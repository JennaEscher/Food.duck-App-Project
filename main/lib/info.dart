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
          SizedBox(height: 10),

          MemText("가나다","야호!!!"),
          SizedBox(height: 5),
          MemText("가나다","야호!!!"),
          SizedBox(height: 5),
          MemText("가나다","야호!!!"),
          SizedBox(height: 5),
          MemText("가나다","야호!!!"),
          SizedBox(height: 5),
          MemText("가나다","야호!!!"),
          SizedBox(height: 5),
          MemText("가나다","야호!!!"),
          SizedBox(height: 15),


          SubText("소속", "서강대학교 SGCC 동아리"),
          SizedBox(height: 7),
          SubText("Contacts", "foodduck.app@gmail.com"),
          SizedBox(height: 7),
          Text("어플리케이션이 비정상적인 행동을 취할 경우 위 연락처로 알려주세요",textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 18,
              fontFamily: "NanumSquare_ac",
              fontWeight: FontWeight.w300,
            ),),
          SizedBox(height: 15),
          MemText("제작기간","2023/7/ - 2023/8/31"),
          SizedBox(height: 10),
          MemText("","ver1.0"),
          
        ],
      ),
    );

    
    

    Widget mainSection = Container(
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      height: MediaQuery.of(context).size.height - 200,
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
