import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/functions/db_functions.dart';
import 'package:todo_app/screens/screen_search.dart';
import 'package:todo_app/util/app_color.dart';
import 'package:todo_app/widgets/common_widgets/common_text.dart';
import 'package:todo_app/widgets/home_widgets/task_bottom_section.dart';
import 'package:todo_app/widgets/home_widgets/home_eventlist.dart';
import 'package:todo_app/widgets/home_widgets/task_%20section.dart';
import 'package:todo_app/widgets/home_widgets/home_tasklist_section.dart';

import '../widgets/home_widgets/event_bottom_section.dart';

class Screen_home extends StatelessWidget {
  const Screen_home({super.key});
//***************************Tabbarview add***************************************** */
  Widget tasksectiontab() {
    return Container(
      color: Colors.grey[200],
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          const Task_section(),
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

//***************************Tabbarview event***************************************** */
  Widget eventsectiontab() {
    return Container(
      color: Colors.grey[200],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 30),
          Padding(
            padding: EdgeInsets.only(left: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const texts(
                    mystring: " Your events",
                    myfontsize: 20,
                    mycolor: Color.fromARGB(174, 0, 0, 0),
                    fontweight: FontWeight.bold),
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Row(
                    children: [
                      Text(
                        DateFormat("MMM, dd yyy").format(DateTime.now()),
                        style: const TextStyle(
                            color: Color.fromARGB(159, 0, 0, 0),
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Icon(Icons.date_range_outlined),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
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

//*************************************************************************************** */
  @override
  Widget build(BuildContext context) {
    getAllTodotask();
    getAllTodoEvent();
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            indicatorColor: Colors.white30,
            tabs: [
              Tab(
                child: Text('Task',
                    style:
                        TextStyle(fontSize: 21, fontWeight: FontWeight.bold)),
              ),
              Tab(
                child: Text('Event',
                    style:
                        TextStyle(fontSize: 21, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.search_outlined,
                size: 30,
              ),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => Screen_search()));
              },
            )
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
