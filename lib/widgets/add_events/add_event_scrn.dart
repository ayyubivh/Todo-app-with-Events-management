import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo_app/functions/db_functions.dart';
import 'package:todo_app/models/data_model.dart';
import 'package:todo_app/widgets/common_widgets/common_text.dart';

import '../../util/app_color.dart';
import '../../util/event_textform.dart';

class add_eventform extends StatefulWidget {
  add_eventform({super.key});

  @override
  State<add_eventform> createState() => _add_eventformState();
}

class _add_eventformState extends State<add_eventform> {
  final _titleController = TextEditingController();

  final _locationController = TextEditingController();

  final _disciptionController = TextEditingController();

  final ImagePicker _picker = ImagePicker();

  String? imagepath;

  DateTime dateTime = DateTime.now();

//***********************Date***************************/
  Widget dates() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey[200],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              padding: const EdgeInsets.all(17)),
          onPressed: () async {
            final date = await pickDate();
            if (date == null) return;

            final newDateTime = DateTime(date.year, date.month, date.day,
                dateTime.hour, dateTime.minute);
            setState(() {
              dateTime = newDateTime;
            });
          },
          child: Text(
            '  ${dateTime.year}/${dateTime.month}/${dateTime.day} ',
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
          )),
    );
  }

  Future<DateTime?> pickDate() => showDatePicker(
      context: context,
      initialDate: dateTime,
      firstDate: DateTime(1900),
      lastDate: DateTime(2500));
//*********************Time*********************** */
  Widget times() {
    final hours = dateTime.hour.toString().padLeft(2, '0');
    final minutes = dateTime.minute.toString().padLeft(2, '0');

    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey[200],
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            padding: const EdgeInsets.all(17)),
        onPressed: () async {
          final time = await pickTime();
          if (time == null) return;

          final newDateTime = DateTime(dateTime.year, dateTime.month,
              dateTime.day, time.hour, time.minute);
          setState(() {
            dateTime = newDateTime;
          });
        },
        child: Text(
          '       $hours:$minutes        ',
          style: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
    );
  }

  Future<TimeOfDay?> pickTime() => showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: dateTime.hour, minute: dateTime.minute));

//************************flatbutton************************* */

//position
  Widget position() {
    return Positioned(
      bottom: 1,
      right: 140,
      child: InkWell(
        onTap: () {
          takePhoto();
        },
        child: const Icon(
          Icons.camera_alt_outlined,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }

//**************************priority button********************************************** */
  Widget prioritybutton(bool isSwitched, Function onChangeMethod) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const texts(
            mystring: 'Prioirity ?',
            myfontsize: 16,
            mycolor: Colors.black,
            fontweight: FontWeight.w600),
        SizedBox(
          width: 5,
        ),
        Switch(
          value: isSwitched,
          onChanged: (newvalue) {
            onChangeMethod(newvalue);
          },
          inactiveThumbColor: Colors.amber,
          activeTrackColor: Colors.red,
          activeColor: Colors.red,
        ),
      ],
    );
  }

//*********************add photo************* */

  Widget imagebox() {
    return Stack(
      children: [
        Container(
          height: 130,
          width: 330,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              //   radius: BorderRadius.circular(20),
              image: DecorationImage(
                fit: BoxFit.fitWidth,
                image: imagepath == null
                    ? AssetImage('Asset/images/event.jpg') as ImageProvider
                    : FileImage(
                        File(imagepath!),
                      ),
              )),
        ),
        position()
      ],
    );
  }

//********************************************************* */
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        const texts(
            mystring: 'Add Event',
            myfontsize: 32,
            mycolor: Colors.black,
            fontweight: FontWeight.bold),
        const SizedBox(
          height: 13,
        ),
        Column(
          children: [
            imagebox(),
            // circleavtar(),
            const SizedBox(
              height: 20,
            ),
            eventTextform(mycontroller: _titleController, hintname: 'Title'),
            const SizedBox(
              height: 10,
            ),
            eventTextform(
                mycontroller: _disciptionController, hintname: 'Discription'),
            const SizedBox(
              height: 10,
            ),
            eventTextform(
                mycontroller: _locationController, hintname: 'Location'),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [dates(), times()],
            ),
            const SizedBox(
              height: 6,
            ),
            prioritybutton(myPriority, onchangeFunction),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: const Color(0xff4a90fa),
              ),
              child: flatbtn(
                  onpressaction: () {
                    _onAddtodoeventClicked();
                    Navigator.pop(context);
                  },
                  mycolor: Colors.white,
                  mystring: 'Add Event'),
            ),
            const SizedBox(
              height: 13,
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _onAddtodoeventClicked() async {
    final _title = _titleController.text.trim();
    final _discription = _disciptionController.text.trim();
    final _date = dateTime;
    final _location = _locationController.text.trim();
    if (_title.isEmpty || _discription.isEmpty || _location.isEmpty) {
      return;
    }
    final _todoevent = TodoEvent(
      title: _title,
      description: _discription,
      date: _date,
      image: imagepath!,
      location: _location,
      priority: myPriority,
      id: DateTime.now().toString(),
      isdone: false,
    );
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

  bool myPriority = false;
  onchangeFunction(bool newvalue) {
    setState(() {
      myPriority = newvalue;
    });
  }
}

Widget flatbtn(
    {required Color mycolor,
    required String mystring,
    required void Function() onpressaction}) {
  return SizedBox(
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
