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
          Color.fromARGB(254, 30, 29, 69),
          Color.fromARGB(234, 30, 29, 69),
        ],
        begin: Alignment.topRight,
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
          Color.fromARGB(254, 30, 29, 69),
          Color.fromARGB(234, 30, 29, 69),
        ],
        begin: Alignment.topRight,
        end: Alignment.bottomCenter,
      )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 80),
          const Padding(
            padding: EdgeInsets.only(left: 15),
            child: texts(
                mystring: ' Today events',
                myfontsize: 23,
                mycolor: Colors.white,
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
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx1) => const Screen_search()));
              },
            )
          ],
          backgroundColor: Color.fromARGB(255, 39, 42, 88),
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
