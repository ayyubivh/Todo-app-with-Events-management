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

  @override
  Widget build(BuildContext context) {
    getAllTodotask();
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
              icon: Icon(
                Icons.search_outlined,
                size: 30,
              ),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (ctx1) => Screen_search()));
              },
            )
          ],
          backgroundColor: Color.fromARGB(255, 27, 30, 71),
        ),
        body: TabBarView(
          children: [
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                Color.fromARGB(243, 30, 29, 71),
                Color.fromARGB(254, 30, 29, 69),
              ], begin: Alignment.bottomCenter)),
              child: Column(
                children: [
                  const Task_section(),
                  const Expanded(
                    child: Home_tasksection(),
                  ),
                  Home_bottomsection()
                ],
              ),
            ),
            Container(
              color: Color.fromARGB(255, 30, 29, 69),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 80),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: texts(
                        mystring: ' Today events',
                        myfontsize: 23,
                        mycolor: Colors.white,
                        fontweight: FontWeight.bold),
                  ),
                  //  Task_section(),
                  Expanded(
                    child: Home_eventsection(),
                  ),
                  Home_bottomsection()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
