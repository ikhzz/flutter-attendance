import 'package:attendance_app2/services/auth.dart';
import 'package:attendance_app2/services/db.dart';
import 'package:attendance_app2/services/storage.dart';
import 'package:flutter/material.dart';

class UserMenu extends StatefulWidget {
  @override
  _UserMenuState createState() => _UserMenuState();
}

class _UserMenuState extends State<UserMenu> {

  final AuthService _auth = AuthService();
  final DbService _db = DbService();
  final StorageService _storage = StorageService();
  final _scaffold = GlobalKey<ScaffoldState>();

  String _date;
  String _time;
  String _dates;
  String _username;
  String _email;
  dynamic _image;

  void getInit()async{
    List date = await _db.getTime();
    List name = await _auth.getDetail();
    dynamic url = await _storage.getprofile();

    setState(() {
      _date = date[0];
      _time = date[1];
      _dates = date[2];
      _username = name[1];
      _email = name[2];
      _image = url;
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
      key: _scaffold,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: _image == null ? GestureDetector(
            onTap: ()async{
              var url = await _storage.setImage();
              if(url != null){
                setState(() {
                  _image = url;
                });
              }
            },
            child: CircleAvatar(),
          ): GestureDetector(
            onTap: ()async{
              var url = await _storage.setImage();
              if(url != null){
                setState(() {
                  _image = url;
                });
              }
            },
            child: CircleAvatar(
              backgroundImage: NetworkImage(_image),
            ),
          )
        ),
        title: Text('Menu Pegawai'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout), 
            onPressed: ()async{await _auth.signOut();}
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 10.0),
          Text('Nama : ${_username ?? 'name'}'),
          SizedBox(height: 10.0),
          Text('Email : ${_email ?? 'email'}'),
          SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(_time ?? 'Jam'),
              SizedBox(width: 40.0),
              Text(_date ?? 'Tanggal'),
            ]
          ),
          SizedBox(height: 10.0),
          Text('Bagian Absen: ${_dates ?? 'Bukan Bagian Absen'}'),
          SizedBox(height: 50.0,),
          ElevatedButton(
            onPressed: ()async{
              var result = await _db.checkPos();
              nyam(result);
            }, 
            child: Text('Kirim Absen')
          ),
        ],
      ),
    );
  }

  void nyam(String msg){
    _scaffold.currentState.showSnackBar(SnackBar(content:Text(msg)));
  }  
}