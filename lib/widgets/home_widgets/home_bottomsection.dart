import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:todo_app/screens/screen_add.dart';
import 'package:todo_app/screens/screen_add_event.dart';
import 'package:todo_app/screens/screen_calender.dart';
import 'package:todo_app/screens/screen_dashboard.dart';

class Home_bottomsection extends StatelessWidget {
  //*****************floatbutn*****************8 */
  Widget floatbtn(BuildContext context) {
    return SpeedDial(
      curve: Curves.bounceInOut,
      visible: true,
      spaceBetweenChildren: 3,
      backgroundColor: Colors.black,
      icon: Icons.add,
      activeIcon: Icons.close,
      overlayOpacity: 0,
      children: [
        SpeedDialChild(
            foregroundColor: Colors.white,
            //  labelBackgroundColor: Colors.black,
            label: 'task',
            child: Icon(Icons.edit),
            backgroundColor: Colors.black,
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx1) => const screen_addtask()));
            }),
        SpeedDialChild(
            foregroundColor: Colors.white,
            // labelBackgroundColor: Colors.black,
            label: 'event',
            child: Icon(Icons.event),
            backgroundColor: Colors.black,
            onTap: (() {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx1) => const screen_addevent()));
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
                  Color.fromARGB(232, 13, 57, 119),
                  Color.fromARGB(222, 4, 12, 67),
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
