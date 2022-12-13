import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/functions/db_functions.dart';
import 'package:todo_app/models/data_model.dart';
import 'package:todo_app/widgets/common_widgets/common_text.dart';

import '../../util/tasktextform.dart';

class add_taskform extends StatefulWidget {
  add_taskform({super.key});

  @override
  State<add_taskform> createState() => _add_taskformState();
}

class _add_taskformState extends State<add_taskform> {
  final _titleController = TextEditingController();
  final _disciptionController = TextEditingController();
  var _togglecontroller;

  DateTime dateTime = DateTime.now();

  //******************widgets******************** */

//***********************Date***************************/
  Widget dates() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey[200],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              padding: EdgeInsets.all(19)),
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
            style: TextStyle(
                color: Colors.blue[700],
                fontWeight: FontWeight.bold,
                fontSize: 18),
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
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            padding: EdgeInsets.all(19)),
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
          style: TextStyle(
              color: Colors.blue[700],
              fontWeight: FontWeight.bold,
              fontSize: 18),
        ),
      ),
    );
  }

  Future<TimeOfDay?> pickTime() => showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: dateTime.hour, minute: dateTime.minute));

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
            fontweight: FontWeight.bold,
            mycolor: mycolor,
          )),
    );
  }

//**************************priority********************************************** */

  Widget prioritybutton(bool isSwitched, Function onChangeMethod) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        texts(
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

  bool myPriority = false;
  onchangeFunction(bool newvalue) {
    setState(() {
      myPriority = newvalue;
    });
  }

//text
  // Widget textAddTask() {
  //   return texts(
  //       mystring: 'Add Your Task',
  //       myfontsize: 14,
  //       mycolor: Colors.black,
  //       fontweight: null);
  // }

//********************************************************* */
  @override
  Widget build(BuildContext context) {
    //   final String _formatdate = DateFormat.yMMMd().format(date);
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        const texts(
            mystring: 'New Task',
            myfontsize: 27,
            mycolor: Colors.black,
            fontweight: FontWeight.bold),
        const SizedBox(
          height: 10,
        ),
        Column(children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child:
                tasktextform(mycontroller: _titleController, hintname: 'Title'),
          ),
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.all(11),
            child: tasktextform(
                mycontroller: _disciptionController, hintname: 'Discription'),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [dates(), times()],
          ),
          const SizedBox(
            height: 7,
          ),
          prioritybutton(myPriority, onchangeFunction),
          const SizedBox(
            height: 7,
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Color(0xff4a90fa)),
            child: flatbtn(
                onpressaction: () {
                  _onAddtodoButtonClicked();
                  Navigator.pop(context);
                },
                mycolor: Colors.white,
                mystring: 'Add todo'),
          ),
          const SizedBox(
            height: 10,
          ),
        ]),
        const SizedBox(
          height: 10,
        ),
        // Container(
        //   decoration: BoxDecoration(
        //     border:
        //         Border.all(color: Color.fromARGB(233, 35, 160, 195), width: 2),
        //     borderRadius: BorderRadius.circular(11),
        //   ),
        //   // child: flatbtn(
        //   //     onpressaction: () {
        //   //       Navigator.pop(context);
        //   //     },
        //   //     mycolor: const Color.fromARGB(233, 35, 160, 195),
        //   //     mystring: 'Cancel'),
        // ),
      ],
    );
  }

  Future<void> _onAddtodoButtonClicked() async {
    final _title = _titleController.text.trim();
    final _discription = _disciptionController.text.trim();
    final _date = dateTime;
    final _id = DateTime.now().toString();
    if (_title.isEmpty || _discription.isEmpty) {
      return;
    }
    final _todo = TodoModel(
        title: _title,
        description: _discription,
        date: _date,
        priority: myPriority,
        id: _id,
        complete: false);
    addtask(_todo);
  }
}
