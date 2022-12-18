import 'package:flutter/material.dart';
import 'package:todo_app/widgets/dasboardScreen.dart/CompleteEvent.dart';
import 'package:todo_app/widgets/dasboardScreen.dart/eventPending.dart';

import '../../util/app_color.dart';
import '../common_widgets/common_text.dart';

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
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Colors.grey[200],
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 100,
                    decoration: BoxDecoration(
                        color: maincolor,
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(40.0),
                          bottomRight: Radius.circular(40.0),
                        )),
                  ),
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.all(28.0),
                      child: texts(
                          mystring: 'Dasboard',
                          myfontsize: 22,
                          mycolor: Colors.white,
                          fontweight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    color: Colors.grey[200],
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              // width: 300,
                              decoration: BoxDecoration(
                                  color: maincolor,
                                  borderRadius: BorderRadius.circular(50)),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: TabBar(
                                  indicatorColor: Colors.white,
                                  indicatorWeight: 2,
                                  // isScrollable: true,
                                  controller: tabController,
                                  indicator: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: Colors.white70,
                                  ),
                                  labelColor: Colors.black,
                                  unselectedLabelColor: Colors.white,
                                  tabs: const [
                                    Tab(
                                      child: Text(
                                        '   Completed   ',
                                        style: TextStyle(
                                            // color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Tab(
                                      child: Text(
                                        '  Pending      ',
                                        style: TextStyle(
                                            // color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            color: Colors.grey.shade200,
                            child: TabBarView(
                              controller: tabController,
                              children: [CompletedEvents(), EventPending()],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
