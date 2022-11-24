import 'dart:async';

import 'package:flutter/material.dart';
import 'package:todo_app/screens/screen_home.dart';

class Screen_splash extends StatefulWidget {
  const Screen_splash({super.key});

  @override
  State<Screen_splash> createState() => _Screen_splashState();
}

class _Screen_splashState extends State<Screen_splash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
        Duration(seconds: 4),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Screen_home())));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Center(
        child: Image.asset(
          'Asset/images/splash.png',
        ),
      )),
    );
  }
}
