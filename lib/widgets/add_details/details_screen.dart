import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/util/app_color.dart';

import 'package:todo_app/widgets/common_widgets/common_text.dart';

import '../edit_task/edit_taskform.dart';

class details_screen extends StatelessWidget {
  details_screen({
    super.key,
    required this.passvalue,
    required this.passindex,
  });
  var passvalue;
  var passindex;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(28.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${passvalue.title}',
                    style: GoogleFonts.ubuntu(
                      textStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.calendar_today_outlined,
                            size: 22.0,
                            color: Colors.black54,
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Text(
                            DateFormat("MMM, dd yyy  ").format(passvalue.date),
                            //  data.date.toString(),
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.watch_later_outlined,
                        color: Colors.black54,
                      ),
                      Text(
                        DateFormat("  hh:mm a").format(passvalue.date),
                        //  data.date.toString(),
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const texts(
                          mystring: 'Priority :',
                          myfontsize: 16,
                          mycolor: Colors.black,
                          fontweight: FontWeight.bold),
                      const SizedBox(
                        width: 20,
                      ),
                      passvalue.priority ?? false
                          ? ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(50.0))),
                              onPressed: () {},
                              child: const texts(
                                  mystring: 'High',
                                  myfontsize: 14,
                                  mycolor: Colors.white,
                                  fontweight: FontWeight.bold),
                            )
                          : ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.yellow,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(50.0))),
                              onPressed: (() {}),
                              child: texts(
                                mystring: 'Low',
                                myfontsize: 18,
                                fontweight: FontWeight.bold,
                                mycolor: Colors.grey.shade800,
                              ),
                            ),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  const Center(
                    child: texts(
                        mystring: 'About',
                        myfontsize: 18,
                        mycolor: Colors.black,
                        fontweight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(20)),
                      width: 370,
                      height: 271,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '${passvalue.description}',
                          style: const TextStyle(
                            color: Colors.black45,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 17.0),
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: 370,
                            height: 60.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: ElevatedButton(
                                onPressed: () {
                                  _showeditaddtaskForm(context,
                                      passvalue: passvalue,
                                      passindex: passindex);
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Fcolor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20))),
                                child: const Text(
                                  'Edit',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1),
                                )),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void _showeditaddtaskForm(BuildContext context,
    {required passvalue, required passindex}) {
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
      height: MediaQuery.of(context).size.height * 0.65,
      child: edit_taskform(
        passvalue: passvalue,
        passindex: passindex,
      ),
    ),
  );
}
