import 'package:flutter/material.dart';
import 'package:todo_app/widgets/add_details/details_screen.dart';

class Screen_details extends StatelessWidget {
  Screen_details({
    super.key,
    required this.passvalue,
  });
  var passvalue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ListView(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 29, 28, 68),
                  Color.fromARGB(255, 29, 28, 68),
                ],
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
              ),
            ),
            child: details_screen(passvalue: passvalue),
          ),
        ],
      )),
    );
  }
}
