import 'package:flutter/material.dart';
import 'package:todo_app/widgets/add_details/details_screen.dart';

class Screen_details extends StatelessWidget {
  Screen_details({
    super.key,
    required this.passvalue,
    required this.passindex,
    //   required int passindex,
  });
  var passvalue;
  var passindex;
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
                  Color.fromARGB(146, 51, 48, 114),
                  Color.fromARGB(165, 83, 79, 165),
                ],
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
              ),
            ),
            child: details_screen(passvalue: passvalue, passindex: passindex),
          ),
        ],
      )),
    );
  }
}
