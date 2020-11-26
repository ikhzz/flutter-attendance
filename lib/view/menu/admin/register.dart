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
  final _scaffold = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      key: _scaffold,
      appBar: AppBar(
        title: Text('Halaman Daftar'),
      ),
      body: Container(
        child: Form(
          key: _formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:[
                  Container(
                    width: 125.0,
                    child: TextFormField(
                      validator: (val) => val.isEmpty ? 'Masukan Email Pegawai' : null,
                      onChanged: (val){setState(()=> email = val);},
                      decoration: InputDecoration(
                        hintText: 'Email Pegawai',
                      ),
                    ),
                  ),
                  SizedBox(width: 20.0,),
                  Container(
                    width: 140.0,
                    child: TextFormField(
                      validator: (val) => val.length < 6 ? 'Masukan Password Pegawai' : null,
                      onChanged: (val){setState(()=> pass = val);},
                      decoration: InputDecoration(
                        hintText: 'Password Pegawai',
                      ),
                    ),
                  ),
                ]
              ),
              Container(
                width: 125.0,
                child: TextFormField(
                  validator: (val) => val.isEmpty ? 'Masukan Nama Pegawai' : null,
                  onChanged: (val){setState(()=> name = val);},
                  decoration: InputDecoration(
                        hintText: 'Nama Pegawai',
                      ),
                ),
              ),
              SizedBox(height: 20.0,),
              ElevatedButton(
                child: Container(
                  child: Text('Daftarkan Pegawai')),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(154, 178, 245, 1))
                ),
                onPressed: ()async{
                  if(_formkey.currentState.validate()){
                    List<dynamic> result = await _auth.register(email, pass, name);
                    if(result[0] != null){
                      Navigator.pop(context, 'Akun Dengan Email: $email dan Nama: $name Berhasil Dibuat');
                    } else {
                      nyam(result[1]);
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
  
  void nyam(String msg){
    _scaffold.currentState.showSnackBar(SnackBar(content:Text(msg)));
  }
}