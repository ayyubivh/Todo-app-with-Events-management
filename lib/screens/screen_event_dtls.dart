import 'package:flutter/material.dart';
import 'package:todo_app/models/data_model.dart';

import 'package:todo_app/widgets/event_details/event_dtls.dart';

class Screen_eventsdtls extends StatelessWidget {
  Screen_eventsdtls({
    super.key,
    required this.passvalue,
    required this.passindex,
  });
  var passvalue;
  var passindex;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: [
          Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Eventdtls(passvalue: passvalue, passindex: passindex),
          ),
        ],
      ),
    );
  }
}
