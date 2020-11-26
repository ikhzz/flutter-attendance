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
                  fontSize: 22.0,
                  color: Colors.white),
                ),
              SizedBox(height: 30.0),
              Text(
                'Halaman Login',
                style: TextStyle(
                  color: Colors.white),
                ),
              SizedBox(height: 35.0),
              Container(
                width: 220.0,
                height: 30.0,
                child: TextFormField(
                  validator: (val) => val.isEmpty ? 'Masukan Email Pegawai' : null,
                  onChanged: (val){ setState(() => email = val); },
                  decoration: InputDecoration(
                    hintText: 'Email Pegawai',
                    hintStyle: TextStyle(color: Colors.white.withOpacity(0.4)),
                  ),
                  style: TextStyle(color: Colors.white),  
                )
              ),
              SizedBox(height: 30.0),
              Container(
                width: 220.0,
                height: 30.0,
                child: TextFormField(
                  validator: (val) => val.length < 6 ? 'Masukan Password Lebih dari 6 karakter' : null,
                  onChanged: (val){ setState(() => pass = val); },
                  decoration: InputDecoration(
                    hintText: 'Password Pegawai',
                    hintStyle: TextStyle(color: Colors.white.withOpacity(0.4)),
                  ),
                  style: TextStyle(color: Colors.white),  
                  )
                ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () async{
                  if(_formkey.currentState.validate()) {
                    dynamic result = await _auth.signIn(email, pass);
                    if(result == null){
                      setState(() {
                        errMsg = "Email Atau Password Salah";
                      });
                    } else{
                      print('login');
                    }
                  }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(154, 178, 245, 1))
                ),
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
            ],
          ),
        ),
      )
    );
  }
}