import 'dart:async';
import 'package:flutter/material.dart';

import 'package:sentry/sentry.dart';
import 'package:weight_loss_tracker/ui/todo_list.dart';

Future<void> main() async {
  await Sentry.init(
      (options) => options.dsn = '',
      appRunner: () {
    WidgetsFlutterBinding.ensureInitialized();
    runApp(MyApp());
  });
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weight Tracker',
      theme: new ThemeData(
        primaryColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(backgroundColor: Colors.white,elevation: 0.50),
      ),
      home: new TodoList(),
    );
  }
}
