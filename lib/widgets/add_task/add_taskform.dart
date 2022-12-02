import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/functions/db_functions.dart';
import 'package:todo_app/models/data_model.dart';
import 'package:todo_app/widgets/common_widgets/common_text.dart';

class add_taskform extends StatefulWidget {
  add_taskform({super.key});

  @override
  State<add_taskform> createState() => _add_taskformState();
}

class _add_taskformState extends State<add_taskform> {
  final _titleController = TextEditingController();
  final _disciptionController = TextEditingController();
  var _togglecontroller;
  DateTime date = DateTime.now();

  // var dateTime = DateTime.parse("dateTimeString");
  String formatdate(DateTime date) =>
      DateFormat("yyyy-MMM-dd").format(DateTime.now());

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
      height: 60,
      width: 342,
      child: Column(
        children: [
          TextFormField(
            style: TextStyle(color: Colors.black, fontSize: 20),
            textAlignVertical: TextAlignVertical.bottom,
            controller: mycontroller,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(11),
                  borderSide: BorderSide.none),
              filled: true,
              contentPadding: EdgeInsets.all(18),
              fillColor: Color.fromARGB(224, 105, 158, 184),
              hintText: hintname,
              hintStyle: const TextStyle(
                  color: Color.fromARGB(255, 241, 243, 244),
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            ),
            textAlign: TextAlign.center,
          ),
        ],
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
            const SizedBox(
              height: 5,
            ),
            const Icon(
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
                  DateFormat("yyyy MMMdd").format(date),
                  // '${date.toLocal()}'.split(' ')[0],
                  //   semanticsLabel: date.toString(),
                  style: const TextStyle(fontSize: 20, color: Colors.white),
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

//**************************priority********************************************** */
  Widget prioritybutton(bool isSwitched, Function onChangeMethod) {
    return Center(
      child: Switch(
        value: isSwitched,
        onChanged: (newvalue) {
          onChangeMethod(newvalue);
        },
        inactiveThumbColor: Colors.amber,
        activeTrackColor: Colors.red,
        activeColor: Colors.red,
      ),
    );
  }

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
            mystring: 'Add Task',
            myfontsize: 36,
            mycolor: Colors.blue,
            fontweight: FontWeight.w500),
        const SizedBox(
          height: 20,
        ),
        Column(children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: textform(
              _titleController,
              'Title',
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.all(11),
            child: textform(
              _disciptionController,
              'Discription',
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [dates(), times()],
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: const Color.fromARGB(233, 35, 160, 195),
            ),
            child: flatbtn(
                onpressaction: () {
                  _onAddtodoButtonClicked();
                  Navigator.pop(context);
                },
                mycolor: Colors.white,
                mystring: 'Add todo'),
          ),
          const SizedBox(
            height: 20,
          ),
          prioritybutton(myPriority, onchangeFunction),
        ]),
        const SizedBox(
          height: 20,
        ),
        Container(
          decoration: BoxDecoration(
            border:
                Border.all(color: Color.fromARGB(233, 35, 160, 195), width: 2),
            borderRadius: BorderRadius.circular(11),
          ),
          child: flatbtn(
              onpressaction: () {
                Navigator.pop(context);
              },
              mycolor: const Color.fromARGB(233, 35, 160, 195),
              mystring: 'Cancel'),
        ),
      ],
    );
  }

  Future<void> _onAddtodoButtonClicked() async {
    final _title = _titleController.text.trim();
    final _discription = _disciptionController.text.trim();
    final _date = date;

    if (_title.isEmpty || _discription.isEmpty) {
      return;
    }
    final _todo = TodoModel(
      title: _title,
      description: _discription,
      date: _date,
      priority: myPriority,
      id: null,
    );
    addtask(_todo);
  }

  bool myPriority = false;
  onchangeFunction(bool newvalue) {
    setState(() {
      myPriority = newvalue;
    });
  }
}
