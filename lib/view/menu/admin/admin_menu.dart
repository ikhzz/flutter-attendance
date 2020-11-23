import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:attendance_app2/services/auth.dart';
import 'package:ntp/ntp.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AdminMenu extends StatefulWidget {
  @override
  _AdminMenuState createState() => _AdminMenuState();
}

class _AdminMenuState extends State<AdminMenu> {

  final AuthService _auth = AuthService();
  
  String _date;
  String _time;
  String _dates;
  
  void getTime() async {
    DateTime date = await NTP.now();
    
    setState(() {
      String z = '0';
      String day = date.day.toString().length < 2 ? z+date.day.toString(): date.day.toString();
      String month = date.month.toString().length < 2 ? z+date.month.toString(): date.month.toString();
      String hour = date.hour.toString().length < 2 ? z+date.hour.toString(): date.hour.toString();
      String minute = date.minute.toString().length < 2 ? z+date.minute.toString(): date.minute.toString();
      
      _date = '$day-$month-${date.year}';
      _time = '$hour:$minute';
      if(date.hour > 5 && date.hour < 11 ){
        _dates = 'Pagi';
      } else if(date.hour > 10 && date.hour < 14){
        _dates  = 'Siang';
      } else if(date.hour > 13 && date.hour < 19){
        _dates = 'Sore';
      }
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
            FutureBuilder(
              future: _auth.ref(),
              builder: (context,snapshot){
                if(snapshot.data != null){
                  return Flexible(
                    child: FirebaseAnimatedList(
                      query: snapshot.data,
                      itemBuilder: (context, snapshot, animation, index){
                        var ref = _auth.storage.ref('presence').child('09-11-2020/Siang/${snapshot.key}');
                        return Card(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Nama            : ${snapshot.value['name']}'),
                                SizedBox(height:15.0),
                                Text('Jam Absen   : ${snapshot.value['time']}'),
                                FutureBuilder(
                                  future: ref.getDownloadURL(),
                                  builder: (context, snapshot) {
                                    if(snapshot.data != null){
                                      return Image.network(snapshot.data);
                                    }
                                    return Text('tes');
                                  },
                                )
                              ],
                            ),
                          ) 
                        );
                      },
                    ),
                  );
                }
                return Text('Menggambil Data');
              },
            )
          ],
        ),
      ),
    );
  }
}