import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo_app/functions/db_functions.dart';
import 'package:todo_app/models/data_model.dart';
import 'package:todo_app/widgets/common_widgets/common_text.dart';

class add_eventform extends StatefulWidget {
  add_eventform({super.key});

  @override
  State<add_eventform> createState() => _add_eventformState();
}

class _add_eventformState extends State<add_eventform> {
  final _titleController = TextEditingController();

  final _disciptionController = TextEditingController();

  final ImagePicker _picker = ImagePicker();

  String? imagepath;

  DateTime date = DateTime(2022, 12, 24);
  TimeOfDay time = TimeOfDay(hour: 10, minute: 30);

  void _showDatePicker() async {
    DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: date,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (newDate == null) return;
    setState(() => date = newDate);
  }

  //******************widgets******************** */
  Widget textform(
    TextEditingController mycontroller,
    String hintname,
  ) {
    return SizedBox(
      height: 60.0,
      width: 342,
      child: TextFormField(
        style: TextStyle(color: Colors.black, fontSize: 20),
        textAlignVertical: TextAlignVertical.bottom,
        controller: mycontroller,
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(11),
              borderSide: BorderSide.none),
          filled: true,
          contentPadding: EdgeInsets.all(18),
          fillColor: Color.fromARGB(255, 105, 158, 184),
          hintText: hintname,
          hintStyle: const TextStyle(
              color: Color.fromARGB(255, 241, 243, 244),
              fontSize: 18.0,
              fontWeight: FontWeight.bold),
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

//***********************Date***************************/
  Widget dates() {
    return Container(
      width: 143,
      height: 79,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(11),
          color: Color.fromARGB(232, 20, 139, 199)),
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: 5,
            ),
            Icon(
              Icons.calendar_month_outlined,
              size: 26.0,
              color: Colors.white70,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent, elevation: 0),
                onPressed: () {
                  _showDatePicker();
                },
                child: Text(
                  '${date.year}/${date.month}/${date.day}',
                  semanticsLabel: date.toString(),
                  style: TextStyle(fontSize: 20, color: Colors.white),
                )),
          ],
        ),
      ),
    );
  }

//*********************Time*********************** */
  Widget times() {
    return Container(
      width: 143,
      height: 79,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(11),
          color: Color.fromARGB(232, 20, 139, 199)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            height: 5,
          ),
          Icon(
            Icons.watch_later_outlined,
            size: 26,
            color: Colors.white,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent, elevation: 0),
            onPressed: () async {
              TimeOfDay? newtime = await showTimePicker(
                context: context,
                initialTime: time,
              );
              if (newtime == null) return;
              setState(() {
                time = newtime;
              });
            },
            child: Text(
              '${time.hour}:${time.minute}',
              style: TextStyle(fontSize: 22),
            ),
          ),
        ],
      ),
    );
  }

//************************flatbutton************************* */
  Widget flatbtn(
      {required Color mycolor,
      required String mystring,
      required void Function() onpressaction}) {
    return Container(
      width: 330,
      height: 60.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              elevation: 0, backgroundColor: Colors.transparent),
          onPressed: onpressaction,
          child: texts(
            mystring: mystring,
            myfontsize: 22,
            fontweight: FontWeight.w500,
            mycolor: mycolor,
          )),
    );
  }

//position
  Widget position() {
    return Positioned(
      bottom: 20.0,
      right: 20.0,
      child: InkWell(
        onTap: () {
          takePhoto();
        },
        child: const Icon(
          Icons.camera_alt,
          color: Colors.black,
        ),
      ),
    );
  }

//circle Avatar
  Widget circleavtar() {
    return CircleAvatar(
      backgroundImage: imagepath == null ? null : FileImage(File(imagepath!)),
      radius: 80.0,
    );
  }

//********************************************************* */
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        const texts(
            mystring: 'Add Event',
            myfontsize: 36,
            mycolor: Colors.blue,
            fontweight: FontWeight.w500),
        const SizedBox(
          height: 20,
        ),
        Column(
          children: [
            circleavtar(),
            position(),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: textform(_titleController, 'Title'),
            ),
            Padding(
              padding: const EdgeInsets.all(11),
              child: textform(_disciptionController, 'Discription'),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [dates(), times()],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Color.fromARGB(233, 35, 160, 195),
              ),
              child: flatbtn(
                  onpressaction: () {
                    _onAddtodoeventClicked();
                    Navigator.pop(context);
                  },
                  mycolor: Colors.white,
                  mystring: 'Add todo'),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                    color: Color.fromARGB(233, 35, 160, 195), width: 2),
                borderRadius: BorderRadius.circular(11),
              ),
              child: flatbtn(
                  onpressaction: () {
                    Navigator.pop(context);
                  },
                  mycolor: Color.fromARGB(233, 35, 160, 195),
                  mystring: 'Cancel'),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _onAddtodoeventClicked() async {
    final _title = _titleController.text.trim();
    final _discription = _disciptionController.text.trim();
    final _date = date;
    if (_title.isEmpty || _discription.isEmpty) {
      return;
    }
    final _todoevent = TodoEvent(
        title: _title,
        description: _discription,
        date: _date,
        image: imagepath!);
    addevent(_todoevent);
  }

  Future<void> takePhoto() async {
    // try {
    final PickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (PickedFile != null) {
      setState(() {
        imagepath = PickedFile.path;
      });
    }
  }
}
