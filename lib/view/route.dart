import 'package:attendance_app2/models/user.dart';
import 'package:attendance_app2/services/auth.dart';
import 'package:attendance_app2/view/auth/sign_in.dart';
import 'package:attendance_app2/view/menu/admin/admin_route.dart';
import 'package:attendance_app2/view/menu/user/user_menu.dart';
import 'package:attendance_app2/view/other/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppRoutes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<AppUser>(context);
    final AuthService _auth = AuthService();
    if(user != null){
      return FutureBuilder(
        future: _auth.getDetail(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if(snapshot.data[0] == 'admin'){
              return AdminRoute();
            } else {
              return UserMenu();
            } 
          }
          return MaterialApp(
            home: Loading()
          );
        },
      );
    } else {
      return SignIn();
    }
  }
}