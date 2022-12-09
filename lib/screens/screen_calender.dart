import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo_app/models/data_model.dart';
import 'package:todo_app/screens/screen_details.dart';

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
        child: Column(
          //,   physics: BouncingScrollPhysics(),
          //  shrinkWrap: true,
          children: [
            TableCalendar(
              eventLoader: _gettask,
              //    startingDayOfWeek: StartingDayOfWeek.monday,
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

              ///    daysOfWeekVisible: true,
            ),
            expandedTask(),
          ],
        ),
      ),
    );
  }

//task
  Widget expandedTask() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: ListView.builder(
            //physics: BouncingScrollPhysics(),
            //   scrollDirection: Axis.vertical,
            // shrinkWrap: true,
            itemCount: todomodellistdisplay.length,
            itemBuilder: (context, index) {
              return DateTime.parse(todomodelist[index].date.toString()).day ==
                          _selectedDay?.day &&
                      DateTime.parse(todomodelist[index].date.toString())
                              .month ==
                          _selectedDay?.month &&
                      DateTime.parse(todomodelist[index].date.toString())
                              .year ==
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
                          trailing:
                              todomodellistdisplay[index].priority ?? false
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
      ),
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
                              builder: (ctx) => Screen_details(
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
