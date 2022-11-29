import 'package:flutter/material.dart';
import 'package:todo_app/models/data_model.dart';

import 'package:todo_app/widgets/event_details/event_dtls.dart';

class Screen_eventsdtls extends StatelessWidget {
  var passvalue;
  Screen_eventsdtls({super.key, required this.passvalue});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(232, 67, 123, 202),
                  Color.fromRGBO(100, 98, 222, 20),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Eventdtls(passvalue: passvalue),
          ),
        ],
      ),
    );
  }
}
