import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:todo_app/screens/eventCalender_screen.dart';

import 'package:todo_app/screens/screen_calender.dart';
import 'package:todo_app/screens/screen_dashboard.dart';
import 'package:todo_app/widgets/add_events/add_event_scrn.dart';
import 'package:todo_app/widgets/dasboardScreen.dart/evntDashboard.dart';

import '../add_task/add_taskform.dart';

class event_bottomsection extends StatelessWidget {
  Widget floatbtn(BuildContext context) {
    return
        // floatingActionButton:
        Container(
      height: 55,
      width: 55,
      child: Material(
        type: MaterialType.transparency,
        child: Ink(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white54, width: 2.0),
            color: Colors.blue[600],
            shape: BoxShape.circle,
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(500.0),
            onTap: () {
              _showeventForm(context, null, null);
            },
            child: Icon(
              Icons.add, color: Colors.white,
              //size: 50,
            ),
          ),
        ),
      ),
    );
    // return FloatingActionButton(
    //   onPressed: () {
    //     _showeventForm(context, null, null);
    //   },
    //   child: Icon(Icons.add),
    //   backgroundColor: Color(0xff483b7c),
    // );
  }

  // Widget floatingbutton() {
  //   return FloatingActionButton(onPressed: () {
  //     Navigator.of(context).pushNamed(ScreenaddTransaction.routeName);
  //     if (selectedIndexNotifier.value == 0) {
  //     } else {
  //       showCategoryAddPopup(context);
  //       // final _sample = CategoryModel(
  //       //     id: DateTime.now().microsecondsSinceEpoch.toString(),
  //       //     name: 'Travel',
  //       //     type: CategoryType.expense);
  //     }
  //   });
  // }

  event_bottomsection({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Positioned(
            bottom: 0,
            top: 0,
            child: Container(
              // color: Colors.black,
              width: size.width,
              height: 80,
              child: Stack(
                children: [
                  CustomPaint(
                    size: Size(size.width, 80),
                    painter: BNBCustomPainter(),
                  ),
                ],
              ),
            )),
        // Container(
        //   height: 70.0,
        //   decoration: const BoxDecoration(
        //     borderRadius: BorderRadius.all(
        //       Radius.circular(50),
        //     ),
        //     gradient: LinearGradient(
        //       colors: [
        //         Color.fromARGB(255, 87, 53, 143),
        //         Color.fromARGB(255, 87, 53, 143),
        //       ],
        //       begin: Alignment.topCenter,
        //       end: Alignment.bottomCenter,
        //     ),
        //   ),
        // ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx1) => EventScreen_calender()));
                  },
                  icon: const Icon(
                    Icons.calendar_month,
                    size: 33,
                    color: Colors.white,
                  )),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 34.0),
                  child: floatbtn(context),
                ),
                heightFactor: 0.6,
              ),
              IconButton(
                icon: const Icon(
                  Icons.person,
                  size: 33,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (ctx1) => EventDashboardLists()));
                },
              )
            ],
          ),
        )
      ],
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
      height: MediaQuery.of(context).size.height * 0.80,
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
        color: Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.0),
          topRight: Radius.circular(25.0),
        ),
      ),
      height: MediaQuery.of(context).size.height * 0.88,
      child: add_eventform(),
    ),
  );
}

class BNBCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..color = Colors.blue.shade600
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(0, 20); // Start
    path.quadraticBezierTo(size.width * 0.20, 0, size.width * 0.35, 0);
    path.quadraticBezierTo(size.width * 0.40, 0, size.width * 0.40, 20);
    path.arcToPoint(Offset(size.width * 0.60, 20),
        radius: Radius.circular(20.0), clockwise: false);
    path.quadraticBezierTo(size.width * 0.60, 0, size.width * 0.65, 0);
    path.quadraticBezierTo(size.width * 0.80, 0, size.width, 20);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 20);
    canvas.drawShadow(path, Colors.black, 5, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
