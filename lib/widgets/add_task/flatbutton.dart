//************************flatbutton************************* */
import 'package:flutter/material.dart';

import '../../util/app_color.dart';
import '../common_widgets/common_text.dart';

class FlatButton extends StatelessWidget {
  final Color mycolor;
  final String mystring;
  final void Function() onpressaction;
  const FlatButton({
    Key? key,
    required this.mycolor,
    required this.mystring,
    required this.onpressaction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 325,
      height: 60.0,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Fcolor,
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12))),
          onPressed: onpressaction,
          child: texts(
            mystring: mystring,
            myfontsize: 22,
            fontweight: FontWeight.bold,
            mycolor: mycolor,
          )),
    );
  }
}
