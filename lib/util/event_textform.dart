import 'package:flutter/material.dart';

class eventTextform extends StatelessWidget {
  const eventTextform({
    Key? key,
    required this.mycontroller,
    required this.hintname,
  }) : super(key: key);

  final TextEditingController mycontroller;
  final String hintname;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.0,
      width: 342,
      child: TextFormField(
        style: TextStyle(color: Colors.black, fontSize: 20),
        textAlignVertical: TextAlignVertical.bottom,
        controller: mycontroller,
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none),
          filled: true,
          contentPadding: EdgeInsets.all(15),
          fillColor: Colors.grey[200],
          hintText: hintname,
          hintStyle: const TextStyle(
              color: Colors.black54,
              fontSize: 17.0,
              fontWeight: FontWeight.w700),
        ),
        // textAlign: TextAlign.center,
      ),
    );
  }
}
