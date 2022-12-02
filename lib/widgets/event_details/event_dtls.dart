import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:todo_app/widgets/common_widgets/common_text.dart';
import 'package:todo_app/widgets/events_edit/events_edit.dart';

class Eventdtls extends StatelessWidget {
  Eventdtls({
    super.key,
    required this.passvalue,
  });
  var passvalue;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: <Widget>[
            Hero(
                tag: Image.file(
                  File(passvalue.image),
                  //   fit: BoxFit.cover,
                ),
                child: Container(
                  height: 350,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: FileImage(
                            File(passvalue.image),
                          ),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.elliptical(50, 40),
                          bottomRight: Radius.elliptical(50, 40))),
                )),
            Positioned(
              top: 30,
              left: 10,
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
            Positioned(
              top: 240.0,
              //bottom: 10,
              left: 30,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    texts(
                        mystring: '${passvalue.title}',
                        myfontsize: 38,
                        mycolor: Colors.white,
                        fontweight: FontWeight.w600),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_month_rounded,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          DateFormat("dd  MMM,  yyy ").format(passvalue.date),
                          //  data.date.toString(),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 16.0),
                        ),
                      ],
                    ),
                  ]),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 18.0, top: 38.0),
          child: Row(
            children: const [
              Icon(Icons.location_on_outlined),
              texts(
                  mystring: 'Location',
                  myfontsize: 20.0,
                  mycolor: Color.fromARGB(213, 60, 5, 73),
                  fontweight: FontWeight.bold),
            ],
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 39.0,
          ),
          child: texts(
              mystring: passvalue.location,
              myfontsize: 26,
              mycolor: Colors.black,
              fontweight: FontWeight.w800),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 28.0, top: 38.0),
          child: Row(
            children: const [
              texts(
                  mystring: 'About ',
                  myfontsize: 20.0,
                  mycolor: Color.fromARGB(213, 60, 5, 73),
                  fontweight: FontWeight.bold),
            ],
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 39.0,
          ),
          child: texts(
              mystring: passvalue.description,
              myfontsize: 21.0,
              mycolor: Colors.black,
              fontweight: FontWeight.w500),
        ),
      ],
    );
  }
}
       
       
          //  mainAxisAlignment: MainAxisAlignment.spaceAround,
         
          
           
            // texts(
            //     mystring: '${passvalue.description}',
            //     myfontsize: 28.0,
            //     mycolor: Colors.white,
            //     fontweight: FontWeight.w500),
            
    
      
       
            // Padding(
            //   padding: const EdgeInsets.all(18),
            //   child: FloatingActionButton(
            //     backgroundColor: Colors.black,
            //     onPressed: () {
            //       _showedieventtaskForm(
            //         context,
            //         passvalue: passvalue,
            //       );
                

// void _showedieventtaskForm(BuildContext context, {required passvalue}) {
//   showModalBottomSheet(
//     backgroundColor: Colors.transparent,
//     isDismissible: false,
//     isScrollControlled: true,
//     context: context,
//     builder: (_) => Container(
//       decoration: const BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(25.0),
//           topRight: Radius.circular(25.0),
//         ),
//       ),
//       height: MediaQuery.of(context).size.height * 0.73,
//       child: events_edit(passvalue: passvalue),
//     ),
//   );
// }
 