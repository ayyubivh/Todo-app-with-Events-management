import 'package:flutter/material.dart';
import '../../util/app_color.dart';
import '../add_events/add_event_scrn.dart';

class PriorityButton extends StatelessWidget {
  const PriorityButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'priority ?',
          style: TextStyle(
              color: Colors.black, fontSize: 19, fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton(
                onPressed: () {
                  priority = true;
                },
                child: Container(
                  height: 30,
                  width: 75,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.red),
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Text(
                      'high',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Kwhite),
                    ),
                  ),
                )),
            TextButton(
                onPressed: () {
                  priority = false;
                },
                child: Container(
                  height: 30,
                  width: 75,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.yellow),
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Text(
                      'low',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Fcolor),
                    ),
                  ),
                ))
          ],
        )
      ],
    );
  }
}
