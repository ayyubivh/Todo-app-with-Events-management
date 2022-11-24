import 'package:flutter/material.dart';

import '../widgets/edit_task/edit_taskform.dart';

class screen_edit extends StatelessWidget {
  const screen_edit({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Scaffold(
        body: ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(232, 26, 71, 148),
                    Color.fromARGB(232, 21, 79, 161),
                    Color.fromARGB(222, 4, 12, 67),
                    Color.fromARGB(218, 6, 61, 138),
                    Color.fromARGB(218, 5, 65, 148)
                  ],
                  begin: Alignment.bottomRight,
                  end: Alignment.topLeft,
                ),
              ),
              child: edit_taskform(),
            ),
          ],
        ),
      );
    });
  }
}
