import 'package:flutter/material.dart';
import 'package:attendance_app2/services/auth.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();

  String email = '';
  String pass = '';
  String errMsg = '';
  dynamic result;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor : Color.fromRGBO(117, 121, 231, 1),
      body: Container(
        alignment: Alignment.center,
        child: Form(
          key: _formkey,
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
                child: TextFormField(
                  validator: (val) => val.isEmpty ? 'Masukan Email Pegawai' : null,
                  onChanged: (val){ setState(() => email = val); },  
                  )
                ),
              Container(
                width: 200.0,
                child: TextFormField(
                  validator: (val) => val.length < 6 ? 'Masukan Password Lebih dari 6 karakter' : null,
                  onChanged: (val){ setState(() => pass = val); },
                  )
                ),
              SizedBox(height: 20.0),
              RaisedButton(
                onPressed: () async{
                  if(_formkey.currentState.validate()) {
                    result = await _auth.signIn(email, pass);
                    if(result == null){
                      setState(() {
                        errMsg = "Email dan Password Salah";
                      });
                    } else{
                      print('login');
                    }
                  }
                },
                color: Color.fromRGBO(154, 178, 245, 1),
                child: Text(
                  'Sign In', 
                  style: TextStyle(
                    color: Colors.white
                    ),
                  ),
                ),
              SizedBox(height: 5.0),
              Text(
                errMsg,
                style: TextStyle(
                  color: Colors.red, fontSize: 14.0
                ),
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                onPressed: ()async{
                  await _auth.level(result.uid);
                },
                color: Color.fromRGBO(154, 178, 245, 1),
                child: Text(
                  'Request', 
                  style: TextStyle(
                    color: Colors.white
                    ),
                  ),
                ),
              SizedBox(height: 20.0),
              RaisedButton(
                onPressed: () async {
                  await _auth.signOut();
                  },
                color: Color.fromRGBO(154, 178, 245, 1),
                child: Text(
                  'Sign Out', 
                  style: TextStyle(
                    color: Colors.white
                    ),
                  ),
                ),
            ],),
          ),
      )
    );
  }
}