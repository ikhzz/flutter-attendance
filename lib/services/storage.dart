import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class StorageService {

  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  // Get Profile Picture
  Future<String> getprofile() async{
     String url = await _storage.ref('images').child('profile/${_auth.currentUser}').getDownloadURL();
     return url;
  }

  // GetImage
  Future<String> getImage(date,day,id) async {
    String url = await _storage.ref('presence').child('$date/$day/$id').getDownloadURL();
    return url;
  }
}