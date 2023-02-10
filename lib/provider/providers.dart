import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo_app/models/data_model.dart';

final imagaProvider = StateProvider.autoDispose(((ref) => ''));
final dateProvider = StateProvider<DateTime>(((ref) => DateTime.now()));
final timeProvider = StateProvider<DateTime>((ref) => DateTime.now());
final titleControllers =
    StateProvider.autoDispose<TextEditingController>((ref) {
  return TextEditingController();
});
final myIndex = StateProvider((ref) => 0);
final pageProvider = StateProvider.autoDispose<int>((ref) => 0);
final selectedDays = StateProvider((ref) => DateTime.now());
final focusedDays = StateProvider((ref) => DateTime.now());
final todolisteventnotifiers = StateProvider((ref) => List<TodoEvent>);
final calenderFormaProvider =
    StateProvider<CalendarFormat>((ref) => CalendarFormat.month);
