import 'package:flutter/material.dart';
import 'package:todo_app/util/app_color.dart';
import 'package:todo_app/widgets/common_widgets/common_text.dart';
import 'package:todo_app/widgets/dasboardScreen.dart/completedTask.dart';
import 'package:todo_app/widgets/dasboardScreen.dart/taskPendin.dart';

class DashboardLists extends StatefulWidget {
  const DashboardLists({super.key});

  @override
  State<DashboardLists> createState() => _DashboardListsState();
}

class _DashboardListsState extends State<DashboardLists>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 2, vsync: this);
    return Scaffold(
      body: Container(
        color: Colors.grey[200],
        child: Column(
          children: [
            Stack(
              children: [
                IconButton(
                  icon:const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
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
                    padding: EdgeInsets.only(top: 28.0),
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
                            children: const
                             [CompleteTask(), TasakPending()],
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
    );
  }
}
