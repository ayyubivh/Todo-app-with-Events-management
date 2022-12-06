import 'package:flutter/material.dart';
import 'package:todo_app/functions/db_functions.dart';
import 'package:todo_app/screens/screen_search.dart';
import 'package:todo_app/widgets/common_widgets/common_text.dart';
import 'package:todo_app/widgets/home_widgets/task_bottom_section.dart';
import 'package:todo_app/widgets/home_widgets/home_eventlist.dart';
import 'package:todo_app/widgets/home_widgets/task_%20section.dart';
import 'package:todo_app/widgets/home_widgets/home_tasklist_section.dart';

import '../widgets/home_widgets/event_bottom_section.dart';

class Screen_home extends StatelessWidget {
  const Screen_home({super.key});
//***************************Tabbarvier add***************************************** */
  Widget tasksectiontab() {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        colors: [
          Color.fromARGB(146, 51, 48, 114),
          Color.fromARGB(133, 83, 79, 165),
        ],
        begin: Alignment.bottomRight,
        end: Alignment.topLeft,
      )),
      child: Column(
        children: [
          const Task_section(),
          const Expanded(
            child: Home_tasksection(),
          ),
          task_bottomsection()
        ],
      ),
    );
  }

//***************************Tabbarvier event***************************************** */
  Widget eventsectiontab() {
    return Container(
      //  color: Colors.white,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        colors: [
          Color.fromARGB(146, 51, 48, 114),
          Color.fromARGB(133, 83, 79, 165),
        ],
        begin: Alignment.bottomRight,
        end: Alignment.topLeft,
      )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 80),
          const Padding(
            padding: EdgeInsets.only(left: 15),
            child: texts(
                mystring: " Today's events",
                myfontsize: 20,
                mycolor: Color.fromARGB(255, 48, 6, 93),
                fontweight: FontWeight.w900),
          ),
          const Expanded(
            child: Home_eventsection(),
          ),
          event_bottomsection()
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
          backgroundColor: Color(0xff483b7c),
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
