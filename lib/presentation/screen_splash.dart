import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/presentation/screen_home.dart';

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
      backgroundColor: Colors.black,
      body: Center(
        child: Text(
          'Lets do',
          style: GoogleFonts.arvo(
              fontSize: 55.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 2),
        ),
      ),
    );
  }
}
