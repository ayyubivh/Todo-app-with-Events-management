import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo_app/functions/db_functions.dart';
import 'package:todo_app/models/data_model.dart';
import 'package:todo_app/widgets/add_events/eventimage.dart';
import 'package:todo_app/widgets/add_task/flatbutton.dart';
import 'package:todo_app/widgets/common_widgets/common_text.dart';

import '../../util/app_color.dart';
import '../../util/event_textform.dart';
import 'date.dart';
import 'timefield.dart';

bool priority = false;
final _titleController = TextEditingController();
final _locationController = TextEditingController();
final _disciptionController = TextEditingController();

class add_eventform extends StatelessWidget {
  add_eventform({super.key});

  @override
  final ImagePicker _picker = ImagePicker();

  Future<TimeOfDay?> pickTime(context) => showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: dateTime.hour, minute: dateTime.minute));

//**************************priority button********************************************** */
  Widget prioritybutton(bool isSwitched) {
    return Consumer(builder: (context, ref, child) {
      return Column(
        children: [
          const texts(
              mystring: 'Prioirity ?',
              myfontsize: 16,
              mycolor: Colors.black,
              fontweight: FontWeight.w600),
          const SizedBox(
            width: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                  onPressed: () {
                    priority = true;
                  },
                  child: Container(
                    height: 30,
                    width: 75,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.red),
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Text(
                        'high',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontFamily: 'comic',
                            fontSize: 16,
                            color: Kwhite),
                      ),
                    ),
                  )),
              TextButton(
                  onPressed: () {
                    priority = false;
                  },
                  child: Container(
                    height: 30,
                    width: 75,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.yellow),
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Text(
                        'low',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontFamily: 'comic',
                            fontSize: 16,
                            color: Fcolor),
                      ),
                    ),
                  ))
            ],
          )
        ],
      );
    });
  }

//-----------------------------------------------------------------------------------------------
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
          height: 12,
        ),
        Column(
          children: [
            EventImage(flag: true),
            const SizedBox(
              height: 18,
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
              children: [DateField(), TimeField()],
            ),
            const SizedBox(
              height: 6,
            ),
            prioritybutton(priority),
            Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: const Color(0xff4a90fa),
                ),
                child: FlatButton(
                  mycolor: Kwhite,
                  mystring: 'Add Event',
                  onpressaction: () {
                    _onAddtodoeventClicked();
                    Navigator.pop(context);
                  },
                )),
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
      priority: priority,
      id: DateTime.now().toString(),
      isdone: false,
    );
    addevent(_todoevent);
  }
}
