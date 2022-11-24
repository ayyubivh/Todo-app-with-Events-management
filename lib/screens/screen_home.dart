import 'package:flutter/material.dart';
import 'package:todo_app/screens/screen_search.dart';
import 'package:todo_app/widgets/home_widgets/home_bottomsection.dart';
import 'package:todo_app/widgets/home_widgets/task_%20section.dart';
import 'package:todo_app/widgets/home_widgets/tasklist_section.dart';

class Screen_home extends StatelessWidget {
  const Screen_home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(
              Icons.search_outlined,
              size: 30,
            ),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (ctx1) => Screen_search()));
            },
          )
        ],
        backgroundColor: const Color.fromARGB(255, 8, 94, 164),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(232, 26, 71, 148),
              Color.fromARGB(232, 21, 79, 161),
              Color.fromARGB(222, 4, 12, 67),
              Color.fromARGB(218, 6, 61, 138),
              Color.fromARGB(218, 5, 65, 148)
            ],
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
          ),
        ),
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
    );
  }
}
