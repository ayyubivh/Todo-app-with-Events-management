import 'package:flutter/material.dart';
import 'package:todo_app/screens/screen_eventedit.dart';

import 'package:todo_app/widgets/common_widgets/common_text.dart';

class Eventdtls extends StatelessWidget {
  const Eventdtls({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 40.0,
        ),
        texts(
            mystring: 'Your Events',
            myfontsize: 35,
            mycolor: Colors.white,
            fontweight: FontWeight.bold),
        SizedBox(
          height: 20.0,
        ),
        texts(
            mystring: '19-02-2002',
            myfontsize: 28.0,
            mycolor: Colors.white,
            fontweight: FontWeight.w400),
        SizedBox(
          height: 20,
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14), color: Colors.grey),
          width: 278,
          height: 346,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          //  mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: 30,
            ),
            texts(
                mystring: 'Sundown',
                myfontsize: 38,
                mycolor: Colors.white,
                fontweight: FontWeight.w600),
            SizedBox(
              height: 16,
            ),
            texts(
                mystring: 'Goa @Baga Beach',
                myfontsize: 28.0,
                mycolor: Colors.white,
                fontweight: FontWeight.w500),
            SizedBox(
              height: 13,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(18),
              child: FloatingActionButton(
                backgroundColor: Colors.black,
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (ctx1) => const screen_eventedit()));
                },
                child: Icon(
                  Icons.edit_calendar_outlined,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
