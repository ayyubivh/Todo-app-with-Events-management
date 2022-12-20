import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_app/screens/screen_home.dart';

class Screen_splash extends StatefulWidget {
  const Screen_splash({super.key});

  @override
  State<Screen_splash> createState() => _Screen_splashState();
}

class _Screen_splashState extends State<Screen_splash> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const Screen_home())));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.network(
            'https://assets2.lottiefiles.com/packages/lf20_jy1bgnpp.json'),
      ),
    );
  }
}
