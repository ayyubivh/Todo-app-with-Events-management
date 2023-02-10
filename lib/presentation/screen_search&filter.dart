// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo_app/models/data_model.dart';
import 'package:todo_app/provider/provider_search.dart';
import 'package:todo_app/util/app_color.dart';
import 'package:todo_app/widgets/search&filter/event_search.dart';
import 'package:todo_app/widgets/search&filter/task_view.dart';

List<TodoModel> todomodelist =
    Hive.box<TodoModel>('todo_task_db').values.toList();
late List<TodoModel> todomodellistdisplay = List<TodoModel>.from(todomodelist);

List<TodoEvent> todoEventlist =
    Hive.box<TodoEvent>('todo_Event_db').values.toList();
late List<TodoEvent> todoEventlistdisplay = List<TodoEvent>.from(todoEventlist);

class ScreenSearch extends StatelessWidget {
  ScreenSearch({super.key, required this.searchNotifier});

  final _searchcontroller = TextEditingController();

  bool selected = false;

  DateTimeRange? newDate;
  final ValueNotifier searchNotifier;
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
            title: textform(),
            bottom: const TabBar(tabs: [
              Tab(
                  child: Text('Task',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold))),
              Tab(
                  child: Text('Event',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)))
            ])),
        body: Container(
          color: Colors.grey[200],
          child: Stack(children: [
            TabBarView(children: [
              Padding(
                  padding: const EdgeInsets.only(top: 38),
                  child: TaskView(searchNotifier: searchNotifier)),
              Padding(
                padding: const EdgeInsets.only(top: 38),
                child: EventSearchView(searchNotifier: searchNotifier),
              )
            ]),
            Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: Wrap(children: [
                hightechChips(),
                lowtechChips(),
                datepickerChips(context)
              ]),
            ),
          ]),
        ),
      ),
    );
  }

  void _searchtodotask(String value, newDate) {
    if (filter == 'high') {
      // ignore: invalid_use_of_protected_member
      searchNotifier.notifyListeners();
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
    } else if (filter == 'low') {
      // ignore: invalid_use_of_protected_member
      searchNotifier.notifyListeners();

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
    } else if (filter == 'date') {
      // ignore: invalid_use_of_protected_member
      searchNotifier.notifyListeners();

      todomodellistdisplay = todomodelist
          .where((element) =>
              element.date.isAfter(DateTime(newDate.start.year,
                  newDate.start.month, newDate.start.day)) &&
              element.date.isBefore(DateTime(
                  newDate.end.year, newDate.end.month, newDate.end.day + 1)))
          .toList();

      todoEventlistdisplay = todoEventlist
          .where((element) =>
              element.date.isAfter(DateTime(newDate.start.year,
                  newDate.start.month, newDate.start.day)) &&
              element.date.isBefore(DateTime(
                  newDate.end.year, newDate.end.month, newDate.end.day + 1)))
          .toList();
    } else {
      // ignore: invalid_use_of_protected_member
      searchNotifier.notifyListeners();

      todomodellistdisplay = todomodelist
          .where((element) =>
              element.title.toLowerCase().contains(value.toLowerCase()))
          .toList();
      todoEventlistdisplay = todoEventlist
          .where((element) =>
              element.title.toLowerCase().contains(value.toLowerCase()))
          .toList();
    }
  }

//==============================Textform===============================\\
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
          // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
          searchNotifier.notifyListeners();
        },
      ),
    );
  }

  var filter = '';

//highchip
  Widget hightechChips() {
    return Consumer(builder: (context, ref, child) {
      ref.watch(filterProvider);
      return FilterChip(
        backgroundColor: Colors.red,
        labelStyle: const TextStyle(color: Colors.white),
        elevation: 5,
        label: const Text('high'),
        selected: (filter == 'high') ? true : false,
        onSelected: (bool value) {
          // setState(() {

          if (value) {
            ref.read(filterProvider.notifier).state = filter;
            filter = 'high';
            // priorityHighFilter(value);
            _searchtodotask(_searchcontroller.text, null);
          } else {
            ref.read(filterProvider.notifier).state = filter;

            filter = 'no';
            _searchtodotask(_searchcontroller.text, null);
            //  _searchtodoevent(_searchcontroller.text);
          }
          // });
        },
      );
    });
  }

  priorityHighFilter(value) {
//  /   setState(() {
    if (value) {
      todomodellistdisplay =
          todomodelist.where((element) => element.priority == true).toList();
      todoEventlistdisplay =
          todoEventlist.where((element) => element.priority == true).toList();
      //  _searchtodotask();
    } else {}
    // });
  }

//Lowchip
  Widget lowtechChips() {
    return Consumer(builder: (context, ref, child) {
      return Padding(
        padding: const EdgeInsets.only(left: 10, right: 5),
        child: FilterChip(
          backgroundColor: const Color.fromARGB(255, 215, 196, 19),
          labelStyle: const TextStyle(color: Colors.white),
          elevation: 5,
          label: const Text(' low '),
          selected: (filter == 'low') ? true : false,
          onSelected: (bool value) {
            ref.watch(filterProvider);
            // setState(() {
            if (value) {
              ref.read(filterProvider.notifier).state = filter;
              filter = 'low';
              _searchtodotask(_searchcontroller.text, null);
            } else {
              ref.read(filterProvider.notifier).state = filter;
              filter = 'no';
              _searchtodotask(_searchcontroller.text, null);
              //     _searchtodoevent(_searchcontroller.text);
            }
            //   });
          },
        ),
      );
    });
  }

//datepickerchip
  Widget datepickerChips(context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 5),
      child: FilterChip(
        backgroundColor: const Color.fromARGB(243, 129, 99, 239),
        labelStyle: const TextStyle(color: Colors.white),
        elevation: 5,
        label: const Text(' Date picker '),
        selected: (filter == 'date') ? true : false,
        onSelected: (bool value) {
          // setState(() {
          if (value) {
            filter = 'date';
            pickDate(context);

            // _searchtodotask(_searchcontroller.text, null);
          } else {
            filter = 'no';
            _searchtodotask(_searchcontroller.text, null);
          }
          // });
        },
      ),
    );
  }

  DateTimeRange? date1 =
      DateTimeRange(start: DateTime.now(), end: DateTime.now());

  Future pickDate(BuildContext context) async {
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
