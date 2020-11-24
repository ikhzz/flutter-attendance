import 'package:flutter/material.dart';

class ResetPass extends StatefulWidget {
  @override
  _ResetPassState createState() => _ResetPassState();
}

class _ResetPassState extends State<ResetPass> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reset Pass'),
      ),
      body: Center(
        child: Text('Reset Pass')
      ),
    );
  }
}