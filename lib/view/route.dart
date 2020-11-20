import 'package:attendance_app2/models/user.dart';
import 'package:attendance_app2/view/auth/sign_in.dart';
import 'package:attendance_app2/view/menu/admin_menu.dart';
import 'package:attendance_app2/view/menu/user_menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppRoutes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<AppUser>(context);

    if(user != null && user.level == 'admin'){
      return AdminMenu();
    } else if(user != null){
      
      
      return UserMenu();
    } else {
      return SignIn();
    }
  }
}