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
  final FirebaseDatabase _dbs = FirebaseDatabase.instance;
  
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
              List list = [];
              dynamic result = snapshot.data;
              result[0].asMap().forEach((i,e){list.add([e,result[1][i]]);});
              return getw(list);
            }
            return Text('Mengambil Data');
          },
        ),
      ),
    );
  }

  Widget getw(List list) {
    List<Widget> result = List<Widget>();

    // loop from list total, 
    for(var i = 0; i < list.length; i++){
        // loop from inner list index 2
        for(var j=0; j < list[i][1].length; j++ ){
          // add flexible-Firebase animated list, query from list
          result.add(
            Flexible(
              child: FirebaseAnimatedList(
                query: _dbs.reference().child('presence/${list[i][0]}/${list[i][1][j]}'),
                itemBuilder: (context, snapshot, animation, index) {
                  // add future builder if need image proof
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          // FutureBuilder for image
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Tanggal: ${list[i][0]}'),
                              Text('Bagian: ${list[i][1][j]}')
                            ]
                          ),
                          SizedBox(width: 10.0,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Nama: ${snapshot.value['name']}'),
                              Text('Waktu: ${snapshot.value['time']}')
                            ]
                          )
                        ],
                      ),
                    ),
                  );
                  //Text('${snapshot.value['name']}');
                },
              ),
            ),
          );
        }
    }
    return Column(children: result);
  }
}