import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/models/data_model.dart';
import 'package:todo_app/screens/screen_details.dart';
import 'package:todo_app/screens/screen_event_dtls.dart';
import 'package:todo_app/util/app_color.dart';

import '../functions/db_functions.dart';

class Screen_search extends StatefulWidget {
  Screen_search({super.key});

  @override
  State<Screen_search> createState() => _Screen_searchState();
}

class _Screen_searchState extends State<Screen_search> {
  List<TodoModel> todomodelist =
      Hive.box<TodoModel>('todo_task_db').values.toList();
  late List<TodoModel> todomodellistdisplay =
      List<TodoModel>.from(todomodelist);
  List<TodoEvent> todoEventlist =
      Hive.box<TodoEvent>('todo_Event_db').values.toList();
  late List<TodoEvent> todoEventlistdisplay =
      List<TodoEvent>.from(todoEventlist);
  final _searchcontroller = TextEditingController();
  bool selected = false;

  DateTimeRange? newDate;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: maincolor,
            elevation: 0,
            centerTitle: true,
            title: Column(
              children: [
                SizedBox(
                  height: 19.0,
                ),
                textform(),
                SizedBox(
                  height: 15,
                )
              ],
            ),
            bottom: const TabBar(
              tabs: [
                Tab(
                  child: Text('Task',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
                Tab(
                  child: Text('Event',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              ],
            )),
        body: Container(
          color: Colors.grey[200],
          child: Stack(children: [
            TabBarView(children: [
              Padding(
                padding: const EdgeInsets.only(top: 38),
                child: expandedTask(),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 38),
                child: expandedEvent(),
              )
            ]),
            Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: Wrap(children: [
                hightechChips(),
                lowtechChips(),
                datepickerChips()
              ]),
            ),
          ]),
        ),
      ),
    );
  }

  void _searchtodotask(String value, newDate) {
    setState(() {
      switch (filter) {
        case 'high':
          todomodellistdisplay = todomodelist
              .where((element) =>
                  element.priority == true &&
                  element.title.toLowerCase().contains(value.toLowerCase()))
              .toList();
          todoEventlistdisplay = todoEventlist
              .where((element) =>
                  element.priority == true &&
                  element.title.toLowerCase().contains(value.toLowerCase()))
              .toList();
          break;
        case 'low':
          todomodellistdisplay = todomodelist
              .where((element) =>
                  element.priority == false &&
                  element.title.toLowerCase().contains(value.toLowerCase()))
              .toList();
          todoEventlistdisplay = todoEventlist
              .where((element) =>
                  element.priority == false &&
                  element.title.toLowerCase().contains(value.toLowerCase()))
              .toList();
          break;
        case 'date':
          todomodellistdisplay = todomodelist
              .where((element) =>
                  element.date.isAfter(DateTime(newDate.start.year,
                      newDate.start.month, newDate.start.day)) &&
                  element.date.isBefore(DateTime(newDate.end.year,
                      newDate.end.month, newDate.end.day + 1)))
              .toList();

          todoEventlistdisplay = todoEventlist
              .where((element) =>
                  element.date.isAfter(DateTime(newDate.start.year,
                      newDate.start.month, newDate.start.day)) &&
                  element.date.isBefore(DateTime(newDate.end.year,
                      newDate.end.month, newDate.end.day + 1)))
              .toList();
          break;
        default:
          todomodellistdisplay = todomodelist
              .where((element) =>
                  element.title.toLowerCase().contains(value.toLowerCase()))
              .toList();
          todoEventlistdisplay = todoEventlist
              .where((element) =>
                  element.title.toLowerCase().contains(value.toLowerCase()))
              .toList();
      }
    });
  }

//************************************* */
  Widget textform() {
    return SizedBox(
      height: 49,
      width: double.infinity,
      child: TextFormField(
        controller: _searchcontroller,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
        autofocus: true,
        cursorColor: Colors.white,
        cursorHeight: 20,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide.none,
          ),
          filled: true, fillColor: Colors.grey,
          hintText: 'search',
          hintStyle: const TextStyle(color: Colors.white, fontSize: 18),
          contentPadding: const EdgeInsets.all(5),
          prefixIcon: const Icon(
            Icons.search,
            color: Colors.white,
          ),
          //    prefixIcon: Icon(Icons.search)
        ),
        onChanged: (value) {
          _searchtodotask(value, newDate);
          //     _searchtodoevent(value);
        },
      ),
    );
  }

//*****Task****** */

  Widget expandedTask() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: todomodellistdisplay.isNotEmpty
          ? ListView(
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
                                                          10)),
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
                                                      BorderRadius.circular(
                                                          10)),
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
  }

  //*****event****** */

  Widget expandedEvent() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 0,
        right: 0,
        top: 4,
      ),
      child: todoEventlistdisplay.isNotEmpty
          ? ListView(
              shrinkWrap: true,
              children: [
                ValueListenableBuilder(
                    valueListenable: todolisteventnotifier,
                    builder: (BuildContext ctx,
                        List<TodoEvent> todoEventlistdisplays, Widget? child) {
                      return ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: todoEventlistdisplay.length,
                          itemBuilder: (context, index) {
                            return Stack(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                Screen_eventsdtls(
                                                  passvalue:
                                                      todoEventlistdisplay,
                                                  passindex: index,
                                                )));
                                  },
                                  child: Container(
                                    margin: EdgeInsets.fromLTRB(
                                        10.0, 2.0, 5.0, 3.0),
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
                                              backgroundColor: Color.fromARGB(
                                                  255, 24, 207, 164),
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
                                                    todoEventlistdisplay[index]
                                                        .id);
                                                Fluttertoast.showToast(
                                                  msg: "deleted !!",
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    todoEventlistdisplay[index]
                                                        .title,
                                                    style: const TextStyle(
                                                        fontSize: 19.0,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  todoEventlistdisplay[index]
                                                              .priority ??
                                                          false
                                                      ? Container(
                                                          decoration: BoxDecoration(
                                                              color: Colors
                                                                  .red[100],
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10)),
                                                          child: const Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    3.0),
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
                                                              color: Colors
                                                                  .yellow[100],
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10)),
                                                          child: const Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    3.0),
                                                            child: Icon(
                                                              Icons
                                                                  .hourglass_bottom,
                                                              size: 30,
                                                              color:
                                                                  Colors.yellow,
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
                                                    DateFormat(
                                                            "MMM, dd yyy hh:mm a")
                                                        .format(
                                                            todoEventlistdisplay[
                                                                    index]
                                                                .date),
                                                    style: const TextStyle(
                                                        color: Colors.black54,
                                                        fontSize: 15.0,
                                                        fontWeight:
                                                            FontWeight.bold),
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
                                      image: FileImage(File(
                                          todoEventlistdisplay[index].image)),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )
                              ],
                            );
                          });
                    }),
              ],
            )
          : const Center(
              child: Text(
                ' No Events found',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w400),
              ),
            ),
    );
  }

  var filter = '';
//highchip
  Widget hightechChips() {
    return FilterChip(
      backgroundColor: Colors.red,
      labelStyle: const TextStyle(color: Colors.white),
      elevation: 5,
      label: const Text('high'),
      selected: (filter == 'high') ? true : false,
      onSelected: (bool value) {
        setState(() {
          if (value) {
            filter = 'high';
            // priorityHighFilter(value);
            _searchtodotask(_searchcontroller.text, null);
          } else {
            filter = 'no';
            _searchtodotask(_searchcontroller.text, null);
            //  _searchtodoevent(_searchcontroller.text);
          }
        });
      },
    );
  }

  priorityHighFilter(value) {
    setState(() {
      if (value) {
        todomodellistdisplay =
            todomodelist.where((element) => element.priority == true).toList();
        todoEventlistdisplay =
            todoEventlist.where((element) => element.priority == true).toList();
        //  _searchtodotask();
      } else {}
    });
  }

//Lowchip
  Widget lowtechChips() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 5),
      child: FilterChip(
        backgroundColor: Color.fromARGB(255, 215, 196, 19),
        labelStyle: TextStyle(color: Colors.white),
        elevation: 5,
        label: Text(' low '),
        selected: (filter == 'low') ? true : false,
        onSelected: (bool value) {
          setState(() {
            if (value) {
              filter = 'low';
              _searchtodotask(_searchcontroller.text, null);
            } else {
              filter = 'no';
              _searchtodotask(_searchcontroller.text, null);
              //     _searchtodoevent(_searchcontroller.text);
            }
          });
        },
      ),
    );
  }

//datepickerchip
  Widget datepickerChips() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 5),
      child: FilterChip(
        backgroundColor: const Color.fromARGB(243, 129, 99, 239),
        labelStyle: TextStyle(color: Colors.white),
        elevation: 5,
        label: Text(' Date picker '),
        selected: (filter == 'date') ? true : false,
        onSelected: (bool value) {
          setState(() {
            if (value) {
              filter = 'date';
              pickDate();

              // _searchtodotask(_searchcontroller.text, null);
            } else {
              filter = 'no';
              _searchtodotask(_searchcontroller.text, null);
            }
          });
        },
      ),
    );
  }

  DateTimeRange? date1 =
      DateTimeRange(start: DateTime.now(), end: DateTime.now());
  Future pickDate() async {
    newDate = await showDateRangePicker(
        context: context,
        initialDateRange: date1,
        firstDate: DateTime(2022),
        lastDate: DateTime(2030),
        saveText: 'Done');

    if (newDate == null) return;
    _searchtodotask(_searchcontroller.text, newDate);
  }
}
