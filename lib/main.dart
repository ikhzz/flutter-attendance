import 'package:flutter/material.dart';
import 'package:attendance_app2/view/route.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AppRoutes(),
    );
  }
}

