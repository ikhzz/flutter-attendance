import 'package:attendance_app2/services/db.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {

  final DbService _db = DbService();
  final DatabaseReference _dbs = FirebaseDatabase.instance.reference().child('presence');
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History Absen'),
      ),
      body: Container(
        child: FutureBuilder(
          future: _db.history(),
          builder: (context, snapshot){
            if(snapshot.connectionState == ConnectionState.done){
              //List list = snapshot.data.keys.toList();
              //snapshot.data.entries.forEach((e) => list.add(e.key));
              
              //return Text(snapshot.data.keys.single.toString());
              return Text(snapshot.data.toString());
              //return getw();
            }
            
            return Text('tess');
          },
        ),
      ),
    );
  }

  Widget getw() {
    List<String> list2 = ['a','b','c','d','e'];
    List<Widget> list = List<Widget>();
    for(var i = 0; i < 5; i++){
        list.add(Text(list2[i]));
    }
    return Column(children: list);
  }
}