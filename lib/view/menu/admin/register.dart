import 'package:attendance_app2/services/auth.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();

  String email;
  String pass;
  String name;
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Halaman Daftar'),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              Row(
                children:[
                  TextFormField(
                    validator: (val) => val.isEmpty ? 'Masukan Email Pegawai' : null,
                    onChanged: (val){setState(()=> email = val);},
                    decoration: InputDecoration(
                      hintText: 'Email Pegawai',
                    ),
                  ),
                  TextFormField(
                    validator: (val) => val.length < 6 ? 'Masukan Password Pegawai' : null,
                    onChanged: (val){setState(()=> pass = val);},
                    decoration: InputDecoration(
                      hintText: 'Password Pegawai',
                    ),
                  ),
                ]
              ),
              TextFormField(
                validator: (val) => val.isEmpty ? 'Masukan Nama Pegawai' : null,
                onChanged: (val){setState(()=> name = val);},
                decoration: InputDecoration(
                      hintText: 'Nama Pegawai',
                    ),
              ),
              RaisedButton(
                onPressed: ()async{
                  if(_formkey.currentState.validate()){
                    dynamic result = _auth.register(email, pass, name);
                    if(result != null){
                      Navigator.pop(context);
                    }
                  }
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
}