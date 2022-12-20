import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
    return Text(mystring,
        style: GoogleFonts.ubuntu(
          fontSize: myfontsize,
          color: mycolor,
          fontWeight: fontweight,
        ));
  }
}
