import 'package:firebase_auth/firebase_auth.dart';
import 'package:attendance_app2/models/user.dart';
import 'package:firebase_database/firebase_database.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseDatabase _db = FirebaseDatabase.instance;

  // Extract uid
  AppUser _uidUser(User user) {
    return user != null ? AppUser(uid: user.uid) : null;
  }

  // Sign in
  Future signIn() async {
    try {
      await _auth.signInWithEmailAndPassword(email: null, password: null);
      // return _uidUser(result.user)
    }catch(e) {
      print(e.toString());
      return null;
    }
  }

  // Register

  // Sign Out
  Future signOut() async {
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  // Stream

  // Extract level
  Future level() async {

  }
}