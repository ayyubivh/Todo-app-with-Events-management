import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

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
    return Column(
      children: [
        SizedBox(
          height: 30.0,
        ),
        Container(
          height: 73,
          width: 350.0,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(22),
          ),
          child: Padding(
            padding: const EdgeInsets.all(23),
            child: Text(
              '${passvalue.title}',
              style: GoogleFonts.montserrat(
                textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        SizedBox(
          height: 38,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 30,
            ),
            Icon(
              Icons.calendar_today_outlined,
              size: 22.0,
              color: Colors.black,
            ),
            SizedBox(
              width: 12,
            ),
            Text(
              DateFormat("MMM, dd yyy hh:mm a").format(passvalue.date),
              //  data.date.toString(),
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: 60,
            ),
            passvalue.priority ?? false
                ? Container(
                    decoration: BoxDecoration(
                        color: Colors.red[100],
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: const Icon(
                        Icons.hourglass_full_outlined,
                        size: 35,
                        color: Colors.red,
                      ),
                    ),
                  )
                : Container(
                    decoration: BoxDecoration(
                        color: Colors.yellow[100],
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: const Icon(
                        Icons.hourglass_bottom,
                        size: 35,
                        color: Colors.yellow,
                      ),
                    ),
                  ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          height: 453,
          width: 350,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(22),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                  padding: EdgeInsets.all(23),
                  child: Text(
                    '${passvalue.description}',
                    style: TextStyle(color: Colors.black, fontSize: 22.0),
                  )),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 320,
                      height: 60.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: ElevatedButton(
                          onPressed: () {
                            _showeditaddtaskForm(context,
                                passvalue: passvalue, passindex: passindex);
                          },
                          child: Text(
                            'Edit',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1),
                          ),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue[600],
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)))),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
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
      height: MediaQuery.of(context).size.height * 0.70,
      child: edit_taskform(
        passvalue: passvalue,
        passindex: passindex,
      ),
    ),
  );
}
