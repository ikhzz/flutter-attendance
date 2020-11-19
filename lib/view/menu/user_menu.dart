import 'package:attendance_app2/services/auth.dart';
import 'package:flutter/material.dart';

class UserMenu extends StatelessWidget {

  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: RaisedButton(
            onPressed: () async{
              await _auth.signOut();
            },
          ),
        ),
    );
  }
}