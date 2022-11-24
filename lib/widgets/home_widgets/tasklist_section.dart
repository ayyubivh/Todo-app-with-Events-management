import 'package:flutter/material.dart';
import 'package:todo_app/widgets/common_widgets/common_text.dart';

class Home_tasksection extends StatelessWidget {
  const Home_tasksection({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      // shrinkWrap: true,
      // physics: NeverScrollableScrollPhysics(),
      itemCount: 5,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 324,
            height: 80,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(232, 39, 81, 140),
                    Color.fromARGB(222, 9, 20, 85),
                    Color.fromARGB(218, 3, 17, 36),
                  ],
                  begin: Alignment.bottomRight,
                  end: Alignment.topLeft,
                ),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: ListTile(
              title: texts(
                  mystring: 'Running',
                  myfontsize: 20,
                  mycolor: Colors.white,
                  fontweight: FontWeight.normal),
              subtitle: texts(
                  mystring: 'You want to complete your task',
                  myfontsize: 15.0,
                  mycolor: Colors.white70,
                  fontweight: FontWeight.normal),
            ),
          ),
        );
      },
    );
  }
}
