import 'package:firebase_auth/firebase_auth.dart';
import 'package:attendance_app2/models/user.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:ntp/ntp.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AuthService {
  
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseDatabase db = FirebaseDatabase.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;
  
  
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

  // Query level
  Future level(String uid) async {
    return await db.reference()
    .child('profile/$uid/level')
    .once()
    .then((snapshot) => snapshot.value);
  }

  Future<Query> ref() async {
    List list = await getTime();
    Query ref = db.reference().child('presence/${list[0]}/Siang');
    return ref;
  }

  Future<List<String>> getTime() async {
    DateTime date = await NTP.now();
    String z = '0';
    String day = date.day.toString().length < 2 ? z+date.day.toString(): date.day.toString();
    String month = date.month.toString().length < 2 ? z+date.month.toString(): date.month.toString();
    String hour = date.hour.toString().length < 2 ? z+date.hour.toString(): date.hour.toString();
    String minute = date.minute.toString().length < 2 ? z+date.minute.toString(): date.minute.toString();
    
    String dates = '$day-$month-${date.year}';
    String time = '$hour:$minute';
    
    return [dates,time];
  }
}