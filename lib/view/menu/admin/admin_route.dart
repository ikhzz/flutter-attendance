import 'package:attendance_app2/view/menu/admin/admin_menu.dart';
import 'package:attendance_app2/view/menu/admin/history.dart';
import 'package:attendance_app2/view/menu/admin/register.dart';
import 'package:attendance_app2/view/menu/admin/resetpass.dart';
import 'package:flutter/material.dart';

class AdminRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/history',
      routes: {
        '/': (context) => AdminMenu(),
        '/register': (context) => Register(),
        '/resetpass': (context) => ResetPass(),
        '/history': (context) => History()
      },
    );
  }
}