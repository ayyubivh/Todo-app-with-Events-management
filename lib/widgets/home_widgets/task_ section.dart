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
            const texts(
                mystring: "Hello Sam",
                myfontsize: 24,
                mycolor: Color.fromARGB(255, 48, 6, 93),
                fontweight: FontWeight.bold),
            const SizedBox(
              height: 5,
            ),
            const texts(
                mystring: 'How is your life balance this week',
                myfontsize: 15,
                mycolor: Color.fromARGB(238, 76, 6, 90),
                fontweight: FontWeight.w700),
            const SizedBox(
              height: 50,
            ),
            Row(
              children: const [
                SizedBox(
                  width: 20,
                ),
                texts(
                    mystring: "Today's tasks",
                    myfontsize: 20,
                    mycolor: Color.fromARGB(255, 48, 6, 93),
                    fontweight: FontWeight.w900),
              ],
            )
          ],
        ));
  }
}
