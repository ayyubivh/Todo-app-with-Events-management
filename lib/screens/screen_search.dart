import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/models/data_model.dart';
import 'package:todo_app/screens/screen_details.dart';
import 'package:todo_app/screens/screen_event_dtls.dart';

class Screen_search extends StatefulWidget {
  Screen_search({super.key});

  @override
  State<Screen_search> createState() => _Screen_searchState();
}

//List _datalists = [];

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

  DateTimeRange? _selectedDateTime;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: const Color(0xff483b7c),
            elevation: 0,
            centerTitle: true,
            title: Padding(
              padding: const EdgeInsets.only(left: 20, top: 5.0),
              child: textform(),
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
        body: Stack(children: [
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
            child: Wrap(
                children: [hightechChips(), lowtechChips(), datepickerChips()]),
          ),
        ]),
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
                  element.date == true &&
                  element.title.toLowerCase().contains(value.toLowerCase()))
              .toList();
          todoEventlistdisplay = todoEventlist
              .where((element) =>
                  element.priority == false &&
                  element.title.toLowerCase().contains(value.toLowerCase()))
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
      // //if (priorityHighFilter(value))
      // todomodellistdisplay = todomodelist
      //     .where((element) =>
      //         element.title.toLowerCase().contains(value.toLowerCase()))
      //     .toList();
    });
  }

  // void _searchtodoevent(String value) {
  //   setState(() {
  //     todoEventlistdisplay = todoEventlist
  //         .where((element) =>
  //             element.title.toLowerCase().contains(value.toLowerCase()))
  //         .toList();
  //   });
  // }

//************************************* */
  Widget textform() {
    return TextFormField(
      controller: _searchcontroller,
      style: TextStyle(
        color: Colors.white,
        fontSize: 16,
      ),
      autofocus: true,
      cursorColor: Colors.white,
      cursorHeight: 20,
      decoration: const InputDecoration(
        border: InputBorder.none,
        hintText: 'search',
        hintStyle: TextStyle(
            color: Color.fromARGB(240, 204, 197, 224), fontSize: 20.0),
        //   contentPadding: const EdgeInsets.all(5),
        prefixIcon: Icon(
          Icons.search,
          color: Color.fromARGB(240, 204, 197, 224),
        ),
        //    prefixIcon: Icon(Icons.search)
      ),
      onChanged: (value) {
        _searchtodotask(value, null);
        //     _searchtodoevent(value);
      },
    );
  }

//*****Task****** */

  Widget expandedTask() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: Card(
        //    color: Color.fromARGB(106, 83, 79, 165),
        child: todomodellistdisplay.isNotEmpty
            ? ListView(
                physics: BouncingScrollPhysics(),
                //   shrinkWrap: true,
                //    scrollDirection: Axis.vertical,
                children: [
                  ListView.builder(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      //  primary: false,
                      itemCount: todomodellistdisplay.length,
                      itemBuilder: (context, index) {
                        //   key: ValueKey(studentlistDisplay[index].name),
                        //   File img = File(studentlistDisplay[index].image);
                        return Padding(
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
                                    DateFormat("MMM, dd yyy ").format(
                                        todomodellistdisplay[index].date),
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
                                          passvalue:
                                              todomodellistdisplay[index],
                                          passindex: index,
                                        )),
                              ),
                            ),
                          ),
                        );
                      }),
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
      ),
    );
  } //*****event****** */

  Widget expandedEvent() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: Card(
        child: todoEventlistdisplay.isNotEmpty
            ? ListView(
                shrinkWrap: true,
                children: [
                  ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: todoEventlistdisplay.length,
                      itemBuilder: (context, index) {
                        return Padding(
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
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.w500),
                              ),
                              trailing:
                                  todoEventlistdisplay[index].priority ?? false
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
                                    DateFormat("MMM, dd yyy ").format(
                                        todoEventlistdisplay[index].date),
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
                                          passvalue:
                                              todoEventlistdisplay[index],
                                          passindex: index,
                                        )),
                              ),
                            ),
                          ),
                        );
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

  priorityLowFilter(value) {
    setState(() {
      if (value) {
        todomodellistdisplay =
            todomodelist.where((element) => element.priority == false).toList();
        todoEventlistdisplay = todoEventlist
            .where((element) => element.priority == false)
            .toList();
      }
    });
  }

//datepickerchip
  Widget datepickerChips() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 5),
      child: FilterChip(
        backgroundColor: Color.fromARGB(243, 129, 99, 239),
        labelStyle: TextStyle(color: Colors.white),
        elevation: 5,
        label: Text(' Date picker '),
        selected: (filter == '') ? true : false,
        onSelected: (bool value) {
          setState(() {
            if (value) {
              pickDate(context);
              filter = 'date';
              _searchtodotask(_searchcontroller.text, null);
            } else {
              filter = 'no';
              _searchtodotask(_searchcontroller.text, null);
            }
          });
        },
      ),
    );
  }

  void pickDate(BuildContext context) {
    DateTimeRange? _selectedDateTime;
    final initialDate = DateTime.now();
    final newDate = showDateRangePicker(
        context: context,
        firstDate: DateTime(2022, 1),
        lastDate: DateTime(2030, 1),
        currentDate: DateTime.now(),
        saveText: 'Done');
    if (newDate == null) {
      return;
    }
  }

  // priorityDateFilter(value) {
  //   setState(() {
  //     if (value) {
  //       todomodellistdisplay =
  //           todomodelist.where((element) => element.date).toList();
  //       todoEventlistdisplay = todoEventlist
  //           .where((element) => element.priority == false)
  //           .toList();
  //     }
  //   });
  // }
}
