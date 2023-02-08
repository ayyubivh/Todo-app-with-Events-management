import 'package:flutter/material.dart';
import 'package:todo_app/widgets/common_widgets/common_text.dart';
import 'package:todo_app/widgets/dasboardScreen.dart/tsk_dashboardList.dart';

class Screen_dashboard extends StatelessWidget {
  const Screen_dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: const [Expanded(child: DashboardLists())],
        ),
      ),
    );
  }
}
