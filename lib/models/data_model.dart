import 'package:hive/hive.dart';
part 'data_model.g.dart';

@HiveType(typeId: 1)
class TodoModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String description;

  @HiveField(3)
  DateTime date;

  @HiveField(4)
  final bool? priority;

  @HiveField(5)
  final bool? complete;
  TodoModel(
      {required this.id,
      required this.title,
      this.priority,
      required this.description,
      required this.date,
      required this.complete});
}

@HiveType(typeId: 2)
class TodoEvent {
  @HiveField(0)
  String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final DateTime date;

  @HiveField(4)
  final String image;

  @HiveField(5)
  final bool? priority;

  @HiveField(6)
  final String location;

  TodoEvent(
      {required this.title,
      this.priority,
      required this.location,
      required this.description,
      required this.date,
      required this.id,
      required this.image});
}
