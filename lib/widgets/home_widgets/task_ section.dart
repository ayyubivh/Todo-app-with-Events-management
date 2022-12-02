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
                mycolor: Color.fromARGB(255, 48, 6, 93),
                fontweight: FontWeight.bold),
            SizedBox(
              height: 5,
            ),
            texts(
                mystring: 'How is your life balance this week',
                myfontsize: 18,
                mycolor: Color.fromARGB(207, 76, 6, 90),
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
                    mystring: "Today's tasks",
                    myfontsize: 22,
                    mycolor: Color.fromARGB(255, 65, 7, 112),
                    fontweight: FontWeight.w500),
              ],
            )
          ],
        ));
  }
}
