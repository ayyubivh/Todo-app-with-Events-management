import 'package:flutter/material.dart';
import 'package:todo_app/functions/db_functions.dart';
import 'package:todo_app/models/data_model.dart';
import 'package:todo_app/util/app_color.dart';
import 'package:todo_app/widgets/add_events/date.dart';
import 'package:todo_app/widgets/add_events/timefield.dart';
import 'package:todo_app/widgets/add_task/priority_button.dart';
import 'package:todo_app/widgets/common_widgets/common_text.dart';
import '../../util/sizedbox.dart';
import '../../util/tasktextform.dart';
import '../add_events/add_event_scrn.dart';
import 'flatbutton.dart';

final _titleController = TextEditingController();
final _disciptionController = TextEditingController();
final _dateController = TextEditingController();
final _timeController = TextEditingController();

class add_taskform extends StatelessWidget {
  add_taskform({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        kHeight15,
        const texts(
            mystring: 'New Task',
            myfontsize: 27,
            mycolor: Colors.black,
            fontweight: FontWeight.bold),
        kHeight30,
        Column(children: [
          tasktextform(mycontroller: _titleController, hintname: 'Title'),
          kHeight7,
          tasktextform(
              mycontroller: _disciptionController, hintname: 'Discription'),
          kHeight5,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 7),
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
          kHeight5,
          const PriorityButton(),
          kHeight7,
          Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12), color: maincolor),
              child: FlatButton(
                mycolor: Kwhite,
                mystring: 'Add Event',
                onpressaction: () {
                  _onAddtodoButtonClicked();
                  Navigator.pop(context);
                },
              )),
          kHeight10
        ]),
        kHeight10
      ],
    );
  }

  Future<void> _onAddtodoButtonClicked() async {
    final _title = _titleController.text.trim();
    final _discription = _disciptionController.text.trim();
    final _date = dateTime;
    print(dateTime);
    final _id = DateTime.now().toString();

    if (_title.isEmpty || _discription.isEmpty) {
      return;
    }
    final _todo = TodoModel(
        title: _title,
        description: _discription,
        date: _date,
        priority: priority,
        id: _id,
        complete: false,
        isdone: false);
    addtask(_todo);
  }
}
