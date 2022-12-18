import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo_app/models/data_model.dart';
import 'package:todo_app/screens/screen_details.dart';

import '../functions/db_functions.dart';
import '../widgets/home_widgets/home_tasklist_section.dart';

class Screen_calender extends StatefulWidget {
  const Screen_calender({super.key});

  @override
  State<Screen_calender> createState() => _Screen_calenderState();
}

class _Screen_calenderState extends State<Screen_calender> {
  List<TodoModel> todomodelist =
      Hive.box<TodoModel>('todo_task_db').values.toList();
  late List<TodoModel> todomodellistdisplay =
      List<TodoModel>.from(todomodelist);
  List<TodoEvent> todoEventlist =
      Hive.box<TodoEvent>('todo_Event_db').values.toList();
  late List<TodoEvent> todoEventlistdisplay =
      List<TodoEvent>.from(todoEventlist);
  //final index = [];
  List<TodoModel> _gettask(DateTime date) {
    todomodelist.where((TodoModel) {
      return DateTime.parse(TodoModel.date.toString()).day ==
              _selectedDay?.day &&
          DateTime.parse(TodoModel.date.toString()).month ==
              _selectedDay?.month &&
          DateTime.parse(TodoModel.date.toString()).year == _selectedDay?.year;
    }).toList();
    return todomodelist;
  }

  DateTime today = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  @override
  void initState() {
    _selectedDay = _focusedDay;
    super.initState();
  }

  CalendarFormat format = CalendarFormat.month;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.grey[200],
          child: Column(
            children: [
              TableCalendar(
                eventLoader: _gettask,
                calendarFormat: format,
                focusedDay: today,
                onFormatChanged: (CalendarFormat _format) {
                  setState(() {
                    format = _format;
                  });
                },
                firstDay: DateTime.utc(2010, 10, 11),
                lastDay: DateTime.utc(2030, 3, 14),
                headerStyle: const HeaderStyle(
                    titleCentered: true,
                    formatButtonVisible: true,
                    formatButtonShowsNext: false),
                availableGestures: AvailableGestures.all,
                calendarStyle: const CalendarStyle(
                  todayDecoration: BoxDecoration(
                      color: Colors.amber, shape: BoxShape.circle),
                ),
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay =
                        focusedDay; // update `_focusedDay` here as well
                  });
                },
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              ),
              expandedTask(),
            ],
          ),
        ),
      ),
    );
  }

//task
  Widget expandedTask() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: ValueListenableBuilder(
            valueListenable: todolistnotifier,
            builder: (BuildContext ctx, List<TodoModel> todomodelist,
                Widget? child) {
              return ListView.builder(
                itemCount: todomodelist.length,
                itemBuilder: (context, index) {
                  return DateTime.parse(todomodelist[index].date.toString())
                                  .day ==
                              _selectedDay?.day &&
                          DateTime.parse(todomodelist[index].date.toString())
                                  .month ==
                              _selectedDay?.month &&
                          DateTime.parse(todomodelist[index].date.toString())
                                  .year ==
                              _selectedDay?.year
                      ? (Padding(
                          padding: const EdgeInsets.all(13.0),
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(25),
                              ),
                            ),
                            child: Slidable(
                              startActionPane: ActionPane(
                                motion: const StretchMotion(),
                                children: [
                                  SlidableAction(
                                    //borderRadius: BorderRadius.circular(10.0),
                                    onPressed: ((context) {
                                      //    markDone(data, context);
                                    }),
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
                                      deleteAllTodotask(todomodelist[index].id);
                                      Fluttertoast.showToast(
                                        msg: 'deleted !!',
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
                                padding: const EdgeInsets.all(8.0),
                                child: ListTile(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                Screen_details(
                                                  passvalue:
                                                      todomodelist[index],
                                                  passindex: index,
                                                )));
                                  },
                                  title: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        todomodelist[index].title,
                                        style: const TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  leading: todomodelist[index].priority ?? false
                                      ? Container(
                                          decoration: BoxDecoration(
                                              color: Colors.red[100],
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: const Padding(
                                            padding: EdgeInsets.all(3.0),
                                            child: Icon(
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
                                          child: const Padding(
                                            padding: EdgeInsets.all(3.0),
                                            child: Icon(
                                              Icons.hourglass_bottom,
                                              size: 35,
                                              color: Colors.yellow,
                                            ),
                                          ),
                                        ),
                                  subtitle: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(),
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 15.0),
                                          child: Text(
                                            DateFormat("MMM, dd yyy hh:mm a")
                                                .format(
                                                    todomodelist[index].date),
                                            //  data.date.toString(),
                                            style: const TextStyle(
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.w800),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ))
                      : const Center(
                          child: Text(
                            '  ',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.w400),
                          ),
                        );
                },
              );
            }),
      ),
    );
  }
}
