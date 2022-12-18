import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import 'package:todo_app/screens/screen_calender.dart';
import 'package:todo_app/screens/screen_dashboard.dart';
import 'package:todo_app/util/app_color.dart';
import 'package:todo_app/widgets/add_events/add_event_scrn.dart';

import '../add_task/add_taskform.dart';

class task_bottomsection extends StatelessWidget {
  Widget floatbtn(BuildContext context) {
    return SizedBox(
      height: 52,
      width: 52,
      child: Material(
        type: MaterialType.transparency,
        child: Ink(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 2.0),
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(500.0),
            onTap: () {
              _showaddtaskForm(context, null, null);
            },
            child: Icon(
              Icons.add,
              color: maincolor,
              size: 35,
            ),
          ),
        ),
      ),
    );
  }

  task_bottomsection({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Positioned(
            bottom: 0,
            top: 0,
            child: SizedBox(
              // color: Colors.black,
              width: size.width,
              height: 80,
              child: Stack(
                children: [navcontainer()],
              ),
            )),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx1) => Screen_calender()));
                  },
                  icon: const Icon(
                    Icons.calendar_month,
                    size: 31,
                    color: Colors.white,
                  )),
              Center(
                heightFactor: 0.3,
                child: floatbtn(context),
              ),
              IconButton(
                icon: const Icon(
                  Icons.person,
                  size: 31,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (ctx1) => Screen_dashboard()));
                },
              )
            ],
          ),
        )
      ],
    );
  }
}

Widget navcontainer() {
  return Padding(
    padding: const EdgeInsets.only(right: 11.0, left: 2),
    child: Container(
      decoration: BoxDecoration(
          color: maincolor, borderRadius: BorderRadius.circular(50)),
    ),
  );
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
          topLeft: Radius.circular(35.0),
          topRight: Radius.circular(35.0),
        ),
      ),
      height: MediaQuery.of(context).size.height * 0.64,
      child: add_taskform(),
    ),
  );
}
