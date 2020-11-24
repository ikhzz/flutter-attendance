import 'package:flutter/material.dart';

class Preview extends StatelessWidget {
  final String data;
  Preview({this.data});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: (){
          Navigator.pop(context);
        },
        child: Center(
          child: Image.network(data),
        ),
      ),
    );
  }
}