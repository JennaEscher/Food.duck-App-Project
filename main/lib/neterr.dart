import 'package:flutter/material.dart';
import 'drawer.dart';
import 'home_page.dart';

class Neterr extends StatelessWidget {
  Neterr({super.key});

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {

    const String letterstyle='NanumSquareB.ttf';


      return Scaffold(

      key: scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(//공통 앱바 안건드림
        //drawer기능 때문에 Appbar 필요
        toolbarHeight: 60,
        backgroundColor: Colors.transparent,
        elevation: 0, // 그림자
        actions: [
          Padding(
            padding: const EdgeInsets.only(
                right: 30.0), //top:10 하거나 Appbar의 height올릴수도 있음
            child: IconButton(
              icon: const Icon(
                Icons.menu,
                color: Colors.black,
                size: 40,
              ),
              onPressed: () {
                scaffoldKey.currentState?.openEndDrawer();
              },
            ),
          ),
        ],
        leading:
        Padding(
            padding: const EdgeInsets.only(
                left: 15.0),
                child:Image.asset(
          'assets/images/icon.png',
          height: 40,
          width: 40,
          ),
        ),
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

      body: Padding(//스크롤(열(텍스트, 자리용빈칸, 홈버튼))으로 구성됨
        
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child:Container(
            //color:const Color.fromRGBO(0, 0, 0, 1),
            padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 10),
            margin: const EdgeInsets.symmetric(vertical: 50,horizontal: 10), 
            child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 20),
                margin: const EdgeInsets.symmetric(vertical: 20,horizontal: 10),
                alignment: Alignment.center,
                child:RichText(text:const TextSpan(
                  children:<TextSpan>[
                    TextSpan(text:"404\n",style:TextStyle(
                      fontSize: 100,
                      fontFamily: letterstyle,
                      fontWeight: FontWeight.bold, color: Color.fromRGBO(0, 0, 0, 1),
                      
                      ),
                    ),

                    TextSpan(text:"서버에 연결할 수  없습니다\n홈으로 돌아가세요",style:TextStyle(
                      fontSize: 20,
                      fontFamily: letterstyle,
                      color: Color.fromRGBO(180, 180, 180, 1)),
                    ),
                  ]
                )
                ),
              ),

              const SizedBox(
                height: 30,
              ),
              
              IconButton(
              icon: const Icon(
                Icons.home,//왜 아이콘이 삐져나오지???
                color: Color.fromRGBO(180, 180, 180, 1),
                size: 50,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  HomePage()),
                );
              },
              ),
              


            ],
          ),
          ),
          
        ),
      ),
    );
  }
}