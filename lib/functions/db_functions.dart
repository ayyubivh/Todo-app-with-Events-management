import 'package:flutter/foundation.dart';
import 'package:hive_flutter/adapters.dart';

import '../models/data_model.dart';

//********************************Addtask Functions*********************************************************** */
ValueNotifier<List<TodoModel>> todolistnotifier = ValueNotifier([]);

Future<void> addtask(TodoModel value) async {
  final todotaskDB = await Hive.openBox<TodoModel>('todo_task_db');
  final _id = await todotaskDB.add(value);
  // value.id = _id;
  todolistnotifier.value.add(value);
  todolistnotifier.notifyListeners();
}

Future<void> getAllTodotask() async {
  final todotaskDB = await Hive.openBox<TodoModel>('todo_task_db');
  todolistnotifier.value.clear();
  todolistnotifier.value.addAll(todotaskDB.values);
  todolistnotifier.notifyListeners();
}

// Future<void> refresh() async {
//   final _tasklist = await getAllTodotask();
// }

Future<void> deleteAllTodotask(String index) async {
  final todotaskDB = await Hive.openBox<TodoModel>('todo_task_db');
  final Map<dynamic, TodoModel> taskMap = todotaskDB.toMap();
  dynamic desiredKey;
  taskMap.forEach((key, value) {
    if (value.id == index) {
      desiredKey = key;
    }
  });
  await todotaskDB.delete(desiredKey);
  getAllTodotask();
}

editTask(index, context, TodoModel value) async {
  final taskDB = await Hive.openBox<TodoModel>('todo_task_db');
  final Map<dynamic, TodoModel> taskMap = taskDB.toMap();
  dynamic desiredKey;
  taskMap.forEach((key, value) {
    if (value.id == index) {
      desiredKey = key;
    }
  });
  taskDB.put(desiredKey, value);
  getAllTodotask();
  // Navigator.of(context).pop();
}

//********************************AddEvent Functions***********************************************************/
ValueNotifier<List<TodoEvent>> todolisteventnotifier = ValueNotifier([]);

Future<void> addevent(TodoEvent value) async {
  final todoeventDB = await Hive.openBox<TodoEvent>('todo_Event_db');
  final _id = await todoeventDB.add(value);
//  value.id = _id;
  todolisteventnotifier.value.add(value);
  todolisteventnotifier.notifyListeners();
}

Future<void> getAllTodoEvent() async {
  final todoEventDB = await Hive.openBox<TodoEvent>('todo_Event_db');
  todolisteventnotifier.value.clear();

  todolisteventnotifier.value.addAll(todoEventDB.values);
  todolisteventnotifier.notifyListeners();
}

Future<void> deleteAllTodoevent(String index) async {
  final todoEventDB = await Hive.openBox<TodoEvent>('todo_Event_db');
  final Map<dynamic, TodoEvent> taskMap = todoEventDB.toMap();
  dynamic desiredKey;
  taskMap.forEach((key, value) {
    if (value.id == index) {
      desiredKey = key;
    }
  });
  //await todotaskDB.delete(desiredKey);
  await todoEventDB.delete(desiredKey);
  getAllTodoEvent();
}

editevent(index, context, TodoEvent value) async {
  final todoDB = await Hive.openBox<TodoEvent>('todo_Event_db');
  final Map<dynamic, TodoEvent> taskMap = todoDB.toMap();
  dynamic desiredKey;
  taskMap.forEach((key, value) {
    if (value.id == index) {
      desiredKey = key;
    }
  });
  todoDB.put(desiredKey, value);
  getAllTodoEvent();
  // Navigator.of(context).pop();
}
