import 'package:flutter/material.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
    );

    _controller.repeat(
      period: const Duration(milliseconds: 2000),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: Container(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  final double angle = _controller.value * 360.0;
                  return Transform(
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001) // 3D 변환을 위한 행렬 설정
                      ..translate(0.0, 0.0, -60.0) // Z 축 방향으로 이동하여 중심으로
                      ..rotateY(angle * (3.14159265359 / 180)), // Y 축 주위로 회전
                    alignment: FractionalOffset.center,
                    child: Image.asset(
                      'assets/images/icon.png',
                      height: 120,
                      width: 120,
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "loading...",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontFamily: "NanumSquare_ac",
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
