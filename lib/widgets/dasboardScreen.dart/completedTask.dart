import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/models/data_model.dart';
import 'package:todo_app/widgets/common_widgets/common_text.dart';

import '../../functions/db_functions.dart';
import '../../presentation/screen_details.dart';

class CompleteTask extends StatelessWidget {
  const CompleteTask({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: todolistnotifier,
      builder: (BuildContext ctx, List<TodoModel> todolist, Widget? child) {
        return todolist.where((element) => element.isdone == true).isNotEmpty
            ? (ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount:
                    todolist.where((element) => element.isdone == true).length,
                itemBuilder: (context, index) {
                  final data = todolist
                      .where((element) => element.isdone == true)
                      .toList()[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 6, horizontal: 12.0),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(25),
                        ),
                      ),
                      child: Slidable(
                        endActionPane: ActionPane(
                          motion: const StretchMotion(),
                          children: [
                            SlidableAction(
                              onPressed: ((context) {
                                deleteAllTodotask(data.id);
                                Fluttertoast.showToast(
                                  msg: 'Remove !!',
                                  toastLength: Toast.LENGTH_SHORT,
                                  backgroundColor: Colors.red,
                                  fontSize: 17,
                                  gravity: ToastGravity.BOTTOM,
                                );
                              }),
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                              icon: Icons.delete,
                              label: 'Remove',
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
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            leading: data.priority ?? false
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
                                      padding: const EdgeInsets.all(3.0),
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
                                      DateFormat("MMM, dd yyy hh:mm a")
                                          .format(data.date),
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
                  );
                },
              ))
            : const Center(
                child: texts(
                    mystring: 'No Tasks Found',
                    myfontsize: 20,
                    mycolor: Colors.black45,
                    fontweight: FontWeight.w500),
              );
      },
    );
  }
}
