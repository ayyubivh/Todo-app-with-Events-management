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
import '../add_task/flatbutton.dart';

final _titleControllers = TextEditingController();
final _disciptionControllers = TextEditingController();
final _dateControllers = TextEditingController();
final _timeControllers = TextEditingController();

// ignore: must_be_immutable
class EditTaskForm extends StatelessWidget {
  EditTaskForm({super.key, required this.passvalue, required this.passindex});
  var passindex;
  final TodoModel passvalue;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    _titleControllers.text = passvalue.title;
    _disciptionControllers.text = passvalue.description;
    _dateControllers.text = passvalue.date.toString();
    _timeControllers.text = passvalue.date.toString();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Fcolor,
          title: const Text('Lets do'),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 48.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                kHeight15,
                const texts(
                    mystring: ' Edit Task',
                    myfontsize: 27,
                    mycolor: Colors.black,
                    fontweight: FontWeight.bold),
                kHeight30,
                Column(children: [
                  tasktextform(
                      hintname: 'Title',
                      mycontroller: _titleControllers,
                      initial: passvalue.title),
                  kHeight7,
                  tasktextform(
                      mycontroller: _disciptionControllers,
                      hintname: 'Discription'),
                  kHeight5,
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 22, vertical: 7),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                            child: DateField(
                          dateController: _dateControllers,
                        )),
                        const SizedBox(width: 5),
                        Expanded(
                            child: TimeField(
                          timeController: _timeControllers,
                        ))
                      ],
                    ),
                  ),
                  kHeight5,
                  const PriorityButton(),
                  kHeight7,
                  SizedBox(
                    height: height / 4.3,
                  ),
                  Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: maincolor),
                      child: FlatButton(
                        mycolor: Kwhite,
                        mystring: 'update',
                        onpressaction: () {
                          editOnButtonclicked(passindex);
                          Navigator.pop(context);
                        },
                      )),
                  kHeight10
                ]),
                kHeight10
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> editOnButtonclicked(int index) async {
    final _title = _titleControllers.text.trim();
    final _discription = _disciptionControllers.text.trim();
    final _date = dateTime;

    if (_title.isEmpty || _discription.isEmpty) {
      return;
    }
    final _todo = TodoModel(
        title: _title,
        description: _discription,
        date: _date,
        priority: priority,
        complete: false,
        id: DateTime.now().toString(),
        isdone: false);
    editTask(passvalue.id, BuildContext, _todo);
    // final todotaskdb = await Hive.openBox<TodoModel>('todo_task_db');
    // todotaskdb.putAt(index, _todo);
    getAllTodotask();
  }
}
