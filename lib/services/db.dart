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
  Future<List<dynamic>> getTime() async {
    DateTime date = await NTP.now();
    String z = '0';
    String days;
    String day = date.day.toString().length < 2 ? z+date.day.toString(): date.day.toString();
    String month = date.month.toString().length < 2 ? z+date.month.toString(): date.month.toString();
    String hour = date.hour.toString().length < 2 ? z+date.hour.toString(): date.hour.toString();
    String minute = date.minute.toString().length < 2 ? z+date.minute.toString(): date.minute.toString();
    
    String dates = '$day-$month-${date.year}';
    String time = '$hour:$minute';

    if(date.hour > 5 && date.hour < 11 ){
        days = 'Pagi';
      } else if(date.hour > 10 && date.hour < 14){
        days  = 'Siang';
      } else if(date.hour > 13 && date.hour < 19){
        days = 'Sore';
    }
    
    return [dates, time, days];
  }

  Future createUser(String id, String name, String pass) async {
    if(id != null) {
      await _db.reference().child('profile').child(id).set({
        'name': name,
        'lavel': 'user',
        'pass' : pass
      });
    }
  }

  Future history() async {
    // prepare list
    List listdate = [];
    List listdatepart = [];

    // wait until all date is added to list
    // could try Firebaselist
    _db.reference()
      .child('presence')
      .orderByValue()
      .onChildAdded
      .listen((event) {
        listdate.add(event.snapshot.key);
        listdatepart.add(event.snapshot.value.keys.toList());
      });
    return [listdate,listdatepart];
  }

  Future dataNow()async{
    List list = await getTime();
    try{
      var result = await _db.reference().child('presence/${list[0]}/${list[2]}').once().then((value) => value.value);
      if(result == null){
        return null;
      } else {
        return 'Not null';
      }
    } catch(e){
      return null;
    }
  }
}