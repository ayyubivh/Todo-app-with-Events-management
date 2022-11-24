import 'package:flutter/material.dart';
import 'package:todo_app/screens/screen_details.dart';
import 'package:todo_app/widgets/common_widgets/common_text.dart';

class add_taskform extends StatefulWidget {
  add_taskform({super.key});

  @override
  State<add_taskform> createState() => _add_taskformState();
}

class _add_taskformState extends State<add_taskform> {
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
        style: TextStyle(color: Colors.white, fontSize: 20),
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
          hintStyle: const TextStyle(color: Colors.white, fontSize: 16.0),
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
          height: 30,
        ),
        texts(
            mystring: 'Add Task',
            myfontsize: 36,
            mycolor: Colors.white,
            fontweight: FontWeight.w500),
        SizedBox(
          height: 30,
        ),
        Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(22)),
          height: 560,
          width: 360,
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: textform(_titleController, 'Title'),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.all(11),
                child: textform(_disciptionController, 'Discription'),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [dates(), times()],
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Color.fromARGB(233, 35, 160, 195),
                ),
                child: flatbtn(
                    onpressaction: () => Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (ctx1) => const Screen_details())),
                    mycolor: Colors.white,
                    mystring: 'Add todo'),
              ),
              SizedBox(
                height: 30,
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
        ),
      ],
    );
  }
}
