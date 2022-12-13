import 'dart:io';

import 'package:flutter/material.dart';
import 'package:full_screen_image_null_safe/full_screen_image_null_safe.dart';
import 'package:intl/intl.dart';

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
                      height: 350,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: FileImage(
                                File(passvalue.image),
                              ),
                              fit: BoxFit.cover),
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(40),
                            bottomRight: Radius.circular(40),
                          )),
                    ),
                  ),
                )),
            Positioned(
              top: 30,
              left: 10,
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(
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
                  children: [
                    texts(
                        mystring: '${passvalue.title}',
                        myfontsize: 38,
                        mycolor: Colors.white,
                        fontweight: FontWeight.w600),
                    SizedBox(
                      height: 15,
                    ),
                    // Row(
                    //   children: [
                    //     Icon(
                    //       Icons.calendar_month_rounded,
                    //       color: Colors.white,
                    //     ),
                    //     SizedBox(
                    //       width: 10,
                    //     ),
                    //     Text(
                    //       DateFormat("dd  MMM,  yyy ").format(passvalue.date),
                    //       //  data.date.toString(),
                    //       style: const TextStyle(
                    //           color: Colors.white, fontSize: 16.0),
                    //     ),
                    //   ],
                    // ),
                  ]),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 18.0, top: 18.0),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(8)),
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Icon(
                    Icons.location_on,
                    color: Colors.blue[600],
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              texts(
                  mystring: passvalue.location,
                  myfontsize: 18,
                  mycolor: Colors.blue.shade700,
                  fontweight: FontWeight.bold),
              SizedBox(
                width: 195,
              ),
              passvalue.priority ?? false
                  ? Container(
                      decoration: BoxDecoration(
                          color: Colors.red[100],
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: const Icon(
                          Icons.hourglass_full_outlined,
                          size: 25,
                          color: Colors.red,
                        ),
                      ),
                    )
                  : Container(
                      decoration: BoxDecoration(
                          color: Colors.yellow[100],
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: const Icon(
                          Icons.hourglass_bottom,
                          size: 25,
                          color: Colors.yellow,
                        ),
                      ),
                    ),
            ],
          ),
        ),
        // Padding(
        //   padding: const EdgeInsets.only(
        //     left: 30.0,
        //   ),
        //   child: Container(
        //     height: 38,
        //     width: 240,
        //     decoration: BoxDecoration(
        //         color: Colors.white, borderRadius: BorderRadius.circular(16.0)),
        //     child: Padding(
        //       padding: const EdgeInsets.all(5.0),
        //       child: texts(
        //           mystring: passvalue.location,
        //           myfontsize: 19,
        //           mycolor: Colors.black54,
        //           fontweight: FontWeight.bold),
        //     ),
        //   ),
        // ),
        SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 20,
            ),
            // Container(
            //   decoration: BoxDecoration(
            //       color: Colors.blue[100],
            //       borderRadius: BorderRadius.circular(8)),
            //   child: Padding(
            //     padding: const EdgeInsets.all(3.0),
            //     child: Icon(
            //       Icons.notes_sharp,
            //       color: Colors.blue[600],
            //     ),
            //   ),
            // ),
            SizedBox(
              width: 8,
            ),
            texts(
                mystring: 'About           ',
                myfontsize: 18,
                mycolor: Colors.black,
                fontweight: FontWeight.bold),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 19,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(22),
            ),
            height: 250,
            width: 350,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    texts(
                        mystring: passvalue.description,
                        myfontsize: 16,
                        mycolor: Colors.black54,
                        fontweight: FontWeight.w600),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        FloatingActionButton(
                          onPressed: (() {
                            _showedieventtaskForm(context,
                                passvalue: passvalue, passindex: passindex);
                          }),
                          backgroundColor: Colors.blue[650],
                          child: Icon(Icons.edit),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

//  mainAxisAlignment: MainAxisAlignment.spaceAround,

// texts(
//     mystring: '${passvalue.description}',
//     myfontsize: 28.0,
//     mycolor: Colors.white,
//     fontweight: FontWeight.w500),

// Padding(
//   padding: const EdgeInsets.all(18),
//   child: FloatingActionButton(
//     backgroundColor: Colors.black,
//     onPressed: () {
//       _showedieventtaskForm(
//         context,
//         passvalue: passvalue,
//       );

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
      height: MediaQuery.of(context).size.height * 0.93,
      child: edit_eventform(passvalue: passvalue, passindex: passindex),
    ),
  );
}
