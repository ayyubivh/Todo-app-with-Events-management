import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/widgets/common_widgets/common_text.dart';

class Task_section extends StatelessWidget {
  const Task_section({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Column(
          children: [
            Container(
              height: 90,
              width: 350,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.blue.shade200, Colors.blue.shade600]),
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'How was your life Going?',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: GoogleFonts.poppins().fontFamily),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
