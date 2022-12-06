import 'package:flutter/material.dart';
import 'package:todo_app/widgets/common_widgets/common_text.dart';
import 'package:todo_app/widgets/home_widgets/home_tasklist_section.dart';

class Screen_dashboard extends StatelessWidget {
  const Screen_dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Card(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(146, 51, 48, 114),
                    Color.fromARGB(133, 83, 79, 165),
                  ],
                  begin: Alignment.bottomRight,
                  end: Alignment.topLeft,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 50.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Padding(
                          padding: EdgeInsets.all(14.0),
                          child: texts(
                              mystring: 'Dashboard',
                              myfontsize: 25,
                              mycolor: Colors.white,
                              fontweight: FontWeight.bold),
                        ),
                        Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Icon(
                            Icons.filter_alt_outlined,
                            size: 25.0,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Expanded(child: Home_tasksection()),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
