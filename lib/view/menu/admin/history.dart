import 'package:attendance_app2/services/db.dart';
import 'package:flutter/material.dart';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {

  final DbService _db = DbService();
  
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
          // add Gesture Detector
          result.add(
            Container(
              width: 500,
              child: GestureDetector(
                onTap: (){
                  Navigator.pushNamed(context, '/detail', arguments: [list[i][0], list[i][1][j]]);
                },
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text('Tanggal: ${list[i][0]}'),
                        SizedBox(height: 10.0,),
                        Text('Bagian: ${list[i][1][j]}')
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }
    }
    return Column(children: result,);
  }
}