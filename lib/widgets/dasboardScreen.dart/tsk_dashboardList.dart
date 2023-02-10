import 'package:flutter/material.dart';
import 'package:todo_app/util/app_color.dart';
import 'package:todo_app/widgets/dasboardScreen.dart/completedTask.dart';
import 'package:todo_app/widgets/dasboardScreen.dart/taskPendin.dart';

class DashboardLists extends StatelessWidget {
  const DashboardLists({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: const Text(
            'Dashboard',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
          ),
          centerTitle: true,
          backgroundColor: Fcolor,
          bottom: const TabBar(tabs: [
            Tab(
              child: Text('Completed',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
            ),
            Tab(
              child: Text('Pending',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
            ),
          ]),
        ),
        body: const TabBarView(children: [CompleteTask(), TasakPending()]),
      ),
    );
  }
}
