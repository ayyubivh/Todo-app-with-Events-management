import 'dart:io';

import 'package:flutter/material.dart';
import 'package:full_screen_image_null_safe/full_screen_image_null_safe.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/util/app_color.dart';
import 'package:todo_app/widgets/add_task/flatbutton.dart';

import 'package:todo_app/widgets/common_widgets/common_text.dart';
import 'package:todo_app/widgets/events_edit/events_edit.dart';

class Eventdtls extends StatelessWidget {
  Eventdtls({
    super.key,
    required this.passvalue,
    required this.passindex,
  });
  var passindex;
  var passvalue;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: <Widget>[
            Hero(
                tag: Image.file(
                  File(passvalue.image),
                  //   fit: BoxFit.cover,
                ),
                child: GestureDetector(
                  child: FullScreenWidget(
                    child: Container(
                      height: 300,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: FileImage(
                              File(passvalue.image),
                            ),
                            fit: BoxFit.cover),
                      ),
                    ),
                  ),
                )),
            Positioned(
              top: 30,
              left: 10,
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
            Positioned(
              top: 290,
              //bottom: 10,
              left: 30,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    SizedBox(
                      height: 15,
                    ),
                  ]),
            ),
            Positioned(
              top: 275.0,
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    )),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              texts(
                  mystring: '${passvalue.title}',
                  myfontsize: 25,
                  mycolor: Colors.black,
                  fontweight: FontWeight.w600),
              const SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.calendar_month_outlined,
                    color: Colors.black54,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    DateFormat("dd  MMM, yyy ").format(passvalue.date),
                    //  data.date.toString(),
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Icon(
                    Icons.location_on,
                    color: Colors.grey[600],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  texts(
                      mystring: passvalue.location,
                      myfontsize: 18,
                      mycolor: Colors.black,
                      fontweight: FontWeight.w500),
                ],
              ),
              const SizedBox(height: 18),
              const texts(
                  mystring: 'About  ',
                  myfontsize: 18,
                  mycolor: Colors.black,
                  fontweight: FontWeight.bold),
              const SizedBox(
                height: 5,
              ),
              texts(
                  mystring: passvalue.description,
                  myfontsize: 16,
                  mycolor: Colors.black54,
                  fontweight: FontWeight.w600),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 148),
          child: Center(
              child: FlatButton(
                  mycolor: Kwhite,
                  mystring: ' Edit Event',
                  onpressaction: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => edit_eventform(
                            passvalue: passvalue, passindex: passindex)));
                  })),
        )
      ],
    );
  }
}

void _showedieventtaskForm(BuildContext context,
    {required passvalue, required passindex}) {
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
      height: MediaQuery.of(context).size.height * 0.86,
      child: edit_eventform(passvalue: passvalue, passindex: passindex),
    ),
  );
}
