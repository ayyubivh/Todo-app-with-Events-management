import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import '../../functions/db_functions.dart';
import '../../models/data_model.dart';
import '../../presentation/screen_details.dart';
import '../../presentation/screen_search&filter.dart';

class TaskView extends StatelessWidget {
  const TaskView({super.key, required this.searchNotifier});
  final ValueNotifier searchNotifier;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: todomodellistdisplay.isNotEmpty
          ? ValueListenableBuilder(
              valueListenable: searchNotifier,
              builder: (context, value, child) => ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  ValueListenableBuilder(
                    valueListenable: todolistnotifier,
                    builder: (BuildContext ctx, List<TodoModel> todomodel,
                            Widget? child) =>
                        ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: todomodellistdisplay.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(3.0),
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
                                            //     markDone(data, context);
                                          }),
                                          backgroundColor: const Color.fromARGB(
                                              255, 24, 207, 164),
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
                                            deleteAllTodotask(
                                                todomodellistdisplay[index].id);
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
                                                            todomodellistdisplay[
                                                                index],
                                                        passindex: index,
                                                      )));
                                        },
                                        title: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              todomodellistdisplay[index].title,
                                              style: const TextStyle(
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        leading: todomodellistdisplay[index]
                                                    .priority ??
                                                false
                                            ? Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.red[100],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50)),
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
                                                        BorderRadius.circular(
                                                            50)),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(3.0),
                                                  child: Icon(
                                                    Icons.trip_origin,
                                                    size: 25,
                                                    color:
                                                        Colors.yellow.shade500,
                                                  ),
                                                ),
                                              ),
                                        subtitle: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 15.0),
                                                child: Text(
                                                  DateFormat(
                                                          "MMM, dd yyy hh:mm a")
                                                      .format(
                                                          todomodellistdisplay[
                                                                  index]
                                                              .date),
                                                  //  data.date.toString(),
                                                  style: const TextStyle(
                                                      fontSize: 14.0,
                                                      fontWeight:
                                                          FontWeight.w800),
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
                            }),
                  ),
                ],
              ),
            )
          : const Center(
              child: Text(
                ' No Tasks  found',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black54,
                    fontWeight: FontWeight.w400),
              ),
            ),
    );
    ;
  }
}
