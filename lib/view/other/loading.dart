import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: Container(
          color: Colors.white,
          child: Center(
            child: SpinKitDoubleBounce(
            color: Colors.blue,
            size: 90.0,
          ),
        ),
      ),
    );
  }
}