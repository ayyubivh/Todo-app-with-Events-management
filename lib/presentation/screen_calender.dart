import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo_app/models/data_model.dart';
import 'package:todo_app/presentation/screen_details.dart';
import 'package:todo_app/provider/providers.dart';

import '../functions/db_functions.dart';

class Screen_calender extends StatelessWidget {
  Screen_calender({super.key});

  List<TodoModel> todomodelist =
      Hive.box<TodoModel>('todo_task_db').values.toList();

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
  CalendarFormat format = CalendarFormat.month;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.grey[200],
          child: Consumer(builder: (context, ref, child) {
            ref.watch(selectedDays);
            ref.watch(focusedDays);
            ref.watch(calenderFormaProvider);
            return Column(children: [
              TableCalendar(
                eventLoader: _gettask,
                calendarFormat: format,
                focusedDay: today,
                onFormatChanged: (CalendarFormat _format) {
                  format =
                      ref.read(calenderFormaProvider.notifier).state = _format;
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
                  _selectedDay =
                      ref.read(selectedDays.notifier).state = selectedDay;
                  _focusedDay =
                      ref.read(focusedDays.notifier).state = focusedDay;
                  // setState(() {
                  //   _selectedDay = selectedDay;
                  //   _focusedDay =
                  //       focusedDay; // update `_focusedDay` here as well
                  // });
                },
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              ),
              expandedTask()
            ]);
          }),
        ),
      ),
    );
  }

//task
  Widget expandedTask() {
    return Expanded(
        child: ListView.builder(
      itemCount: todomodelist.length,
      itemBuilder: (context, index) {
        return DateTime.parse(todomodelist[index].date.toString()).day ==
                    _selectedDay?.day &&
                DateTime.parse(todomodelist[index].date.toString()).month ==
                    _selectedDay?.month &&
                DateTime.parse(todomodelist[index].date.toString()).year ==
                    _selectedDay?.year
            ? (Padding(
                padding: const EdgeInsets.all(4.0),
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
                            //  7markDone(data, context);
                          }),
                          backgroundColor:
                              const Color.fromARGB(255, 24, 207, 164),
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
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Screen_details(
                                    passvalue: todomodelist[index],
                                    passindex: index,
                                  )));
                        },
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              todomodelist[index].title,
                              style: const TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        leading: todomodelist[index].priority ?? false
                            ? Container(
                                decoration: BoxDecoration(
                                    color: Colors.red[100],
                                    borderRadius: BorderRadius.circular(10)),
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
                                    borderRadius: BorderRadius.circular(10)),
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
                                padding: const EdgeInsets.only(top: 15.0),
                                child: Text(
                                  DateFormat("MMM, dd yyy hh:mm a")
                                      .format(todomodelist[index].date),
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
            : const SizedBox();
      },
    ));
  }
}
