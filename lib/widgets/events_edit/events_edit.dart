import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo_app/functions/db_functions.dart';
import 'package:todo_app/models/data_model.dart';
import 'package:todo_app/util/app_color.dart';
import 'package:todo_app/util/event_textform.dart';
import 'package:todo_app/widgets/add_events/timefield.dart';
import 'package:todo_app/widgets/common_widgets/common_text.dart';
import 'package:todo_app/widgets/home_widgets/home_eventlist.dart';

import '../../presentation/screen_home.dart';

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
    return Container(
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

//==============position==========================
  Widget position() {
    return Positioned(
      bottom: 1,
      right: 50,
      child: InkWell(
        onTap: () {
          takePhoto();
        },
        child: const Icon(
          Icons.camera_alt_outlined,
          color: Colors.grey,
          size: 30,
        ),
      ),
    );
  }

//==========================priority button==========================/
  Widget prioritybutton(bool isSwitched, Function onChangeMethod) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const texts(
            mystring: 'Prioirity ?',
            myfontsize: 16,
            mycolor: Colors.black,
            fontweight: FontWeight.w600),
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

//=====================Circle avatar===============================
  Widget circleavtar() {
    return Stack(
      children: [
        CircleAvatar(
          //    backgroundColor: Colors.blueGrey,
          backgroundImage: imagepath == null
              ? FileImage(File(widget.passvalue.image))
              : FileImage(File(imagepath!)),
          radius: 70.0,
        ),
        position()
      ],
    );
  }

//=======================================================================/

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        const texts(
            mystring: 'Edit event',
            myfontsize: 32,
            mycolor: Colors.black87,
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
              height: 7,
            ),
            eventTextform(
              mycontroller: _discriptionController!,
              hintname: '',
            ),
            const SizedBox(
              height: 7,
            ),
            eventTextform(
              mycontroller: _locationcontroller!,
              hintname: '',
            ),
            const SizedBox(
              height: 4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [dates(), times()],
            ),
            const SizedBox(
              height: 4,
            ),
            prioritybutton(myPriority, onchangeFunction),
            flatbtn(
                onpressaction: () {
                  _onEdittodoeventClicked(widget.passindex);
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (ctx) => const Screen_home()),
                      (route) => false);
                  //Navigator.pop(context);
                },
                mycolor: Colors.white,
                mystring: 'Save '),
          ],
        ),
      ],
    );
  }

  Future<void> _onEdittodoeventClicked(index) async {
    final _title = _titleController!.text.trim();
    final _discription = _discriptionController!.text.trim();
    final _date = dateTime;
    final _location = _locationcontroller!.text.trim();
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
      priority: myPriority,
      id: _id,
      isdone: false,
    );
    //  addevent(_todoevent);
    // final todoeventdb = await Hive.openBox<TodoEvent>('todo_event_db');
    // todoeventdb.putAt(index, _todoevent);
    editevent(widget.passvalue.id, context, _todoevent);
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
