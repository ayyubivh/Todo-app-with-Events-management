import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Screen_calender extends StatefulWidget {
  const Screen_calender({super.key});

  @override
  State<Screen_calender> createState() => _Screen_calenderState();
}

class _Screen_calenderState extends State<Screen_calender> {
  DateTime today = DateTime.now();
  void _ondayselected(DateTime day, DateTime focus) {
    setState(() {
      today = day;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: [
          //  Text('123'),
          Container(
            child: TableCalendar(
              focusedDay: today,
              firstDay: DateTime.utc(2010, 10, 11),
              lastDay: DateTime.utc(2030, 3, 14),
              headerStyle:
                  HeaderStyle(formatButtonVisible: false, titleCentered: true),
              availableGestures: AvailableGestures.all,
              onDaySelected: _ondayselected,
              selectedDayPredicate: (day) => isSameDay(day, today),
            ),
          )
        ],
      ),
    );
  }
}
