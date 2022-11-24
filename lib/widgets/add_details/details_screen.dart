import 'package:flutter/material.dart';

import 'package:todo_app/screens/screen_edit.dart';
import 'package:todo_app/widgets/common_widgets/common_text.dart';

class details_screen extends StatelessWidget {
  const details_screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      //crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 50.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: texts(
                  mystring: '16/07/2022',
                  myfontsize: 24,
                  mycolor: Colors.white,
                  fontweight: FontWeight.bold),
            ),
            Icon(
              Icons.calendar_month_outlined,
              size: 30,
              color: Colors.white,
            ),
          ],
        ),
        SizedBox(
          height: 20.0,
        ),
        Container(
          height: 83,
          width: 350.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22), color: Colors.black),
          child: Padding(
            padding: const EdgeInsets.all(23),
            child: texts(
                mystring: 'Running',
                myfontsize: 25,
                mycolor: Colors.white,
                fontweight: FontWeight.w500),
          ),
        ),
        SizedBox(
          height: 60,
        ),
        Container(
          height: 453,
          width: 350,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22), color: Colors.black),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.all(23),
                child: texts(
                    mystring: 'you want to complete your task',
                    myfontsize: 25,
                    mycolor: Colors.white,
                    fontweight: FontWeight.w500),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: IconButton(
                  icon: const Icon(
                    Icons.edit_note_rounded,
                    size: 52,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx1) => const screen_edit()));
                  },
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
