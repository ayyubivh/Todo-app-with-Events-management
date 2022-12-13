import 'package:flutter/material.dart';
import 'package:todo_app/widgets/dasboardScreen.dart/eventPending.dart';
import 'package:todo_app/widgets/dasboardScreen.dart/taskPendin.dart';
import 'package:todo_app/widgets/home_widgets/home_eventlist.dart';
import 'package:todo_app/widgets/home_widgets/home_tasklist_section.dart';

class EventDashboardLists extends StatefulWidget {
  const EventDashboardLists({super.key});

  @override
  State<EventDashboardLists> createState() => _EventDashboardListsState();
}

class _EventDashboardListsState extends State<EventDashboardLists>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 2, vsync: this);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Dashboard',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 29),
            child: Icon(
              Icons.filter_alt_outlined,
              size: 25.0,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
          ),
          Center(
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Container(
                //  width: 300,
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(12)),
                child: TabBar(
                  isScrollable: true,
                  controller: tabController,
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.amber),
                  tabs: const [
                    Tab(
                      child: Text(
                        '   Completed   ',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Tab(
                      child: Text(
                        '  Pending      ',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [Home_tasksection(), EventPending()],
            ),
          )
        ],
      ),
    );
  }
}
