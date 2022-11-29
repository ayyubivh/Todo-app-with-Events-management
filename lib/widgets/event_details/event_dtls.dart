import 'dart:io';

import 'package:flutter/material.dart';

import 'package:todo_app/widgets/common_widgets/common_text.dart';
import 'package:todo_app/widgets/events_edit/events_edit.dart';

class Eventdtls extends StatelessWidget {
  Eventdtls({
    super.key,
    required this.passvalue,
  });
  var passvalue;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 40.0,
        ),
        texts(
            mystring: 'Your Event',
            myfontsize: 30.0,
            mycolor: Colors.white,
            fontweight: FontWeight.bold),
        SizedBox(
          height: 20.0,
        ),
        texts(
            mystring: '${passvalue.date}',
            myfontsize: 28.0,
            mycolor: Colors.white,
            fontweight: FontWeight.w400),
        SizedBox(
          height: 20,
        ),
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: FileImage(File(passvalue.image)), fit: BoxFit.fill),
              borderRadius: BorderRadius.circular(14.0),
              color: Colors.grey),
          width: 278,
          height: 346,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          //  mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: 30,
            ),
            texts(
                mystring: '${passvalue.title}',
                myfontsize: 38,
                mycolor: Colors.white,
                fontweight: FontWeight.w600),
            SizedBox(
              height: 16,
            ),
            texts(
                mystring: '${passvalue.description}',
                myfontsize: 28.0,
                mycolor: Colors.white,
                fontweight: FontWeight.w500),
            SizedBox(
              height: 13,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(18),
              child: FloatingActionButton(
                backgroundColor: Colors.black,
                onPressed: () {
                  _showedieventtaskForm(
                    context,
                    passvalue: passvalue,
                  );
                },
                child: Icon(
                  Icons.edit_calendar_outlined,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}

void _showedieventtaskForm(BuildContext context, {required passvalue}) {
  showModalBottomSheet(
    backgroundColor: Colors.transparent,
    isDismissible: false,
    isScrollControlled: true,
    context: context,
    builder: (_) => Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.0),
          topRight: Radius.circular(25.0),
        ),
      ),
      height: MediaQuery.of(context).size.height * 0.73,
      child: events_edit(passvalue: passvalue),
    ),
  );
}
