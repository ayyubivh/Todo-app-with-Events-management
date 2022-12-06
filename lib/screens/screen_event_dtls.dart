import 'package:flutter/material.dart';
import 'package:todo_app/models/data_model.dart';

import 'package:todo_app/widgets/event_details/event_dtls.dart';

class Screen_eventsdtls extends StatelessWidget {
  var passvalue;
  var passindex;
  Screen_eventsdtls({
    super.key,
    required this.passvalue,
    required this.passindex,
  });

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
                  Color.fromARGB(121, 51, 48, 114),
                  Color.fromARGB(85, 83, 79, 165),
                ],
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
              ),
            ),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Eventdtls(
              passvalue: passvalue,
              passindex: passindex,
            ),
          ),
        ],
      ),
    );
  }
}
