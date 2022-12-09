import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo_app/models/data_model.dart';
import 'package:todo_app/screens/screen_details.dart';
import 'package:todo_app/screens/screen_event_dtls.dart';

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
              headerStyle:
                  HeaderStyle(formatButtonVisible: false, titleCentered: true),
              availableGestures: AvailableGestures.all,
              calendarStyle: CalendarStyle(
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

//task
  Widget expandedTask() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: ListView.builder(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: todomodellistdisplay.length,
          itemBuilder: (context, index) {
            return DateTime.parse(todomodelist[index].date.toString()).day ==
                        _selectedDay?.day &&
                    DateTime.parse(todomodelist[index].date.toString()).month ==
                        _selectedDay?.month &&
                    DateTime.parse(todomodelist[index].date.toString()).year ==
                        _selectedDay?.year
                ? (Padding(
                    padding: const EdgeInsets.all(14.0),
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
                      child: ListTile(
                        title: Text(
                          todomodellistdisplay[index].title,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22.0,
                              fontWeight: FontWeight.w500),
                        ),
                        trailing: todomodellistdisplay[index].priority ?? false
                            ? const Icon(
                                Icons.hourglass_full_outlined,
                                size: 35,
                                color: Colors.red,
                              )
                            : const Icon(
                                Icons.hourglass_bottom,
                                size: 35,
                                color: Colors.yellow,
                              ),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              DateFormat("MMM, dd yyy ")
                                  .format(todomodellistdisplay[index].date),
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w800),
                            ),
                          ],
                        ),
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (ctx) => Screen_details(
                                    passvalue: todomodellistdisplay[index],
                                    passindex: index,
                                  )),
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
          }),
    );
  }

  //event

  Widget expandedEvent() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: ListView.builder(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: todoEventlistdisplay.length,
          itemBuilder: (context, index) {
            return DateTime.parse(todoEventlist[index].date.toString()).day ==
                        _selectedDay?.day &&
                    DateTime.parse(todoEventlist[index].date.toString())
                            .month ==
                        _selectedDay?.month &&
                    DateTime.parse(todoEventlist[index].date.toString()).year ==
                        _selectedDay?.year
                ? (Padding(
                    padding: const EdgeInsets.all(14.0),
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
                      child: ListTile(
                        title: Text(
                          todoEventlistdisplay[index].title,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22.0,
                              fontWeight: FontWeight.w500),
                        ),
                        trailing: todoEventlistdisplay[index].priority ?? false
                            ? const Icon(
                                Icons.hourglass_full_outlined,
                                size: 35,
                                color: Colors.red,
                              )
                            : const Icon(
                                Icons.hourglass_bottom,
                                size: 35,
                                color: Colors.yellow,
                              ),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              DateFormat("MMM, dd yyy ")
                                  .format(todoEventlistdisplay[index].date),
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w800),
                            ),
                          ],
                        ),
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (ctx) => Screen_eventsdtls(
                                    passvalue: todoEventlistdisplay[index],
                                    passindex: index,
                                  )),
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
          }),
    );
  }
}
