import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/presentation/screen_home.dart';

// ignore: camel_case_types
class Screen_splash extends StatelessWidget {
  const Screen_splash({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2))
        .then((value) => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const Screen_home(),
            )));
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
