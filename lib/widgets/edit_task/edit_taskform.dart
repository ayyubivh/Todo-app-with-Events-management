import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/functions/db_functions.dart';
import 'package:todo_app/presentation/screen_home.dart';
import 'package:todo_app/util/app_color.dart';
import 'package:todo_app/util/sizedbox.dart';
import 'package:todo_app/widgets/add_events/timefield.dart';
import 'package:todo_app/widgets/add_task/add_taskform.dart';
import 'package:todo_app/widgets/common_widgets/common_text.dart';

import '../../models/data_model.dart';
import '../../util/tasktextform.dart';

class edit_taskform extends StatefulWidget {
  edit_taskform({
    super.key,
    required this.passvalue,
    required this.passindex,
  });
  var passvalue;
  var passindex;

  @override
  State<edit_taskform> createState() => _edit_taskformState();
}

class _edit_taskformState extends State<edit_taskform> {
  TextEditingController? _titleController;
  TextEditingController? _disciptionController;
  DateTime dateTime = DateTime.now();

  @override
  void initState() {
    _titleController = TextEditingController(text: widget.passvalue.title);

    _disciptionController =
        TextEditingController(text: widget.passvalue.description);
    dateTime = widget.passvalue.date;
    myPriority = widget.passvalue.priority;
    super.initState();
  }

//***********************Date***************************/
  Widget dates() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey[200],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              padding: EdgeInsets.all(17)),
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
            padding: EdgeInsets.all(17)),
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
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
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

//**************************priority********************************************** */
  Widget prioritybutton(bool isSwitched, Function onChangeMethod) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const texts(
            mystring: 'Prioirity ?',
            myfontsize: 18,
            mycolor: Colors.black,
            fontweight: FontWeight.bold),
        const SizedBox(
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

//********************************************************* */
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 18,
        ),
        const texts(
            mystring: 'Edit Task',
            myfontsize: 27,
            mycolor: Colors.black,
            fontweight: FontWeight.bold),
        kHeight7,
        Padding(
            padding: const EdgeInsets.all(12.0),
            child: tasktextform(mycontroller: _titleController, hintname: '')),
        Padding(
            padding: const EdgeInsets.all(11),
            child: tasktextform(
                mycontroller: _disciptionController, hintname: '')),
        kHeight7,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [dates(), times()],
        ),
        prioritybutton(myPriority, onchangeFunction),
        kHeight15,
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: const Color(0xff4a90fa),
          ),
          child: flatbtn(
              onpressaction: () {
                editOnButtonclicked(widget.passindex);
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (ctx) => Screen_home()),
                    (route) => false);
              },
              mycolor: Colors.white,
              mystring: 'Save'),
        ),
        kHeight15
      ],
    );
  }

  Future<void> editOnButtonclicked(int index) async {
    final _title = _titleController!.text.trim();
    final _discription = _disciptionController!.text.trim();
    final _date = dateTime;

    if (_title.isEmpty || _discription.isEmpty) {
      return;
    }
    final _todo = TodoModel(
        title: _title,
        description: _discription,
        date: _date,
        priority: myPriority,
        complete: false,
        id: DateTime.now().toString(),
        isdone: false);
    editTask(widget.passvalue.id, context, _todo);
    // final todotaskdb = await Hive.openBox<TodoModel>('todo_task_db');
    // todotaskdb.putAt(index, _todo);
    getAllTodotask();
  }

  bool myPriority = false;

  onchangeFunction(bool newvalue) {
    setState(() {
      myPriority = newvalue;
    });
  }
}
