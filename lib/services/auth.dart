import 'package:attendance_app2/services/db.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:attendance_app2/models/user.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class AuthService {
  
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseDatabase _db = FirebaseDatabase.instance;

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

  // Reset Pass need verified email

  // Get User Detail
  Future getDetail()async{
    String level = await _db.reference().child('profile/${_auth.currentUser.uid}/level').once().then((value) => value.value);
    String userName = await _db.reference().child('profile/${_auth.currentUser.uid}/name').once().then((value) => value.value);
    String email = _auth.currentUser.email;
    return [level, userName, email];
  }
}