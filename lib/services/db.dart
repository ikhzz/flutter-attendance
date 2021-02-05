import 'dart:io';
import 'dart:async';
import 'package:attendance_app2/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:ntp/ntp.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';

class DbService {

  final FirebaseDatabase _db = FirebaseDatabase.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final AuthService _service = AuthService();

  // Get Query
  Future<List<dynamic>> ref() async {
    List list = await getTime();
    Query ref = _db.reference().child('presence/${list[0]}/${list[2]}');
    return [ref, list[0], list[2]];
  }

  // Get Time Now
  Future<List<dynamic>> getTime() async {
    // Get date online
    DateTime date = await NTP.now();

    // Build date string
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

  Future checkPos() async {
    LocationPermission permission = await Geolocator.checkPermission();
    List date = await getTime();
    
    // Check date
    if(date[2] == null){
      return 'Bukan jam absen';
    } else {
      if(permission == LocationPermission.always || permission == LocationPermission.whileInUse){
        // Get position
        Position pos = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
        // Coordinate
        List poslat = [-0.9018800, -0.9015434];
        List poslong = [119.8861482, 119.8867071];
        // Testing coordinate
        List testPoslat = [-0.9025771, -0.9021997];
        List testPoslong = [119.8712618, 119.8716238];
        // Check location latitude & longitude
        if(pos.latitude > testPoslat[0]  && pos.latitude < testPoslat[1] && pos.longitude <  testPoslong[1] && pos.longitude > testPoslong[0]){
          var a = await ImagePicker().getImage(source: ImageSource.camera);
          if(a == null){
            return 'Gagal mengambil gambar';
          } else {
            var result = await sendData(a.path, date[0], date[1], date[2]);
            if(result == false){
              return 'Absen Gagal dikirim';
            } else {
              return 'Absen telah dikirim';
            }
          }
        } else{
          return 'Tidak di area absen';
        }
      } else if(permission == LocationPermission.denied){
        await Geolocator.requestPermission();
      } else{
        return 'Permisi Lokasi Ditolak';
      }
    }
  }

  Future sendData(String path, String date, String time, String day)async{
    FirebaseStorage _storage = FirebaseStorage.instance;
    File file = File(path);
    List list = await _service.getDetail();
    try{
      await _storage.ref('presence').child('$date/$day/${_auth.currentUser.uid}').putFile(file);
      await _db.reference().child('presence/$date/$day/${_auth.currentUser.uid}').set({
        'name' : list[1],
        'time' : time,
      });
      return true;
    } catch(e){
      return false;
    }
  }
}