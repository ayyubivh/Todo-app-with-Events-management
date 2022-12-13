import 'package:flutter/material.dart';

import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/models/data_model.dart';
import 'package:todo_app/screens/screen_details.dart';

import '../../functions/db_functions.dart';

class EventPending extends StatelessWidget {
  const EventPending({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: todolisteventnotifier,
      builder:
          (BuildContext ctx, List<TodoEvent> todoevEventlist, Widget? child) {
        //  List<int> keys = todolist.keys.cast<int>.toList();
        List<int> keys;
//keys=todolist.keys.cast<int>().where((Key)=>todolist.get(Key).completed).to
        return ListView.builder(
          // shrinkWrap: true,
          // primary: false,
          scrollDirection: Axis.vertical,
          itemCount: todoevEventlist
              .where((element) => element.date.isBefore(DateTime.now()))
              .length,
          itemBuilder: (context, index) {
            //   List<TodoModel> sortedlist = [];
            //  sortedlist = todolist;
            // todolist
            //     .sort(((TodoModel a, TodoModel b) => a.date.compareTo(b.date)));
            final data = todoevEventlist
                .where((element) => element.date.isBefore(DateTime.now()))
                .toList()[index];
            //final data = todolist[index];
            return Padding(
              padding: const EdgeInsets.all(13.0),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(25),
                  ),
                ),
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
                          deleteAllTodoevent(data.id);
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
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      leading: data.priority ?? false
                          ? Container(
                              decoration: BoxDecoration(
                                  color: Colors.red[100],
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: const Icon(
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
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: const Icon(
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
        );
      },
    );
  }
}
