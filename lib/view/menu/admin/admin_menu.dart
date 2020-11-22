import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:attendance_app2/services/auth.dart';
import 'package:ntp/ntp.dart';

class AdminMenu extends StatefulWidget {
  @override
  _AdminMenuState createState() => _AdminMenuState();
}

class _AdminMenuState extends State<AdminMenu> {

  final AuthService _auth = AuthService();
  
  String _date;
  String _time;
  DatabaseReference _ref;
  
  void getTime() async {
    DateTime date = await NTP.now();
    setState(() {
      String z = '0';
      String day = date.day.toString().length < 2 ? z+date.day.toString(): date.day.toString();
      String month = date.month.toString().length < 2 ? z+date.month.toString(): date.month.toString();
      String hour = date.hour.toString().length < 2 ? z+date.hour.toString(): date.hour.toString();
      String minute = date.minute.toString().length < 2 ? z+date.minute.toString(): date.minute.toString();
      
      _date = '$day-$month-${date.year}';
      _time = '$hour-$minute';
      _ref = _auth.db.reference().child('presence/$_date/Pagi');
    });
    
  }

  @override
  void initState(){
    super.initState();
    getTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Menu'),
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
                child: CircleAvatar()
              ),
              ListTile(
                leading: Icon(Icons.contact_page),
                title: Text('Tambah Pengguna'),
              ),
              ListTile(
                leading: Icon(Icons.lock_open),
                title: Text('Lupa Password'),
              ),
              ListTile(
                leading: Icon(Icons.analytics),
                title: Text('History Absen'),
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
        alignment: Alignment.center,
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
            Flexible(
              child: FirebaseAnimatedList(
                query: _ref,
                itemBuilder: (context, snapshot, animation, index) {
                  return Card(
                    child: Column(
                      children: [
                        Text('tes'),
                        Text(snapshot.value['name']?? 'tes')
                      ],
                    ) 
                  );
                },
              )
            ),
          ],
        ),
      ),
    );
  }
}