import 'package:flutter/material.dart';
import 'package:todo_app/widgets/add_task/add_taskform.dart';

class screen_addtask extends StatelessWidget {
  const screen_addtask({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Scaffold(
        body: ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: add_taskform(),
            ),
          ],
        ),
      );
    });
  }
}
