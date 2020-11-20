import 'package:attendance_app2/models/user.dart';
import 'package:attendance_app2/services/auth.dart';
import 'package:attendance_app2/view/other/loading.dart';
import 'package:flutter/material.dart';
import 'package:attendance_app2/view/route.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final Future<FirebaseApp> _initialization = Firebase.initializeApp();
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot){
        if (snapshot.connectionState == ConnectionState.done) {
          return StreamProvider<AppUser>.value(
            value: AuthService().user,
            child: MaterialApp(
              home: AppRoutes(),
            ),
          );
        }
        return MaterialApp(
          home: Loading(),
        );
      },
    );
  }
}

