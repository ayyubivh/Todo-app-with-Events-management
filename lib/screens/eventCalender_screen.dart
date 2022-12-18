import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo_app/functions/db_functions.dart';
import 'package:todo_app/models/data_model.dart';
import 'package:todo_app/screens/screen_details.dart';
import 'package:todo_app/screens/screen_event_dtls.dart';
import 'package:todo_app/widgets/common_widgets/common_text.dart';

class EventScreen_calender extends StatefulWidget {
  const EventScreen_calender({super.key});

  @override
  State<EventScreen_calender> createState() => _EventScreen_calenderState();
}

class _EventScreen_calenderState extends State<EventScreen_calender> {
  List<TodoModel> todomodelist =
      Hive.box<TodoModel>('todo_task_db').values.toList();
  late List<TodoModel> todomodellistdisplay =
      List<TodoModel>.from(todomodelist);
  List<TodoEvent> todoEventlist =
      Hive.box<TodoEvent>('todo_Event_db').values.toList();
  late List<TodoEvent> todoEventlistdisplay =
      List<TodoEvent>.from(todoEventlist);

  DateTime today = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        //,   physics: BouncingScrollPhysics(),
        //  shrinkWrap: true,
        children: [
          Container(
            child: TableCalendar(
              focusedDay: today,
              firstDay: DateTime.utc(2010, 10, 11),
              lastDay: DateTime.utc(2030, 3, 14),
              headerStyle: const HeaderStyle(
                  formatButtonVisible: false, titleCentered: true),
              availableGestures: AvailableGestures.all,
              calendarStyle: const CalendarStyle(
                todayDecoration:
                    BoxDecoration(color: Colors.amber, shape: BoxShape.circle),
              ),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay; // update `_focusedDay` here as well
                });
              },
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            ),
          ),
          expandedEvent(),
        ],
      ),
    );
  }

  Widget expandedEvent() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: ValueListenableBuilder(
          valueListenable: todolisteventnotifier,
          builder: (BuildContext ctx, List<TodoEvent> todoEventlist,
                  Widget? child) =>
              ListView.builder(
            shrinkWrap: true,
            // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
            itemCount: todoEventlist.length,
            itemBuilder: (context, index) {
              // ignore: non_constant_identifier_names, avoid_types_as_parameter_names

              return DateTime.parse(todoEventlist[index].date.toString()).day ==
                          DateTime.now().day &&
                      DateTime.parse(todoEventlist[index].date.toString())
                              .month ==
                          DateTime.now().month &&
                      DateTime.parse(todoEventlist[index].date.toString())
                              .year ==
                          DateTime.now().year
                  ? Stack(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Screen_eventsdtls(
                                      passvalue: todoEventlist[index],
                                      passindex: index,
                                    )));
                          },
                          child: Container(
                            margin: EdgeInsets.fromLTRB(10.0, 2.0, 5.0, 3.0),
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
                                        deleteAllTodoevent(
                                            todoEventlist[index].id);
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            todoEventlist[index].title,
                                            style: const TextStyle(
                                                fontSize: 19.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          todoEventlist[index].priority ?? false
                                              ? Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.red[100],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: const Padding(
                                                    padding:
                                                        EdgeInsets.all(3.0),
                                                    child: Icon(
                                                      Icons
                                                          .hourglass_full_outlined,
                                                      size: 30,
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                )
                                              : Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.yellow[100],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: const Padding(
                                                    padding:
                                                        EdgeInsets.all(3.0),
                                                    child: Icon(
                                                      Icons.hourglass_bottom,
                                                      size: 30,
                                                      color: Colors.yellow,
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
                                            DateFormat("MMM, dd yyy hh:mm a")
                                                .format(
                                                    todoEventlist[index].date),
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
                          left: 15.0,
                          top: 5.0,
                          bottom: 8.0,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: Image(
                              width: 110.0,
                              image:
                                  FileImage(File(todoEventlist[index].image)),
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      ],
                    )
                  : texts(
                      mystring: "no events found ",
                      myfontsize: 16,
                      mycolor: Colors.black,
                      fontweight: FontWeight.bold);
            },
          ),
        ),
      ),
    );
  }
}
