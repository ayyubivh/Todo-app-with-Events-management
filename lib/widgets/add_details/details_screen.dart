import 'package:flutter/material.dart';

import 'package:todo_app/widgets/common_widgets/common_text.dart';

import '../edit_task/edit_taskform.dart';

class details_screen extends StatelessWidget {
  details_screen({super.key, required this.passvalue});
  var passvalue;
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
              padding: EdgeInsets.all(18.0),
              child: texts(
                  mystring: '${passvalue.date}',
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
            borderRadius: BorderRadius.circular(22),
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(232, 67, 123, 202),
                Color.fromRGBO(100, 98, 222, 20),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Padding(
              padding: const EdgeInsets.all(23),
              child: Text(
                '${passvalue.title}',
                style: TextStyle(color: Colors.white, fontSize: 24.0),
              )),
        ),
        SizedBox(
          height: 60,
        ),
        Container(
          height: 453,
          width: 350,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(232, 67, 123, 202),
                Color.fromRGBO(100, 98, 222, 20),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                  padding: EdgeInsets.all(23),
                  child: Text(
                    '${passvalue.description}',
                    style: TextStyle(color: Colors.white, fontSize: 22.0),
                  )),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.edit_note_rounded,
                        size: 52,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        _showeditaddtaskForm(context, passvalue: passvalue);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

void _showeditaddtaskForm(BuildContext context, {required passvalue}) {
  showModalBottomSheet(
    backgroundColor: Colors.white,
    isDismissible: false,
    isScrollControlled: true,
    context: context,
    builder: (_) => Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.0),
          topRight: Radius.circular(25.0),
        ),
      ),
      height: MediaQuery.of(context).size.height * 0.70,
      child: edit_taskform(passvalue: passvalue),
    ),
  );
}
