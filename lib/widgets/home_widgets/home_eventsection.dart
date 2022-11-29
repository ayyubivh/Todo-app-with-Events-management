import 'package:flutter/material.dart';

import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_app/functions/db_functions.dart';
import 'package:todo_app/screens/screen_event_dtls.dart';

import '../../models/data_model.dart';

class Home_eventsection extends StatefulWidget {
  const Home_eventsection({super.key});

  @override
  State<Home_eventsection> createState() => _Home_eventsection();
}

class _Home_eventsection extends State<Home_eventsection> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: todolisteventnotifier,
      builder: (BuildContext ctx, List<TodoEvent> todoevent, Widget? child) {
        return ListView.builder(
          // shrinkWrap: true,
          // physics: NeverScrollableScrollPhysics(),
          itemCount: todoevent.length,
          itemBuilder: (context, index) {
            final dataevent = todoevent[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                color: Colors.transparent,
                shadowColor: Colors.black,
                elevation: 5,
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                    gradient: LinearGradient(
                      colors: [
                        Color.fromRGBO(100, 98, 222, 20),
                        Color.fromARGB(232, 78, 75, 222),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  width: 324,
                  height: 80,
                  child: Slidable(
                    // closeOnScroll: false,
                    startActionPane: ActionPane(
                      motion: StretchMotion(),
                      children: [
                        SlidableAction(
                          //borderRadius: BorderRadius.circular(10.0),
                          onPressed: ((context) {}),
                          backgroundColor: Color.fromARGB(255, 24, 207, 164),
                          foregroundColor: Colors.white,
                          icon: Icons.done_all,
                          label: 'Done ',
                        ),
                      ],
                    ),
                    endActionPane: ActionPane(
                      motion: StretchMotion(),
                      children: [
                        SlidableAction(
                          onPressed: ((context) {}),
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: 'delete',
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Screen_eventsdtls(
                                    passvalue: dataevent,
                                  )));
                        },
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              dataevent.title,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.w400),
                            ),
                            Icon(
                              Icons.notifications_active,
                              color: Color.fromARGB(227, 219, 21, 7),
                              size: 26,
                            ),
                          ],
                        ),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(),
                              child: Container(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 15.0),
                                  child: Text(
                                    dataevent.date.toString(),
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16.0),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
