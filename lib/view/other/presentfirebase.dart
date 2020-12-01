import 'package:flutter/material.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:attendance_app2/services/db.dart';
import 'package:attendance_app2/services/storage.dart';
import 'package:attendance_app2/view/other/preview.dart';

class PresentFirebase extends StatefulWidget {
  @override
  _PresentFirebaseState createState() => _PresentFirebaseState();
}

class _PresentFirebaseState extends State<PresentFirebase> {

  final DbService _db = DbService();
  final StorageService _storage = StorageService();
  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _db.ref(),
      builder: (context,snapshot){
        if(snapshot.data != null){
          return Flexible(
            child: FirebaseAnimatedList(
              query: snapshot.data[0],
              itemBuilder: (context, snapshots, animation, index){
                return Card(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        FutureBuilder(
                          future: _storage.getImage('${snapshot.data[1]}', '${snapshot.data[2]}', snapshots.key),
                          builder: (context, snapshotss) {
                            if(snapshotss.data != null){
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: GestureDetector(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (_){
                                      return Preview(data: snapshotss.data);
                                    }));
                                  },
                                    child: Image(
                                      image: NetworkImage(snapshotss.data),
                                      height: 100.0,
                                    ),
                                ),
                              );
                            }
                            return CircleAvatar(
                              radius: 40.0,
                            );
                          },
                        ),
                        SizedBox(width: 20.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Nama            : ${snapshots.value['name']}'),
                            SizedBox(height:15.0),
                            Text('Jam Absen   : ${snapshots.value['time']}'),
                          ],
                        ),
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
    );
  }
}