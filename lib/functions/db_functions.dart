import 'package:flutter/foundation.dart';
import 'package:hive_flutter/adapters.dart';

import '../models/data_model.dart';

ValueNotifier<List<TodoModel>> todolistnotifier = ValueNotifier([]);
ValueNotifier<List<TodoEvent>> todolisteventnotifier = ValueNotifier([]);
Future<void> addtask(TodoModel value) async {
  final todotasktDB = await Hive.openBox<TodoModel>('todo_task_db');
  final _id = await todotasktDB.add(value);
  value.id = _id;
  todolistnotifier.value.add(value);
  todolistnotifier.notifyListeners();
}

void addevent(TodoEvent value) {
  todolisteventnotifier.value.add(value);
  todolisteventnotifier.notifyListeners();
}

Future<void> getAllTodotask() async {
  final todotaskDB = await Hive.openBox<TodoModel>('todo_task_db');
  todolistnotifier.value.clear();

  todolistnotifier.value.addAll(todotaskDB.values);
  todolistnotifier.notifyListeners();
}

Future<void> deleteAllTodotask(int id) async {
  final todotaskDB = await Hive.openBox<TodoModel>('todo_task_db');
  await todotaskDB.delete(id);
  getAllTodotask();
}
