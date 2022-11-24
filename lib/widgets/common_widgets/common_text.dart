import 'package:flutter/material.dart';

class texts extends StatelessWidget {
  final String mystring;
  final double myfontsize;
  final Color mycolor;
  final fontweight;
  const texts({
    super.key,
    required this.mystring,
    required this.myfontsize,
    required this.mycolor,
    required this.fontweight,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      mystring,
      style: TextStyle(
        fontSize: myfontsize,
        color: mycolor,
        fontWeight: fontweight,
      ),
    );
  }
}
