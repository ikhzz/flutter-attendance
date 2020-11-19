import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor : Color.fromRGBO(117, 121, 231, 1),
      body: Container(
        alignment: Alignment.center,
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "ABSENSI PEGAWAI BKPSDMD",
                style: TextStyle(
                  color: Colors.white),
                ),
              SizedBox(height: 30.0),
              Text(
                'Halaman Login',
                style: TextStyle(
                  color: Colors.white),
                ),
              SizedBox(height: 40.0),
              Container(
                width: 200.0,
                child: TextFormField()
                ),
              Container(
                width: 200.0,
                child: TextFormField()
                ),
              SizedBox(height: 20.0),
              RaisedButton(
                onPressed: null,
                color: Color.fromRGBO(154, 178, 245, 1),
                child: Text(
                  'Sign In', 
                  style: TextStyle(
                    color: Colors.white
                    ),
                  ),
                )
            ],),
          ),
      )
    );
  }
}