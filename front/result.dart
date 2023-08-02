import 'package:flutter/material.dart';
import 'drawer.dart';



class Result extends StatelessWidget {
  Result({super.key});


  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {
    //스트링 입력 받기 전 예시
    String storeName = "또솥";
    String menu = "인간사료 - 한솥";
    String position = "서강고등학교";
    String pricelevel = "1,000,000원 대";
    String description ="사각형 안의 사각형 안의 사각형 안의 사각형이 있소 열 두명의 아해가 두렵다고 그러오";
    String? storeimage;

    //임시
    storeimage='assets/images/sample.png';
    String? tagstring;
    tagstring="#임의태그 #예시태그";

    return Scaffold(

      key: scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
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
        
      

      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(

          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),                
                child:Row(
                
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(storeName, textAlign: TextAlign.left,
            style: const TextStyle(
                fontSize: 35,
                fontFamily: 'NanumSquareB.ttf',
                fontWeight: FontWeight.bold)),
//임시
             IconButton(
              icon: const Icon(
                Icons.star,
                color: Color.fromRGBO(220, 220, 220, 1),
                size: 50,
              ),
              onPressed: () {
                //좋아요 표시 작동
              },
            ),
                
                ],
              ),
              ),
              

              
              Container(
                
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                 color: const Color.fromRGBO(243, 243, 243, 1),
                 
                ),
                margin: const EdgeInsets.symmetric(horizontal: 5,vertical: 20),

                

                child: Column(
                  
                  children: [
                    Container(
                      alignment: Alignment.topCenter,
                      width: double.infinity,
                      //color: const Color.fromRGBO(0, 0,0, 1),
                      margin: const EdgeInsets.fromLTRB(10, 15, 10, 10),

                      child:ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child:
                      Image.asset(
                      storeimage,
                      ),
                    ),
                    ),

                    Container(
                      alignment: Alignment.topLeft,
                      margin: const EdgeInsets.symmetric(horizontal: 30),
                      child:Text(tagstring, textAlign: TextAlign.justify,
                        style: const TextStyle(
                          fontSize: 20-4,
                          fontFamily: 'NanumSquareB.ttf',
                          color: Color.fromRGBO(180, 180, 180, 1)
                        )
                      ),

                    ),



                    Container(
                      alignment: Alignment.topLeft,
                      margin: const EdgeInsets.fromLTRB(30, 20, 30, 0),
                      child:RichText(
                          text:TextSpan(
                          
                            children:<TextSpan>[
                              const TextSpan(text:"메뉴: ",style:TextStyle(
                            fontSize: 20,
                            fontFamily: 'NanumSquareB.ttf',
                            fontWeight: FontWeight.bold, color: Color.fromRGBO(0, 0, 0, 1)),),

                            TextSpan(text: '$menu\n', 
                            style: const TextStyle(
                                fontSize: 20,
                                fontFamily: 'NanumSquareB.ttf', color: Color.fromRGBO(0, 0, 0, 1),
                                )
                            ),

                            const TextSpan(text: '\n', 
                            style: TextStyle(
                                fontSize: 5,
                                fontFamily: 'NanumSquareB.ttf', color: Color.fromRGBO(0, 0, 0, 1),
                                )
                            ),

                            const TextSpan(text:"위치: ",style:TextStyle(
                            fontSize: 20,
                            fontFamily: 'NanumSquareB.ttf',
                            fontWeight: FontWeight.bold, color: Color.fromRGBO(0, 0, 0, 1)),),

                            TextSpan(text: '$position\n', 
                            style: const TextStyle(
                                fontSize: 20,
                                fontFamily: 'NanumSquareB.ttf', color: Color.fromRGBO(0, 0, 0, 1))
                            ),

                            const TextSpan(text: '\n', 
                            style: TextStyle(
                                fontSize: 5,
                                fontFamily: 'NanumSquareB.ttf', color: Color.fromRGBO(0, 0, 0, 1),
                                )
                            ),

                            const TextSpan(text:"가격대: ",style:TextStyle(
                            fontSize: 20,
                            fontFamily: 'NanumSquareB.ttf',
                            fontWeight: FontWeight.bold, color: Color.fromRGBO(0, 0, 0, 1)),),

                            TextSpan(text: '$pricelevel\n', 
                            style: const TextStyle(
                                fontSize: 20,
                                fontFamily: 'NanumSquareB.ttf', color: Color.fromRGBO(0, 0, 0, 1))
                              )
                            ]
                          )
                        ),

                    ),

                    
  

                    Container(
                      decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: const Color.fromRGBO(255, 255, 255, 1),
                 
                      ),
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: 120,
                      margin: const EdgeInsets.fromLTRB(20, 0, 20, 25),
                      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                      
                      child: Text(description, textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 20-2,
                          fontFamily: 'NanumSquareB.ttf',
                        )
                      ),


                  )

                  ],
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}