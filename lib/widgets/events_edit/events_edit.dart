import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/functions/db_functions.dart';
import 'package:todo_app/models/data_model.dart';
import 'package:todo_app/util/app_color.dart';
import 'package:todo_app/util/event_textform.dart';
import 'package:todo_app/util/sizedbox.dart';
import 'package:todo_app/widgets/add_events/date.dart';
import 'package:todo_app/widgets/add_events/eventimage.dart';
import 'package:todo_app/widgets/add_events/timefield.dart';
import 'package:todo_app/widgets/add_task/flatbutton.dart';
import 'package:todo_app/widgets/common_widgets/common_text.dart';
import '../../presentation/screen_home.dart';
import '../add_events/add_event_scrn.dart';

class edit_eventform extends StatelessWidget {
  edit_eventform({super.key, required this.passvalue, required this.passindex});
  final TodoEvent passvalue;
  var passindex;

  final _titleController = TextEditingController();
  final _discriptionController = TextEditingController();
  final _locationcontroller = TextEditingController();
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();
//=======================================================================/
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    _titleController.text = passvalue.title;
    _discriptionController.text = passvalue.description;
    _locationcontroller.text = passvalue.location;
    _timeController.text = passvalue.date.toString();
    _dateController.text = passvalue.date.toString();

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
                      child: const Padding(
                        padding: EdgeInsets.all(4),
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
                      child: const Padding(
                        padding: EdgeInsets.all(4),
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

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Fcolor,
          title: const Text('Lets do '),
        ),
        body: ListView(
          children: [
            const SizedBox(
              height: 10,
            ),
            const Center(
              child: texts(
                  mystring: 'Edit event',
                  myfontsize: 32,
                  mycolor: Colors.black87,
                  fontweight: FontWeight.w500),
            ),
            const SizedBox(
              height: 10,
            ),
            Column(
              children: [
                EventImage(flag: true, imagepaths: passvalue.image),
                const SizedBox(
                  height: 10,
                ),
                eventTextform(
                    initial: passvalue.title,
                    mycontroller: _titleController,
                    hintname: ''),
                const SizedBox(
                  height: 7,
                ),
                eventTextform(
                  mycontroller: _discriptionController,
                  hintname: '',
                  initial: passvalue.description,
                ),
                const SizedBox(
                  height: 7,
                ),
                eventTextform(mycontroller: _locationcontroller, hintname: ''),
                const SizedBox(
                  height: 4,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                          child: DateField(
                        dateController: _dateController,
                      )),
                      const SizedBox(width: 5),
                      Expanded(
                          child: TimeField(
                        timeController: _timeController,
                      ))
                    ],
                  ),
                ),
                kHeight15,
                prioritybutton(priority),
                kHeight5,
                SizedBox(
                  height: height / 12,
                ),
                FlatButton(
                  mycolor: Kwhite,
                  mystring: 'Update',
                  onpressaction: () {
                    _onEdittodoeventClicked(passindex);
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (ctx) => const Screen_home()),
                        (route) => false);
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onEdittodoeventClicked(index) async {
    final _title = _titleController.text.trim();
    final _discription = _discriptionController.text.trim();
    final _date = dateTime;
    final _location = _locationcontroller.text.trim();
    final _id = DateTime.now().toString();
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
      id: _id,
      isdone: false,
    );

    editevent(passvalue.id, BuildContext, _todoevent);
    getAllTodoEvent();
  }
}
