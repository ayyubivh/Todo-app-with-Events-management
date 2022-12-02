import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo_app/models/data_model.dart';
import 'package:todo_app/screens/screen_details.dart';
import 'package:todo_app/widgets/common_widgets/common_text.dart';

class Screen_search extends StatefulWidget {
  Screen_search({super.key});

  @override
  State<Screen_search> createState() => _Screen_searchState();
}

bool selected = false;
List<Tech> _chipsList = [
  Tech("Tasks", Color.fromARGB(190, 54, 185, 172), false),
  Tech("Events", Color.fromARGB(255, 237, 155, 32), false),
  Tech("This Week", Colors.red, false),
  Tech("This Month", Colors.cyan.shade700, false),
];
//List _datalists = [];

class _Screen_searchState extends State<Screen_search> {
  List<TodoModel> todomodelist =
      Hive.box<TodoModel>('todo_task_db').values.toList();
  late List<TodoModel> todomodellistdisplay =
      List<TodoModel>.from(todomodelist);
  List<TodoEvent> todoEventlist =
      Hive.box<TodoEvent>('todo_Event_db').values.toList();
  late List<TodoEvent> todoEventlistdisplay =
      List<TodoEvent>.from(todoEventlist);
  final _searchcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 87, 53, 143),
          elevation: 0,
          centerTitle: true,
          title: texts(
              mystring: "Search ",
              myfontsize: 22,
              mycolor: Colors.white,
              fontweight: FontWeight.w500),
          bottom: PreferredSize(
              child: Column(
                children: [
                  textform(),
                ],
              ),
              preferredSize: Size(3, 80)),
        ),
        body: Padding(
          padding: EdgeInsets.all(0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Wrap(children: techChips()),
              ),
              expandedTask(),
              expandedEvent()
            ],
          ),
        ));
  }

  void _searchtodomodel(String value) {
    setState(() {
      todomodellistdisplay = todomodelist
          .where((element) =>
              element.title.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

//************************************* */
  Widget textform() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 25,
            offset: Offset(0, 5),
          )
        ],
      ),
      child: TextField(
        controller: _searchcontroller,
        style: TextStyle(
          color: Colors.black54,
          fontSize: 20.0,
        ),
        autofocus: true,
        cursorColor: Colors.black,
        cursorHeight: 20,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'search...',
            // hintStyle: TextStyle(color: Colors.black54),

            //contentPadding: const EdgeInsets.all(22.0),
            //prefixIcon: const Icon(Icons.search),
            prefixIcon: Icon(Icons.search)),
        onChanged: (value) {
          _searchtodomodel(value);
        },
      ),
    );
  }

//*****Task****** */

  Widget expandedTask() {
    return Expanded(
      child: todomodellistdisplay.isNotEmpty
          ? ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: todomodellistdisplay.length,
              itemBuilder: (context, index) {
                //   key: ValueKey(studentlistDisplay[index].name),
                //   File img = File(studentlistDisplay[index].image);
                return Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(146, 51, 48, 114),
                          Color.fromARGB(133, 83, 79, 165),
                        ],
                        begin: Alignment.bottomRight,
                        end: Alignment.topLeft,
                      ),
                    ),
                    child: ListTile(
                      title: Text(
                        todomodellistdisplay[index].title,
                        style: TextStyle(
                            color: Color.fromARGB(255, 37, 10, 83),
                            fontSize: 22.0,
                            fontWeight: FontWeight.w500),
                      ),
                      subtitle: Text(
                        todomodellistdisplay[index].description,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 50, 13, 113),
                            fontSize: 18),
                      ),
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (ctx) => Screen_details(
                                  passvalue: todomodellistdisplay[index],
                                  index: index,
                                )),
                      ),
                    ),
                  ),
                );
              })
          : Center(
              child: const Text(
                ' No Tasks  found',
                style: TextStyle(
                    fontSize: 22,
                    color: Colors.grey,
                    fontWeight: FontWeight.w400),
              ),
            ),
    );
  } //*****Task****** */

  Widget expandedEvent() {
    return Expanded(
      child: todoEventlistdisplay.isNotEmpty
          ? ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: todoEventlistdisplay.length,
              itemBuilder: (context, index) {
                //   key: ValueKey(studentlistDisplay[index].name),
                //   File img = File(studentlistDisplay[index].image);
                return Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(146, 51, 48, 114),
                          Color.fromARGB(133, 83, 79, 165),
                        ],
                        begin: Alignment.bottomRight,
                        end: Alignment.topLeft,
                      ),
                    ),
                    child: ListTile(
                      title: Text(
                        todoEventlistdisplay[index].title,
                        style: TextStyle(
                            color: Color.fromARGB(255, 37, 10, 83),
                            fontSize: 22.0,
                            fontWeight: FontWeight.w500),
                      ),
                      subtitle: Text(
                        todoEventlistdisplay[index].description,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 50, 13, 113),
                            fontSize: 18),
                      ),
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (ctx) => Screen_details(
                                  passvalue: todomodellistdisplay[index],
                                  index: index,
                                )),
                      ),
                    ),
                  ),
                );
              })
          : Center(
              child: const Text(
                ' No Events found',
                style: TextStyle(
                    fontSize: 22,
                    color: Colors.grey,
                    fontWeight: FontWeight.w400),
              ),
            ),
    );
  }

  List<Widget> techChips() {
    List<Widget> chips = [];
    for (int i = 0; i < _chipsList.length; i++) {
      Widget item = Padding(
        padding: const EdgeInsets.only(left: 10, right: 5),
        child: FilterChip(
          elevation: 5,
          pressElevation: 10,
          label: Text(_chipsList[i].label),
          labelStyle: TextStyle(color: Colors.white),
          backgroundColor: _chipsList[i].color,
          selected: _chipsList[i].isSelected,
          onSelected: (bool value) {
            setState(() {
              _chipsList[i].isSelected = value;
            });
          },
        ),
      );
      chips.add(item);
    }
    return chips;
  }
}

class Tech {
  String label;
  Color color;
  bool isSelected;
  Tech(this.label, this.color, this.isSelected);
}
