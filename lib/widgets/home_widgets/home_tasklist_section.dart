import 'package:flutter/material.dart';

import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import 'package:todo_app/functions/db_functions.dart';
import 'package:todo_app/screens/screen_details.dart';

import '../../models/data_model.dart';

class Home_tasksection extends StatefulWidget {
  const Home_tasksection({super.key});

  @override
  State<Home_tasksection> createState() => _Home_tasksectionState();
}

class _Home_tasksectionState extends State<Home_tasksection> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: todolistnotifier,
      builder: (BuildContext ctx, List<TodoModel> todolist, Widget? child) {
        return ListView.builder(
          // shrinkWrap: true,
          // primary: false,
          scrollDirection: Axis.vertical,
          itemCount: todolist.length,
          itemBuilder: (context, index) {
            final data = todolist[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                color: Colors.transparent,
                shadowColor: Color.fromARGB(255, 1, 8, 11),
                elevation: 8,
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
                  height: 85.0,
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
                            deleteAllTodotask(index);
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
                                  color: Colors.white,
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        trailing: data.priority ?? false
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
                            Padding(
                              padding: const EdgeInsets.only(),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 15.0),
                                child: Text(
                                  DateFormat("MMM, dd yyy hh:mm a")
                                      .format(data.date),
                                  //  data.date.toString(),
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.0,
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
              ),
            );
          },
        );
      },
    );
  }
}
