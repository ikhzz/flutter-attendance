import 'package:firebase_auth/firebase_auth.dart';
import 'package:attendance_app2/models/user.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthService {
  
  
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseDatabase _db = FirebaseDatabase.instance;
  
  String levels;
  AuthService()  {
    Firebase.initializeApp();
  }
  // Extract uid
  AppUser _uidUser(User user, String lv) {
    return user != null ? AppUser(uid: user.uid, level: lv) : null;
  }

  // Sign in
  Future signIn(String email, String pass) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: pass);
      await level(result.user.uid);
      return _uidUser(result.user, levels);
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
  Stream<AppUser> get user{
    return _auth.authStateChanges()
            .map((User user) => _uidUser(user, this.levels));
  }

  // Extract level
  Future level(String uid) async {
    await _db.reference()
    .child('profile/$uid/level')
    .once()
    .then((snapshot) => levels = snapshot.value);
  }
}