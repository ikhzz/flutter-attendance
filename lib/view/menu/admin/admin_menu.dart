import 'package:attendance_app2/services/db.dart';
import 'package:attendance_app2/services/storage.dart';
import 'package:flutter/material.dart';
import 'package:attendance_app2/services/auth.dart';
import 'package:attendance_app2/view/other/presentfirebase.dart';

class AdminMenu extends StatefulWidget {
  @override
  _AdminMenuState createState() => _AdminMenuState();
}

class _AdminMenuState extends State<AdminMenu> {

  final AuthService _auth = AuthService();
  final DbService _db = DbService();
  final StorageService _storage = StorageService();
  final _scaffold = GlobalKey<ScaffoldState>();
  
  String _date;
  String _time;
  String _dates;
  dynamic _image;
  dynamic _datanow;
  
  void getInit() async {
    // get current time
    List date = await _db.getTime();
    // get profil
    dynamic url = await _storage.getprofile();
    // check if data exist in current time
    dynamic now = await _db.dataNow();

    setState(() {
      _datanow = now;
      _image = url;
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
      key: _scaffold,
      appBar: AppBar(
        title: Text('Menu Admin'),
      ),
      drawer: Container(
        width: 220.0,
        child: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: _image == null ? GestureDetector(
                  onTap: ()async{
                    var url = await _storage.setImage();
                    if(url != null){
                      setState(() {
                        _image = url;
                      });
                    }
                  },
                  child: CircleAvatar()
                  ) 
                  : GestureDetector(
                    onTap: ()async{
                      var url = await _storage.setImage();
                      if(url != null){
                        setState(() {
                          _image = url;
                        });
                        return nyam('Foto Profil Telah Dirubah');
                      } else {
                        return nyam('Foto Profil Gagal Dirubah');
                      }
                    },
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(_image)
                    ),
                  ),
              ),
              ListTile(
                leading: Icon(Icons.contact_page),
                title: Text('Tambah Pengguna'),
                onTap: () async {
                  Navigator.of(context).pop();
                  var result = await Navigator.pushNamed(context, '/register');
                  nyam(result);
                },
              ),
              ListTile(
                leading: Icon(Icons.lock_open),
                title: Text('Lupa Password'),
                onTap: (){
                  Navigator.of(context).pop();
                  Navigator.pushNamed(context, '/resetpass');
                },
              ),
              ListTile(
                leading: Icon(Icons.analytics),
                title: Text('History Absen'),
                onTap: (){
                  Navigator.of(context).pop();
                  Navigator.pushNamed(context, '/history');
                },
              ),
              ListTile(
                leading: Icon(Icons.logout),
                title: Text('Log Out'),
                onTap: () async {
                  await _auth.signOut();
                },
              ),
            ],
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: Container(
        //alignment: Alignment.center,
        child: Column(
          children: [
            SizedBox(height: 5.0),
            Text('Admin Menu'),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(_time ?? 'Jam'),
                SizedBox(width: 40.0),
                Text(_date ?? 'Tanggal'),
              ],
            ),
            SizedBox(height: 20.0),
            Text(_dates ?? 'Bukan Jam Absen'),
            SizedBox(height: 20.0),
            _datanow == null ? Text('Belum Ada Data Hari ini') 
            : PresentFirebase()
          ],
        ),
      ),
    );
  }

  void nyam(String msg){
    _scaffold.currentState.showSnackBar(SnackBar(content:Text(msg)));
  }
}