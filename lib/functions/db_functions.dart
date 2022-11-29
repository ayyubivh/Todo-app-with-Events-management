import 'package:flutter/foundation.dart';
import 'package:hive_flutter/adapters.dart';

import '../models/data_model.dart';

//********************************Addtask Functions*********************************************************** */
ValueNotifier<List<TodoModel>> todolistnotifier = ValueNotifier([]);

Future<void> addtask(TodoModel value) async {
  final todoeventDB = await Hive.openBox<TodoModel>('todo_task_db');
  final _id = await todoeventDB.add(value);
  value.id = _id;
  todolistnotifier.value.add(value);
  todolistnotifier.notifyListeners();
}

Future<void> getAllTodotask() async {
  final todotaskDB = await Hive.openBox<TodoModel>('todo_task_db');
  todolistnotifier.value.clear();

  todolistnotifier.value.addAll(todotaskDB.values);
  todolistnotifier.notifyListeners();
}

Future<void> deleteAllTodotask(int id) async {
  final todotaskDB = await Hive.openBox<TodoModel>('todo_task_db');
  await todotaskDB.deleteAt(id);
  getAllTodotask();
}

//********************************AddEvent Functions*********************************************************** */
ValueNotifier<List<TodoEvent>> todolisteventnotifier = ValueNotifier([]);

Future<void> addevent(TodoEvent value) async {
  final todotasktDB = await Hive.openBox<TodoEvent>('todo_Event_db');
  final _id = await todotasktDB.add(value);
  value.id = _id;
  todolisteventnotifier.value.add(value);
  todolisteventnotifier.notifyListeners();
}

Future<void> getAllTodoEvent() async {
  final todoEventDB = await Hive.openBox<TodoEvent>('todo_Event_db');
  todolisteventnotifier.value.clear();

  todolisteventnotifier.value.addAll(todoEventDB.values);
  todolisteventnotifier.notifyListeners();
}

Future<void> deleteAllTodoevent(int id) async {
  final todoEventDB = await Hive.openBox<TodoEvent>('todo_Event_db');
  await todoEventDB.deleteAt(id);
  getAllTodoEvent();
}
