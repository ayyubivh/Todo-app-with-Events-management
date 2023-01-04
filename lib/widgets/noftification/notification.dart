import 'dart:async';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/functions/db_functions.dart';
import 'package:todo_app/widgets/home_widgets/home_tasklist_section.dart';

import '../home_widgets/home_eventlist.dart';

void notify({required String title, required DateTime body}) async {
  await AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: 1,
          channelKey: 'task',
          title: title,
          body: DateFormat('hh:mm a').format(body)));
}

checkTimeNotification() {
  Timer.periodic(Duration(seconds: 5), (timer) {
    DateTime datetimeNow = DateTime.now();
    if (DateTime(notifytime.year, notifytime.month, notifytime.day,
            notifytime.hour, notifytime.minute) ==
        (DateTime(datetimeNow.year, datetimeNow.month, datetimeNow.day,
            datetimeNow.hour, datetimeNow.minute))) {
      notify(title: notifydata!.title, body: notifydata!.date);
      getAllTodotask();
    }
  });
}

checkTimeNotificationEvent() {
  Timer.periodic(Duration(seconds: 5), (timer) {
    DateTime datetimeNow = DateTime.now();
    if (DateTime(notifytime.year, notifytime.month, notifytime.day,
            notifytime.hour, notifytime.minute) ==
        (DateTime(datetimeNow.year, datetimeNow.month, datetimeNow.day,
            datetimeNow.hour, datetimeNow.minute))) {
      notify(title: notifydataEvnt!.title, body: notifydataEvnt!.date);
      getAllTodoEvent();
    }
  });
}
