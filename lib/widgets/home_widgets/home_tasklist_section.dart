import 'package:flutter/material.dart';

import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import 'package:todo_app/functions/db_functions.dart';
import 'package:todo_app/screens/screen_details.dart';
import 'package:todo_app/widgets/noftification/notification.dart';

import '../../models/data_model.dart';

DateTime notifytime = DateTime(2020, 2, 1);

List<TodoModel> upcomingtask = [];
TodoModel? notifydata;

class Home_tasksection extends StatefulWidget {
  const Home_tasksection({super.key});

  @override
  State<Home_tasksection> createState() => _Home_tasksectionState();
}

class _Home_tasksectionState extends State<Home_tasksection> {
  @override
  Widget build(BuildContext context) {
    checkTimeNotification();
    return ValueListenableBuilder(
      valueListenable: todolistnotifier,
      builder: (BuildContext ctx, List<TodoModel> todolist, Widget? child) {
        return ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: todolist.where((TodoModel) {
            return DateTime.parse(TodoModel.date.toString()).day ==
                    DateTime.now().day &&
                DateTime.parse(TodoModel.date.toString()).month ==
                    DateTime.now().month &&
                DateTime.parse(TodoModel.date.toString()).year ==
                    DateTime.now().year &&
                TodoModel.isdone == false;
          }).length,
          itemBuilder: (context, index) {
            final data = todolist.where((TodoModel) {
              return DateTime.parse(TodoModel.date.toString()).day ==
                      DateTime.now().day &&
                  DateTime.parse(TodoModel.date.toString()).month ==
                      DateTime.now().month &&
                  DateTime.parse(TodoModel.date.toString()).year ==
                      DateTime.now().year &&
                  TodoModel.isdone == false;
            }).toList()[index];

            todolist.sort((a, b) => a.date.compareTo(b.date));
            upcomingtask = todolist
                .where((element) => element.date.isAfter(DateTime.now()))
                .toList();
            // notifytime = upcomingtask[0].date;
            // notifydata = upcomingtask[0];
            for (int i = 0; i < upcomingtask.length; i++) {
              notifytime = upcomingtask[i].date;
              notifydata = upcomingtask[i];
            }

            // print('objec{$notifytime}');
            return Padding(
              padding: const EdgeInsets.only(
                  top: 8.0, left: 12.0, right: 12.0, bottom: 0),
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
                          markDone(data, context);
                        }),
                        backgroundColor:
                            const Color.fromARGB(255, 285, 207, 144),
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
                          deleteAllTodotask(data.id);
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
                    padding: const EdgeInsets.all(5.0),
                    child: ListTile(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Screen_details(
                                  passvalue: data,
                                  passindex: index,
                                )));
                      },
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            data.title,
                            style: const TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      leading: data.priority ?? false
                          ? Container(
                              decoration: BoxDecoration(
                                  color: Colors.red[100],
                                  borderRadius: BorderRadius.circular(50)),
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
                                  borderRadius: BorderRadius.circular(50)),
                              child: Padding(
                                padding: EdgeInsets.all(3.0),
                                child: Icon(
                                  Icons.trip_origin,
                                  size: 25,
                                  color: Colors.yellow.shade500,
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
                                DateFormat("  hh:mm a").format(data.date),
                                //  data.date.toString(),
                                style: const TextStyle(
                                    fontSize: 15.0,
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
            );
          },
        );
      },
    );
  }
}

void markDone(TodoModel data, BuildContext context) {
  final updateData = TodoModel(
      id: data.id,
      description: data.description,
      date: data.date,
      priority: data.priority,
      isdone: true,
      complete: true,
      title: data.title);

  editTask(data.id, context, updateData);
}
