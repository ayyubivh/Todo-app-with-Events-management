import 'package:flutter/material.dart';

class eventTextform extends StatelessWidget {
  var initial;

  eventTextform(
      {Key? key,
      required this.mycontroller,
      required this.hintname,
      this.initial})
      : super(key: key);

  final TextEditingController mycontroller;
  final String hintname;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.0,
      width: 342,
      child: TextFormField(
        style: const TextStyle(color: Colors.black, fontSize: 20),
        textAlignVertical: TextAlignVertical.bottom,
        controller: mycontroller,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 2.0, color: Colors.blueGrey),
            borderRadius: BorderRadius.circular(16.0),
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none),
          filled: true,
          contentPadding: const EdgeInsets.all(15),
          fillColor: Colors.grey[200],
          hintText: hintname,
          hintStyle: const TextStyle(
              letterSpacing: 1,
              color: Colors.grey,
              fontSize: 15.0,
              fontWeight: FontWeight.w700),
        ),
        // textAlign: TextAlign.center,
      ),
    );
  }
}
