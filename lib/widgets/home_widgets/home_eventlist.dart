import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/functions/db_functions.dart';
import 'package:todo_app/screens/screen_event_dtls.dart';

import '../../models/data_model.dart';

class Home_eventsection extends StatefulWidget {
  const Home_eventsection({super.key});

  @override
  State<Home_eventsection> createState() => _Home_eventsection();
}

class _Home_eventsection extends State<Home_eventsection> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: todolisteventnotifier,
      builder: (BuildContext ctx, List<TodoEvent> todoevent, Widget? child) {
        return Expanded(
          child: ListView.builder(
            // shrinkWrap: true,
            // physics: NeverScrollableScrollPhysics(),
            itemCount: todoevent.where((TodoModel) {
              return DateTime.parse(TodoModel.date.toString()).day ==
                      DateTime.now().day &&
                  DateTime.parse(TodoModel.date.toString()).month ==
                      DateTime.now().month &&
                  DateTime.parse(TodoModel.date.toString()).year ==
                      DateTime.now().year;
            }).length,
            itemBuilder: (context, index) {
              final dataevent = todoevent.where((TodoModel) {
                return DateTime.parse(TodoModel.date.toString()).day ==
                        DateTime.now().day &&
                    DateTime.parse(TodoModel.date.toString()).month ==
                        DateTime.now().month &&
                    DateTime.parse(TodoModel.date.toString()).year ==
                        DateTime.now().year;
              }).toList()[index];
              return Stack(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Screen_eventsdtls(
                                passvalue: dataevent,
                                passindex: index,
                              )));
                    },
                    child: Container(
                      margin: EdgeInsets.fromLTRB(40.0, 5.0, 20.0, 5.0),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      width: double.infinity,
                      height: 125,
                      child: Slidable(
                          // closeOnScroll: false,
                          startActionPane: ActionPane(
                            motion: StretchMotion(),
                            children: [
                              SlidableAction(
                                //borderRadius: BorderRadius.circular(10.0),
                                onPressed: ((context) {}),
                                backgroundColor:
                                    Color.fromARGB(255, 24, 207, 164),
                                foregroundColor: Colors.white,
                                icon: Icons.done_all,
                                label: 'Done ',
                              ),
                            ],
                          ),
                          endActionPane: ActionPane(
                            motion: StretchMotion(),
                            children: [
                              SlidableAction(
                                onPressed: ((context) {
                                  deleteAllTodoevent(dataevent.id);
                                  Fluttertoast.showToast(
                                    msg: "deleted !!",
                                    toastLength: Toast.LENGTH_SHORT,
                                    backgroundColor: Colors.red,
                                    fontSize: 17,
                                    gravity: ToastGravity.BOTTOM,
                                  );
                                }),
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white,
                                icon: Icons.delete,
                                label: 'delete',
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(
                                110.0, 20.0, 20.0, 20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      dataevent.title,
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    dataevent.priority ?? false
                                        ? Container(
                                            decoration: BoxDecoration(
                                                color: Colors.red[100],
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: const Padding(
                                              padding:
                                                  const EdgeInsets.all(3.0),
                                              child: const Icon(
                                                Icons.hourglass_full_outlined,
                                                size: 35,
                                                color: Colors.red,
                                              ),
                                            ),
                                          )
                                        : Container(
                                            decoration: BoxDecoration(
                                                color: Colors.yellow[100],
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(3.0),
                                              child: const Icon(
                                                Icons.hourglass_bottom,
                                                size: 35,
                                                color: Colors.yellow,
                                              ),
                                            ),
                                          ),
                                  ],
                                ),
                                SizedBox(
                                  height: 19,
                                ),
                                Row(
                                  //     crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      DateFormat("MMM, dd yyy hh:mm a")
                                          .format(dataevent.date),
                                      style: const TextStyle(
                                          color: Colors.black54,
                                          //fontSize: 16.0,
                                          fontWeight: FontWeight.w800),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
                          // ListTile(
                          //   onTap: () {
                          //     Navigator.of(context).push(MaterialPageRoute(
                          //         builder: (context) => Screen_eventsdtls(
                          //               passvalue: dataevent,
                          //               passindex: index,
                          //             )));
                          //   },
                          //   title: Column(
                          //     children: [
                          //       Row(
                          //         //crossAxisAlignment: CrossAxisAlignment.start,
                          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //         children: [
                          //           Column(
                          //             crossAxisAlignment: CrossAxisAlignment.start,
                          //             children: [
                          //               Text(
                          //                 dataevent.title,
                          //                 style: TextStyle(
                          //                     fontSize: 22.0,
                          //                     fontWeight: FontWeight.w500),
                          //               ),
                          //               SizedBox(
                          //                 height: 20.0,
                          //               ),
                          //               Container(
                          //                 child: Row(
                          //                   children: [
                          //                     SizedBox(
                          //                       width: 90,
                          //                     ),
                          //                     Text(
                          //                       DateFormat("MMM, dd yyy ")
                          //                           .format(dataevent.date),
                          //                       //  data.date.toString(),
                          //                       style: const TextStyle(
                          //                           // fontSize: 16.0,
                          //                           fontWeight: FontWeight.w800),
                          //                     ),
                          //                   ],
                          //                 ),
                          //               ),
                          //             ],
                          //           ),
                          //           // SizedBox(
                          //           //   width: 110,
                          //           //   height: 85.0,
                          //           //   child: Image.file(
                          //           //     File(dataevent.image),
                          //           //     fit: BoxFit.fitWidth,
                          //           //   ),
                          //           // ),
                          //           Row(
                          //             crossAxisAlignment: CrossAxisAlignment.start,
                          //             children: [
                          //               Padding(
                          //                   padding: EdgeInsets.all(17.0),
                          //                   child: dataevent.priority ?? false
                          //                       ? const Icon(
                          //                           Icons.hourglass_full_outlined,
                          //                           size: 35,
                          //                           color: Colors.red)
                          //                       : Icon(
                          //                           Icons.hourglass_bottom,
                          //                           size: 35,
                          //                           color: Colors.yellow,
                          //                         )),
                          //               Padding(
                          //                 padding: const EdgeInsets.all(3),
                          //                 child: Container(
                          //                   height: 78,
                          //                   width: 70,
                          //                   child: Image.file(File(dataevent.image)),
                          //                 ),
                          //               ),
                          //             ],
                          //           )
                          //         ],
                          //       ),
                          //     ],
                          //   ),
                          //   // trailing: Image.file(File(dataevent.image))
                          //   // Padding(
                          //   //   padding: const EdgeInsets.all(18.0),
                          //   //   child: dataevent.priority ?? false
                          //   //       ? const Icon(
                          //   //           Icons.hourglass_full_outlined,
                          //   //           size: 30,
                          //   //           color: Colors.red,
                          //   //         )
                          //   //       : const Icon(
                          //   //           Icons.hourglass_bottom,
                          //   //           size: 30,
                          //   //           color: Colors.yellow,
                          //   //         ),
                          //   // ),
                          // )),
                          ),
                    ),
                  ),
                  Positioned(
                    left: 20.0,
                    top: 15.0,
                    bottom: 15.0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Image(
                        width: 110.0,
                        image: FileImage(File(dataevent.image)),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        );
      },
    );
  }
}
