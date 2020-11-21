import 'package:attendance_app2/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

class UserMenu extends StatelessWidget {

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
          Text('User_menu')
        ],
      ),
    );
  }
}