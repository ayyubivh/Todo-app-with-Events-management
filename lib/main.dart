import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo_app/models/data_model.dart';

import 'package:todo_app/presentation/screen_splash.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Hive.initFlutter();
  if (!Hive.isAdapterRegistered(TodoModelAdapter().typeId)) {
    Hive.registerAdapter(TodoModelAdapter());
  }

  if (!Hive.isAdapterRegistered(TodoEventAdapter().typeId)) {
    Hive.registerAdapter(TodoEventAdapter());
  }
  AwesomeNotifications().initialize(null, [
    NotificationChannel(
        channelKey: 'task',
        channelName: 'Proto Coders Point',
        channelDescription: "Notification example",
        defaultColor: Colors.blue,
        ledColor: Colors.white,
        playSound: true,
        // soundSource: '')
        enableLights: true,
        enableVibration: true),
  ]);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.black,
        fontFamily: GoogleFonts.notoSans().fontFamily,
      ),
      debugShowCheckedModeBanner: false,
      home: Screen_splash(),
    );
  }
}
