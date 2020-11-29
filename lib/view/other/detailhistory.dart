import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class DetailHistory extends StatefulWidget {
  @override
  _DetailHistoryState createState() => _DetailHistoryState();
}

class _DetailHistoryState extends State<DetailHistory> {
  
  List list = List();
  FirebaseDatabase _db = FirebaseDatabase.instance;

  @override
  Widget build(BuildContext context) {
    list = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail History'),
      ),
      body: Column(
        children: [
          Flexible(
            child: FirebaseAnimatedList(
              query: _db.reference().child('presence/${list[0]}/${list[1]}'),
              itemBuilder: (context, snapshot, animation, index) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // add future builder for image and use preview to see image
                        Text('Nama: ${snapshot.value['name']}'),
                        SizedBox(height: 10.0,),
                        Text('Waktu: ${snapshot.value['time']}'),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}