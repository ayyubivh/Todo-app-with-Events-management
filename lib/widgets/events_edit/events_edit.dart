import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo_app/functions/db_functions.dart';
import 'package:todo_app/models/data_model.dart';
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
  TextEditingController? _disciptionController;
  TextEditingController? _locationcontroller;
  DateTime date = DateTime(2022, 12, 24);
  String? path;
  final ImagePicker _picker = ImagePicker();

  String? imagepath;

  // DateTime date = DateTime(2022, 12, 24);
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

  @override
  void initState() {
    _titleController = TextEditingController(text: widget.passvalue.title);

    _disciptionController =
        TextEditingController(text: widget.passvalue.description);
    _locationcontroller =
        TextEditingController(text: widget.passvalue.location);
    path = widget.passvalue.image;
    DateTime date = DateTime(2022, 12, 24);
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
            SizedBox(
              height: 5,
            ),
            Icon(
              Icons.calendar_month_outlined,
              size: 26.0,
              color: Colors.white,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent, elevation: 0),
                onPressed: () {
                  _showDatePicker();
                },
                child: Text(
                  '${date.year}/${date.month}/${date.day}',
                  semanticsLabel: date.toString(),
                  style: TextStyle(fontSize: 20, color: Colors.white),
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
          color: const Color.fromARGB(232, 20, 139, 199)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(
            height: 5,
          ),
          const Icon(
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
          backgroundImage: path == null
              ? FileImage(File(widget.passvalue.image))
              : FileImage(File(path!)),
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
          height: 15,
        ),
        const texts(
            mystring: 'Edit event',
            myfontsize: 32.0,
            mycolor: Color.fromARGB(233, 15, 103, 127),
            fontweight: FontWeight.w500),
        const SizedBox(
          height: 15,
        ),
        Column(
          children: [
            circleavtar(),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: textform(_titleController),
            ),
            Padding(
              padding: const EdgeInsets.all(11),
              child: textform(_disciptionController),
            ),
            const SizedBox(
              height: 10,
            ),
            textform(_locationcontroller),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [dates(), times()],
            ),
            const SizedBox(
              height: 10,
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
                        MaterialPageRoute(
                            builder: (ctx) => const Screen_home()),
                        (route) => false);
                    Navigator.pop(context);
                  },
                  mycolor: Colors.white,
                  mystring: 'Save '),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                    color: const Color.fromARGB(233, 35, 160, 195), width: 2),
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
        ),
      ],
    );
  }

  Future<void> _onEdittodoeventClicked(int index) async {
    final _title = _titleController!.text.trim();
    final _discription = _disciptionController!.text.trim();
    final _date = date;
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
        priority: myPriority);
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
        path = PickedFile.path;
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
