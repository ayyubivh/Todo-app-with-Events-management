import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import 'package:todo_app/screens/screen_calender.dart';
import 'package:todo_app/screens/screen_dashboard.dart';
import 'package:todo_app/widgets/add_events/add_event_scrn.dart';

import '../add_task/add_taskform.dart';

class Home_bottomsection extends StatelessWidget {
  //*****************floatbutn*****************8 */
  Widget floatbtn(BuildContext context) {
    return SpeedDial(
      curve: Curves.bounceInOut,
      visible: true,
      spaceBetweenChildren: 3,
      backgroundColor: Color.fromARGB(255, 27, 30, 71),
      icon: Icons.add,
      activeIcon: Icons.close,
      overlayOpacity: 0,
      children: [
        SpeedDialChild(
            foregroundColor: Colors.white,
            //  labelBackgroundColor: Colors.black,
            label: 'task',
            child: Icon(Icons.edit),
            backgroundColor: Color.fromARGB(232, 78, 75, 222),
            onTap: () {
              _showaddtaskForm(context, null, null);
            }),
        SpeedDialChild(
            foregroundColor: Colors.white,
            // labelBackgroundColor: Colors.black,
            label: 'event',
            child: Icon(Icons.event),
            backgroundColor: Color.fromARGB(232, 78, 75, 222),
            onTap: (() {
              _showeventForm(context, null, null);
            }))
      ],
    );
  }

  Home_bottomsection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Stack(
        children: [
          Container(
            height: 70.0,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(50),
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
          ),
          Padding(
            padding: const EdgeInsets.all(7.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx1) => Screen_calender()));
                    },
                    icon: Icon(
                      Icons.calendar_month,
                      size: 33,
                      color: Colors.white,
                    )),
                floatbtn(context),
                IconButton(
                  icon: Icon(
                    Icons.person,
                    size: 33,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx1) => Screen_dashboard()));
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

void _showaddtaskForm(BuildContext context, var itemkey, var index) {
  showModalBottomSheet(
    backgroundColor: Colors.transparent,
    isDismissible: false,
    isScrollControlled: true,
    context: context,
    builder: (_) => Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.0),
          topRight: Radius.circular(25.0),
        ),
      ),
      height: MediaQuery.of(context).size.height * 0.70,
      child: add_taskform(),
    ),
  );
}

void _showeventForm(BuildContext context, var itemkey, var index) {
  showModalBottomSheet(
    backgroundColor: Colors.transparent,
    isDismissible: false,
    isScrollControlled: true,
    context: context,
    builder: (_) => Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.0),
          topRight: Radius.circular(25.0),
        ),
      ),
      height: MediaQuery.of(context).size.height * 0.74,
      child: add_eventform(),
    ),
  );
}
