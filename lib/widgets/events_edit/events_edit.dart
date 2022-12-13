import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo_app/functions/db_functions.dart';
import 'package:todo_app/models/data_model.dart';
import 'package:todo_app/util/event_textform.dart';
import 'package:todo_app/widgets/common_widgets/common_text.dart';

import '../../screens/screen_home.dart';

class edit_eventform extends StatefulWidget {
  edit_eventform({super.key, required this.passvalue, required this.passindex});
  var passvalue;
  var passindex;
  @override
  State<edit_eventform> createState() => _edit_eventformState();
}

class _edit_eventformState extends State<edit_eventform> {
  TextEditingController? _titleController;
  TextEditingController? _discriptionController;
  TextEditingController? _locationcontroller;

  // String? path;
  final ImagePicker _picker = ImagePicker();

  String? imagepath;

  DateTime dateTime = DateTime.now();

  @override
  void initState() {
    _titleController = TextEditingController(text: widget.passvalue.title);

    _discriptionController =
        TextEditingController(text: widget.passvalue.description);
    _locationcontroller =
        TextEditingController(text: widget.passvalue.location);
    dateTime = widget.passvalue.date;
    myPriority = widget.passvalue.priority;
    imagepath = widget.passvalue.image;

    super.initState();
  }

  //******************widgets******************** */
  Widget textform(
    TextEditingController? mycontroller,
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
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              padding: EdgeInsets.all(25)),
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
            '${dateTime.year}/${dateTime.month}/${dateTime.day}',
            style: TextStyle(color: Colors.black),
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
            backgroundColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            padding: EdgeInsets.all(25)),
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
          '$hours:$minutes',
          style: TextStyle(color: Colors.black),
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
            fontweight: FontWeight.w500,
            mycolor: mycolor,
          )),
    );
  }

//position
  Widget position() {
    return Positioned(
      bottom: 20,
      right: 20,
      child: InkWell(
        onTap: () {
          takePhoto();
        },
        child: const Icon(
          Icons.photo_camera_back_outlined,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }

//**************************priority button********************************************** */
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

  Widget circleavtar() {
    return Stack(
      children: [
        CircleAvatar(
          backgroundColor: Colors.blueGrey,
          backgroundImage: imagepath == null
              ? FileImage(File(widget.passvalue.image))
              : FileImage(File(imagepath!)),
          radius: 80.0,
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
            mystring: 'Edit event',
            myfontsize: 32.0,
            mycolor: Color.fromARGB(233, 15, 103, 127),
            fontweight: FontWeight.w500),
        const SizedBox(
          height: 10,
        ),
        Column(
          children: [
            circleavtar(),
            const SizedBox(
              height: 10,
            ),
            eventTextform(
              mycontroller: _titleController!,
              hintname: '',
            ),
            const SizedBox(
              height: 10,
            ),
            eventTextform(
              mycontroller: _discriptionController!,
              hintname: '',
            ),
            const SizedBox(
              height: 10,
            ),
            eventTextform(
              mycontroller: _locationcontroller!,
              hintname: '',
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [dates(), times()],
            ),
            const SizedBox(
              height: 5,
            ),
            prioritybutton(myPriority, onchangeFunction),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: const Color.fromARGB(233, 35, 160, 195),
              ),
              child: flatbtn(
                  onpressaction: () {
                    _onEdittodoeventClicked(widget.passindex);
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (ctx) => Screen_home()),
                        (route) => false);
                    //Navigator.pop(context);
                  },
                  mycolor: Colors.white,
                  mystring: 'Save '),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _onEdittodoeventClicked(int index) async {
    final _title = _titleController!.text.trim();
    final _discription = _discriptionController!.text.trim();
    final _date = dateTime;
    final _location = _locationcontroller!.text.trim();
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
        id: DateTime.now().toString());
    //  addevent(_todoevent);
    final todoeventdb = await Hive.openBox<TodoEvent>('todo_event_db');
    todoeventdb.putAt(index, _todoevent);
    getAllTodoEvent();
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
