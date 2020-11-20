import 'package:flutter/material.dart';
import 'package:attendance_app2/services/auth.dart';
import 'package:firebase_core/firebase_core.dart';

class AdminMenu extends StatefulWidget {
  @override
  _AdminMenuState createState() => _AdminMenuState();
}

class _AdminMenuState extends State<AdminMenu> {

  final AuthService _auth = AuthService();
  final Future<FirebaseApp> defaultapp = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RaisedButton(
              onPressed: () async{
                await _auth.signOut();
              },
            ),
          Text('Admin Menu')
        ],
      ),
    );
  }
}