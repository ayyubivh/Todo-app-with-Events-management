import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/functions/db_functions.dart';
import 'package:todo_app/presentation/screen_event_dtls.dart';
import 'package:todo_app/widgets/noftification/notification.dart';
import '../../models/data_model.dart';
import 'home_tasklist_section.dart';

List<TodoEvent> upcomingEvent = [];
TodoEvent? notifydataEvnt;

class Home_eventsection extends StatelessWidget {
  const Home_eventsection({super.key});

  @override
  Widget build(BuildContext context) {
    checkTimeNotificationEvent();
    return ValueListenableBuilder(
      valueListenable: todolisteventnotifier,
      builder: (BuildContext ctx, List<TodoEvent> todoevent, Widget? child) {
        return ListView.builder(
          // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
          itemCount: todoevent.where((TodoEvent) {
            return DateTime.parse(TodoEvent.date.toString()).day ==
                    DateTime.now().day &&
                DateTime.parse(TodoEvent.date.toString()).month ==
                    DateTime.now().month &&
                DateTime.parse(TodoEvent.date.toString()).year ==
                    DateTime.now().year &&
                TodoEvent.isdone == false;
          }).length,
          itemBuilder: (context, index) {
            // ignore: non_constant_identifier_names, avoid_types_as_parameter_names
            final dataevent = todoevent.where((TodoEvent) {
              return DateTime.parse(TodoEvent.date.toString()).day ==
                      DateTime.now().day &&
                  DateTime.parse(TodoEvent.date.toString()).month ==
                      DateTime.now().month &&
                  DateTime.parse(TodoEvent.date.toString()).year ==
                      DateTime.now().year &&
                  TodoEvent.isdone == false;
            }).toList()[index];
            todoevent.sort((a, b) => a.date.compareTo(b.date));
            upcomingEvent = todoevent
                .where((element) => element.date.isAfter(DateTime.now()))
                .toList();

            // notifytime = upcomingEvent[0].date;
            // notifydataEvnt = upcomingEvent[0];
            for (int i = 0; i < upcomingEvent.length; i++) {
              notifytime = upcomingEvent[i].date;
              notifydataEvnt = upcomingEvent[i];
            }
            return Padding(
              padding: const EdgeInsets.all(3.0),
              child: Stack(
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
                      margin: const EdgeInsets.fromLTRB(10.0, 2.0, 5.0, 3.0),
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
                          endActionPane: ActionPane(
                            motion: const StretchMotion(),
                            children: [
                              SlidableAction(
                                //borderRadius: BorderRadius.circular(10.0),
                                onPressed: ((context) {
                                  markDoneEvent(dataevent, context);
                                }),
                                backgroundColor:
                                    const Color.fromARGB(255, 24, 207, 164),
                                foregroundColor: Colors.white,
                                icon: Icons.done_all,
                                label: 'Done ',
                              ),
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
                                130.0, 10.0, 20.0, 0.0),
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
                                      style: const TextStyle(
                                          fontSize: 19.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    dataevent.priority ?? false
                                        ? Container(
                                            decoration: BoxDecoration(
                                                color: Colors.red[100],
                                                borderRadius:
                                                    BorderRadius.circular(50)),
                                            child: const Padding(
                                              padding: EdgeInsets.all(3.0),
                                              child: Icon(
                                                Icons.trip_origin,
                                                size: 25,
                                                color: Colors.red,
                                              ),
                                            ),
                                          )
                                        : Container(
                                            decoration: BoxDecoration(
                                                color: Colors.yellow[100],
                                                borderRadius:
                                                    BorderRadius.circular(50)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(3.0),
                                              child: Icon(
                                                Icons.trip_origin,
                                                size: 25,
                                                color: Colors.yellow.shade500,
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
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      DateFormat(" hh:mm a")
                                          .format(dataevent.date),
                                      style: const TextStyle(
                                          color: Colors.black54,
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold),
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
                        image: FileImage(File(dataevent.image)),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
}

void markDoneEvent(TodoEvent dataevent, BuildContext context) {
  final updateEvent = TodoEvent(
    title: dataevent.title,
    description: dataevent.description,
    date: dataevent.date,
    image: dataevent.image,
    location: dataevent.location,
    priority: dataevent.priority,
    id: dataevent.id,
    isdone: true,
  );
  //  addevent(_todoevent);

  print("this is id {$dataevent.id}");
  editevent(dataevent.id, context, updateEvent);

  getAllTodoEvent();
}
