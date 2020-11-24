import 'package:ntp/ntp.dart';
import 'package:firebase_database/firebase_database.dart';

class DbService {

  final FirebaseDatabase _db = FirebaseDatabase.instance;

  // Get Level 
  Future level(String uid) async {
    return await _db.reference()
    .child('profile/$uid/level')
    .once()
    .then((snapshot) => snapshot.value);
  }

  // Get Query
  Future<Query> ref() async {
    List list = await getTime();
    Query ref = _db.reference().child('presence/${list[0]}/Siang');
    return ref;
  }

  // Get Time Now
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

  Future createUser(String id, String name) async {
    if(id != null) {
      await _db.reference().child('profile').child(id).set({
        'name': name,
        'lavel': 'user'
      });
    }
  }
}