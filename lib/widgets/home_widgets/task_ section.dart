import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/util/app_color.dart';
import 'package:todo_app/widgets/common_widgets/common_text.dart';

class Task_section extends StatelessWidget {
  const Task_section({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(13.0),
          child: Container(
            height: 85,
            width: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  maincolor,
                  maincolor,
                  Colors.black38,
                ]),
                borderRadius: BorderRadius.circular(20)),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(
                  height: 13,
                ),
                Text(
                  'How was your life Going ?',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      fontFamily: GoogleFonts.poppins().fontFamily),
                ),
                const SizedBox(
                  height: 12,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      SizedBox(
                        width: 10,
                      ),
                      texts(
                          mystring: "Swipe to see your  ",
                          myfontsize: 16,
                          mycolor: Colors.white,
                          fontweight: FontWeight.w400),
                      texts(
                          mystring: "Event's",
                          myfontsize: 18,
                          mycolor: Colors.white,
                          fontweight: FontWeight.bold),
                      SizedBox(width: 10),
                      Icon(
                        Icons.arrow_forward,
                        size: 24,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 3,
        )
      ],
    );
  }
}
