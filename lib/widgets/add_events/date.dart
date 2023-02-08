import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/util/app_color.dart';

import '../../provider/providers.dart';

DateTime dateTime = DateTime.now();

class DateField extends StatelessWidget {
  DateField({super.key});
  final dateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (BuildContext context, WidgetRef ref, child) {
      ref.watch(dateProvider.notifier);
      return TextField(
        controller: dateController,
        style: TextStyle(color: Fcolor),
        decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.calendar_month,
            color: Colors.grey,
          ),
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
          hintText: 'Date',
          hintStyle: const TextStyle(
              letterSpacing: 1,
              color: Colors.grey,
              fontSize: 15.0,
              fontWeight: FontWeight.w700),
        ),
        readOnly: true,
        onTap: () async {
          final date = await pickDate(context);

          if (date == null) return;
          final newDateTime = DateTime(
              date.year, date.month, date.day, dateTime.hour, dateTime.minute);
          dateTime = ref.read(dateProvider.notifier).state = newDateTime;
          dateController.text = DateFormat("y MMM d ").format(dateTime);
        },
      );
    });
  }
}

Future<DateTime?> pickDate(context) => showDatePicker(
    context: context,
    initialDate: dateTime,
    firstDate: DateTime(1900),
    lastDate: DateTime(2500));
