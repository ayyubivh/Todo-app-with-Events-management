import 'package:flutter/material.dart';
import 'package:todo_app/screens/screen_home.dart';
import 'package:todo_app/widgets/common_widgets/common_text.dart';

class edit_taskform extends StatefulWidget {
  edit_taskform({super.key, required this.passvalue});
  var passvalue;

  @override
  State<edit_taskform> createState() => _edit_taskformState();
}

class _edit_taskformState extends State<edit_taskform> {
  final _titleController = TextEditingController();

  final _disciptionController = TextEditingController();

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

  //******************widgets******************** */
  Widget textform(
    TextEditingController mycontroller,
    String hintname,
  ) {
    return SizedBox(
      height: 60,
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
          hintText: hintname,
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
              color: Colors.white70,
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

//********************************************************* */
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        texts(
            mystring: 'Edit Task',
            myfontsize: 36,
            mycolor: Colors.blue,
            fontweight: FontWeight.w500),
        SizedBox(
          height: 20,
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: textform(_titleController, widget.passvalue.title),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(11),
              child:
                  textform(_disciptionController, widget.passvalue.description),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [dates(), times()],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Color.fromARGB(233, 35, 160, 195),
              ),
              child: flatbtn(
                  onpressaction: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (ctx1) => Screen_home())),
                  mycolor: Colors.white,
                  mystring: 'Add todo'),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                    color: Color.fromARGB(233, 35, 160, 195), width: 2),
                borderRadius: BorderRadius.circular(11),
              ),
              child: flatbtn(
                  onpressaction: () {
                    Navigator.pop(context);
                  },
                  mycolor: Color.fromARGB(233, 35, 160, 195),
                  mystring: 'Cancel'),
            ),
          ],
        ),
      ],
    );
  }
}
