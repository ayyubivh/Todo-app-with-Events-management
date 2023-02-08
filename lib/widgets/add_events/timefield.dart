import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/provider/providers.dart';

import '../../util/app_color.dart';
import 'date.dart';

// ignore: prefer_typing_uninitialized_variables
DateTime? dbTime;

class TimeField extends StatelessWidget {
  TimeField({super.key});
  final timeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (BuildContext context, WidgetRef ref, child) {
      ref.watch(timeProvider.notifier);

      return TextField(
        controller: timeController,
        style: TextStyle(color: Fcolor),
        decoration: InputDecoration(
          prefixIcon:
              const Icon(Icons.watch_later_outlined, color: Colors.grey),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 2.0, color: Colors.blueGrey),
            borderRadius: BorderRadius.circular(16.0),
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none),
          filled: true,
          contentPadding: const EdgeInsets.all(15),
          fillColor: Colors.grey[200],
          hintText: 'Time',
          hintStyle: const TextStyle(
              letterSpacing: 1,
              color: Colors.grey,
              fontSize: 15.0,
              fontWeight: FontWeight.w700),
        ),
        readOnly: true,
        onTap: () async {
          final time = await pickTime(context);

          if (time == null) return;

          final newDateTime = DateTime(dateTime.year, dateTime.month,
              dateTime.day, time.hour, time.minute);
          dateTime = ref.read(timeProvider.notifier).state = newDateTime;
          timeController.text = DateFormat("hh:mm a").format(dateTime);
          print(dateTime);
        },
      );
    });
  }

  Future<TimeOfDay?> pickTime(ctx) => showTimePicker(
      context: ctx,
      initialTime: TimeOfDay(hour: dateTime.hour, minute: dateTime.minute));
}
