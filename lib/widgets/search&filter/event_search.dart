import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/functions/db_functions.dart';
import 'package:todo_app/presentation/screen_search&filter.dart';

import '../../models/data_model.dart';
import '../../presentation/screen_event_dtls.dart';

class EventSearchView extends StatelessWidget {
  const EventSearchView({super.key, required this.searchNotifier});
  final ValueNotifier searchNotifier;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 0, top: 4),
      child: todoEventlistdisplay.isNotEmpty
          ? ValueListenableBuilder(
              valueListenable: searchNotifier,
              builder: (context, value, child) => ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  ValueListenableBuilder(
                      valueListenable: todolisteventnotifier,
                      builder: (BuildContext ctx,
                          List<TodoEvent> todoEventlistdisplays,
                          Widget? child) {
                        return ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: todoEventlistdisplay.length,
                            itemBuilder: (context, index) {
                              return Stack(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Screen_eventsdtls(
                                                    passvalue:
                                                        todoEventlistdisplay[
                                                            index],
                                                    passindex: index,
                                                  )));
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.fromLTRB(
                                          10.0, 2.0, 5.0, 3.0),
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(20),
                                        ),
                                      ),
                                      width: double.infinity,
                                      height: 120,
                                      child: Slidable(
                                          // closeOnScroll: false,
                                          startActionPane: ActionPane(
                                            motion: const StretchMotion(),
                                            children: [
                                              SlidableAction(
                                                //borderRadius: BorderRadius.circular(10.0),
                                                onPressed: ((context) {}),
                                                backgroundColor:
                                                    const Color.fromARGB(
                                                        255, 24, 207, 164),
                                                foregroundColor: Colors.white,
                                                icon: Icons.done_all,
                                                label: 'Done ',
                                              ),
                                            ],
                                          ),
                                          endActionPane: ActionPane(
                                            motion: const StretchMotion(),
                                            children: [
                                              SlidableAction(
                                                onPressed: ((context) {
                                                  deleteAllTodoevent(
                                                      todoEventlistdisplay[
                                                              index]
                                                          .id);
                                                  Fluttertoast.showToast(
                                                    msg: "deleted !!",
                                                    toastLength:
                                                        Toast.LENGTH_SHORT,
                                                    backgroundColor: Colors.red,
                                                    fontSize: 17,
                                                    gravity:
                                                        ToastGravity.BOTTOM,
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
                                                130.0, 10.0, 20.0, 0.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      todoEventlistdisplay[
                                                              index]
                                                          .title,
                                                      style: const TextStyle(
                                                          fontSize: 19.0,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    todoEventlistdisplay[index]
                                                                .priority ??
                                                            false
                                                        ? Container(
                                                            decoration: BoxDecoration(
                                                                color: Colors
                                                                    .red[100],
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            50)),
                                                            child:
                                                                const Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(3.0),
                                                              child: Icon(
                                                                Icons
                                                                    .trip_origin,
                                                                size: 25,
                                                                color:
                                                                    Colors.red,
                                                              ),
                                                            ),
                                                          )
                                                        : Container(
                                                            decoration: BoxDecoration(
                                                                color: Colors
                                                                        .yellow[
                                                                    100],
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            50)),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(3.0),
                                                              child: Icon(
                                                                Icons
                                                                    .trip_origin,
                                                                size: 25,
                                                                color: Colors
                                                                    .yellow
                                                                    .shade500,
                                                              ),
                                                            ),
                                                          ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 35,
                                                ),
                                                Row(
                                                  //     crossAxisAlignment: CrossAxisAlignment.end,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      DateFormat(
                                                              "MMM, dd yyy hh:mm a")
                                                          .format(
                                                              todoEventlistdisplay[
                                                                      index]
                                                                  .date),
                                                      style: const TextStyle(
                                                          color: Colors.black54,
                                                          fontSize: 15.0,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          )),
                                    ),
                                  ),
                                  Positioned(
                                    left: 11.0,
                                    top: 2.0,
                                    bottom: 5.0,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20.0),
                                      child: Image(
                                        width: 110.0,
                                        image: FileImage(File(
                                            todoEventlistdisplay[index].image)),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  )
                                ],
                              );
                            });
                      }),
                ],
              ),
            )
          : const Center(
              child: Text(
                ' No Events found',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w400),
              ),
            ),
    );
    ;
  }
}
