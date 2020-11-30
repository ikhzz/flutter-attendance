import 'package:attendance_app2/services/auth.dart';
import 'package:attendance_app2/services/db.dart';
import 'package:flutter/material.dart';

class UserMenu extends StatefulWidget {
  @override
  _UserMenuState createState() => _UserMenuState();
}

class _UserMenuState extends State<UserMenu> {

  final AuthService _auth = AuthService();
  final DbService _db = DbService();

  String _date;
  String _time;
  String _dates;

  void getInit()async{
    List date = await _db.getTime();

    setState(() {
      _date = date[0];
      _time = date[1];
      _dates = date[2];
    });
  }

  @override
  void initState(){
    super.initState();
    getInit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: CircleAvatar(),
        title: Text('Menu Pegawai'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout), 
            onPressed: ()async{await _auth.signOut();}
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 10.0),
          Text('Nama : tes'),
          SizedBox(height: 10.0),
          Text('Email : tes'),
          SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(_time ?? 'Jam'),
              SizedBox(width: 40.0),
              Text(_date ?? 'Tanggal'),
            ]
          ),
        ],
      ),
    );
  }
}