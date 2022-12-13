import 'package:flutter/material.dart';

class tasktextform extends StatelessWidget {
  const tasktextform({
    Key? key,
    required this.mycontroller,
    required this.hintname,
  }) : super(key: key);

  final TextEditingController? mycontroller;
  final String hintname;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 57,
      width: 346.0,
      child: Column(
        children: [
          TextFormField(
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
        ],
      ),
    );
  }
}
