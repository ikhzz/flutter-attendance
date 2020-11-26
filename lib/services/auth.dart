import 'package:attendance_app2/services/db.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:attendance_app2/models/user.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthService {
  
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseDatabase db = FirebaseDatabase.instance;
  
  
  
  // Extract uid
  AppUser _uidUser(User user) {
    return user != null ? AppUser(uid: user.uid) : null;
  }

  // Sign in
  Future signIn(String email, String pass) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: pass);
      return _uidUser(result.user);
    }catch(e) {
      return null;
    }
  }

  // Register
  Future<List<dynamic>> register(String email, String pass, String name) async {
    FirebaseApp app = await Firebase.initializeApp(
        name: 'Secondary', options: Firebase.app().options);
    try{
       UserCredential result = await FirebaseAuth.instanceFor(app: app).createUserWithEmailAndPassword(email: email, password: pass);
       await DbService().createUser(result.user.uid, name, pass);
       await app.delete();
       return [result.user.uid, 'Done'];
    }catch(e){
      await app.delete();
      return [null,e.toString()];
    }
  }

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
            .map((User user) => _uidUser(user));
  }

  // Reset Pass
  Future<bool> reset(String pass) async {
    try{
      //_auth.
      return true;
    } catch(e) {
      return false;
    }
  }
}