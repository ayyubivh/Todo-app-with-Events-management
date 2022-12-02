import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_slidable/flutter_slidable.dart';
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
        return ListView.builder(
          // shrinkWrap: true,
          // physics: NeverScrollableScrollPhysics(),
          itemCount: todoevent.length,
          itemBuilder: (context, index) {
            final dataevent = todoevent[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                color: Colors.transparent,
                shadowColor: Color.fromARGB(255, 1, 8, 11),
                elevation: 5,
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(146, 51, 48, 114),
                        Color.fromARGB(133, 83, 79, 165),
                      ],
                      begin: Alignment.bottomRight,
                      end: Alignment.topLeft,
                    ),
                  ),
                  width: 324,
                  height: 90,
                  child: Slidable(
                    // closeOnScroll: false,
                    startActionPane: ActionPane(
                      motion: StretchMotion(),
                      children: [
                        SlidableAction(
                          //borderRadius: BorderRadius.circular(10.0),
                          onPressed: ((context) {}),
                          backgroundColor: Color.fromARGB(255, 24, 207, 164),
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
                            deleteAllTodoevent(index);
                          }),
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: 'delete',
                        ),
                      ],
                    ),
                    child: ListTile(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Screen_eventsdtls(
                                  passvalue: dataevent,
                                )));
                      },
                      title: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    dataevent.title,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Container(
                                    child: Text(
                                      DateFormat("MMM, dd yyy ")
                                          .format(dataevent.date),
                                      //  data.date.toString(),
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 16.0),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 110,
                                height: 85.0,
                                child: Image.file(
                                  File(dataevent.image),
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      trailing: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: dataevent.priority ?? false
                            ? const Icon(
                                Icons.hourglass_full_outlined,
                                size: 30,
                                color: Colors.red,
                              )
                            : const Icon(
                                Icons.hourglass_bottom,
                                size: 30,
                                color: Colors.yellow,
                              ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
