import 'package:attendance_app2/models/user.dart';
import 'package:attendance_app2/view/auth/sign_in.dart';
import 'package:attendance_app2/view/menu/admin/admin_route.dart';
import 'package:attendance_app2/view/menu/user/user_menu.dart';
import 'package:attendance_app2/view/other/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:attendance_app2/services/db.dart';

class AppRoutes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<AppUser>(context);
    final DbService _db = DbService();
    if(user != null){
      return FutureBuilder(
        future: _db.level(user.uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if(snapshot.data == 'admin'){
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