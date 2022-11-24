import 'package:flutter/material.dart';
import 'package:todo_app/widgets/common_widgets/common_text.dart';

class Task_section extends StatelessWidget {
  const Task_section({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Column(
          children: [
            texts(
                mystring: "Hello Sam",
                myfontsize: 28.0,
                mycolor: Colors.white,
                fontweight: FontWeight.bold),
            SizedBox(
              height: 5,
            ),
            texts(
                mystring: 'How is your life balance this week',
                myfontsize: 18,
                mycolor: Colors.white54,
                fontweight: FontWeight.w700),
            SizedBox(
              height: 90,
            ),
            Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                texts(
                    mystring: 'Your tasks',
                    myfontsize: 22,
                    mycolor: Colors.white,
                    fontweight: FontWeight.w500),
              ],
            )
          ],
        ));
  }
}
