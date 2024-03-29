import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/functions/db_functions.dart';
import 'package:todo_app/presentation/screen_search&filter.dart';
import 'package:todo_app/util/app_color.dart';
import 'package:todo_app/widgets/common_widgets/common_text.dart';
import 'package:todo_app/widgets/home_widgets/screenTerms.dart';
import 'package:todo_app/widgets/home_widgets/task_bottom_section.dart';
import 'package:todo_app/widgets/home_widgets/home_eventlist.dart';
import 'package:todo_app/widgets/home_widgets/task_%20section.dart';
import 'package:todo_app/widgets/home_widgets/home_tasklist_section.dart';

import '../widgets/home_widgets/event_bottom_section.dart';

class Screen_home extends StatelessWidget {
  const Screen_home({super.key});

//============Tabbarview add============
  Widget tasksectiontab() {
    return Container(
      color: Colors.grey[200],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Task_section(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 20.5),
                child: texts(
                    mystring: "Today's tasks",
                    myfontsize: 18.0,
                    mycolor: Colors.black,
                    fontweight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 18.0, bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0, left: 120),
                      child: Text(
                        DateFormat("MMM, dd yyy").format(DateTime.now()),
                        style: const TextStyle(
                            color: Colors.black87,
                            fontSize: 15.0,
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 14,
              )
            ],
          ),
          const Expanded(
            child: Home_tasksection(),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 3.0),
            child: task_bottomsection(),
          )
        ],
      ),
    );
  }

//================icon button=======================
  Widget iconbtnsearch(context) {
    // ignore: no_leading_underscores_for_local_identifiers
    ValueNotifier<String> _searchNotifier = ValueNotifier('');
    return IconButton(
      icon: const Icon(
        Icons.search_outlined,
        size: 30,
      ),
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ScreenSearch(
                  searchNotifier: _searchNotifier,
                )));
      },
    );
  }

//============Tabbarview event============

  Widget eventsectiontab() {
    return Container(
      color: Colors.grey[200],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const texts(
                    mystring: " Today events",
                    myfontsize: 19.5,
                    mycolor: Colors.black,
                    fontweight: FontWeight.bold),
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        DateFormat("MMM, dd yyy").format(DateTime.now()),
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 15.5,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 9),
          const Expanded(
            child: Home_eventsection(),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 3.0),
            child: event_bottomsection(),
          )
        ],
      ),
    );
  }

//===Tabevent============
  Widget tabevent() {
    return const Tab(
      child: Text('Event',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    );
  }

//===Tabtask=======

  Widget tabtask() {
    return const Tab(
      child: Text('Task',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    );
  }

  //=======================================/
  @override
  Widget build(BuildContext context) {
    getAllTodotask();
    getAllTodoEvent();
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        // key: ,
        drawer: const ScreenTerms(),
        appBar: AppBar(
          centerTitle: true,
          title: const texts(
              mystring: "Lets do",
              myfontsize: 22,
              mycolor: Colors.white,
              fontweight: FontWeight.bold),
          bottom: TabBar(
            indicatorColor: Colors.white60,
            tabs: [tabtask(), tabevent()],
          ),
          actions: [
            iconbtnsearch(context),
          ],
          backgroundColor: maincolor,
        ),
        body: TabBarView(
          children: [
            tasksectiontab(),
            eventsectiontab(),
          ],
        ),
      ),
    );
  }
}
