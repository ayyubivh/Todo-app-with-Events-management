import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/models/data_model.dart';
import 'package:todo_app/screens/screen_details.dart';
import 'package:todo_app/screens/screen_event_dtls.dart';
import 'package:todo_app/widgets/common_widgets/common_text.dart';

class Screen_search extends StatefulWidget {
  Screen_search({super.key});

  @override
  State<Screen_search> createState() => _Screen_searchState();
}

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
  bool selected = false;
  final List<Tech> _chipsList = [
    Tech("Tasks", Color.fromARGB(190, 54, 185, 172), false),
    Tech("Events", Color.fromARGB(255, 237, 155, 32), false),
    Tech("This Week", Colors.red, false),
    Tech("This Month", Colors.cyan.shade700, false),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff483b7c),
          elevation: 0,
          centerTitle: true,
          title: const texts(
              mystring: "Search ",
              myfontsize: 21,
              mycolor: Colors.white,
              fontweight: FontWeight.w500),
          bottom: PreferredSize(
              preferredSize: Size(3, 80),
              child: Column(
                children: [
                  textform(),
                ],
              )),
        ),
        body: Padding(
          padding: EdgeInsets.all(0),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Wrap(children: techChips()),
              ),
              Expanded(child: expandedTask()),
              Expanded(child: expandedEvent())
            ],
          ),
        ));
  }

  void _searchtodotask(String value) {
    setState(() {
      todomodellistdisplay = todomodelist
          .where((element) =>
              element.title.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  void _searchtodoevent(String value) {
    setState(() {
      todoEventlistdisplay = todoEventlist
          .where((element) =>
              element.title.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

//************************************* */
  Widget textform() {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0, right: 5.0),
      child: Container(
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
            color: Colors.black,
            fontSize: 16,
          ),
          autofocus: true,
          cursorColor: Colors.black,
          cursorHeight: 20,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'search...',
            hintStyle: TextStyle(color: Colors.black54, fontSize: 18),
            //   contentPadding: const EdgeInsets.all(5),
            prefixIcon: const Icon(Icons.search),
            //    prefixIcon: Icon(Icons.search)
          ),
          onChanged: (value) {
            _searchtodotask(value);
            _searchtodoevent(value);
          },
        ),
      ),
    );
  }

//*****Task****** */

  Widget expandedTask() {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: Card(
          color: Color.fromARGB(84, 92, 35, 190),
          child: ExpansionTile(
            iconColor: Colors.white,
            // backgroundColor: Colors.red,
            title: Center(
                child: Text(
              '   Tasks',
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18)),
            )),
            children: [
              todomodellistdisplay.isNotEmpty
                  ? ListView(
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      children: [
                        ListView.builder(
                            //  physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            //  primary: false,
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
                                          color: Colors.white,
                                          fontSize: 22.0,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    trailing:
                                        todomodellistdisplay[index].priority ??
                                                false
                                            ? const Icon(
                                                Icons.hourglass_full_outlined,
                                                size: 35,
                                                color: Colors.red,
                                              )
                                            : const Icon(
                                                Icons.hourglass_bottom,
                                                size: 35,
                                                color: Colors.yellow,
                                              ),
                                    subtitle: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          DateFormat("MMM, dd yyy ").format(
                                              todomodellistdisplay[index].date),
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w800),
                                        ),
                                      ],
                                    ),
                                    onTap: () => Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (ctx) => Screen_details(
                                                passvalue:
                                                    todomodellistdisplay[index],
                                                passindex: index,
                                              )),
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ],
                    )
                  : Center(
                      child: const Text(
                        ' No Tasks  found',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white60,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  } //*****Task****** */

  Widget expandedEvent() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: Card(
        color: Color.fromARGB(84, 92, 35, 190),
        child: ExpansionTile(
          title: Center(
              child: Text(
            '     Events',
            style: GoogleFonts.poppins(
                textStyle: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18)),
          )),
          children: [
            todoEventlistdisplay.isNotEmpty
                ? ListView(
                    shrinkWrap: true,
                    children: [
                      ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: todoEventlistdisplay.length,
                          itemBuilder: (context, index) {
                            //   key: ValueKey(studentlistDisplay[index].name),
                            //File img = File(studentlistDisplay[index].image);
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
                                        color: Colors.white,
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  subtitle: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        DateFormat("MMM, dd yyy ").format(
                                            todoEventlistdisplay[index].date),
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w800),
                                      ),
                                    ],
                                  ),
                                  onTap: () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (ctx) => Screen_eventsdtls(
                                              passvalue:
                                                  todoEventlistdisplay[index],
                                              passindex: index,
                                            )),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ],
                  )
                : const Center(
                    child: Text(
                      ' No Events found',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white60,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
          ],
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
