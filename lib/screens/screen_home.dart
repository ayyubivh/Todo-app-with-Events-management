import 'package:flutter/material.dart';
import 'package:todo_app/functions/db_functions.dart';
import 'package:todo_app/screens/screen_search.dart';
import 'package:todo_app/widgets/common_widgets/common_text.dart';
import 'package:todo_app/widgets/home_widgets/home_bottomsection.dart';
import 'package:todo_app/widgets/home_widgets/home_eventsection.dart';
import 'package:todo_app/widgets/home_widgets/task_%20section.dart';
import 'package:todo_app/widgets/home_widgets/tasklist_section.dart';

class Screen_home extends StatelessWidget {
  const Screen_home({super.key});
//***************************Tabbarvier add***************************************** */
  Widget tasksection() {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        colors: [
          Color.fromARGB(146, 51, 48, 114),
          Color.fromARGB(133, 79, 73, 195),
          Color.fromARGB(146, 51, 48, 114),
          Color.fromARGB(165, 83, 79, 165),
        ],
        stops: [0.1, 0.4, 0.7, 0.9],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      )),
      child: Column(
        children: [
          const Task_section(),
          const Expanded(
            child: Home_tasksection(),
          ),
          Home_bottomsection()
        ],
      ),
    );
  }

//***************************Tabbarvier event***************************************** */
  Widget eventsection() {
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 80),
          const Padding(
            padding: EdgeInsets.only(left: 15),
            child: texts(
                mystring: " Today's events",
                myfontsize: 23,
                mycolor: Color.fromARGB(255, 65, 7, 112),
                fontweight: FontWeight.bold),
          ),
          const Expanded(
            child: Home_eventsection(),
          ),
          Home_bottomsection()
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
                child: Text(
                  'Task',
                  style: TextStyle(fontSize: 21),
                ),
              ),
              Tab(
                child: Text(
                  'Event',
                  style: TextStyle(fontSize: 21),
                ),
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
          backgroundColor: Color.fromARGB(255, 87, 53, 143),
        ),
        body: TabBarView(
          children: [
            tasksection(),
            eventsection(),
          ],
        ),
      ),
    );
  }
}
