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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
        ),
        body: SafeArea(
            child: Container(
          color: Colors.grey[200],
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: details_screen(passvalue: passvalue, passindex: passindex),
        )),
      ),
    );
  }
}
