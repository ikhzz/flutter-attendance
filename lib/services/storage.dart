import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';

class StorageService {

  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  // Get Profile Picture
  Future<dynamic> getprofile() async{
     try{
       dynamic url = await _storage.ref('images').child('profile/${_auth.currentUser.uid}').getDownloadURL();
       if(url == null){
         return null;
       }else {
         return url;
       }
     }catch(e){
       return null;
     }
  }

  // GetImage
  Future<String> getImage(date,day,id) async {
    String url = await _storage.ref('presence').child('$date/$day/$id').getDownloadURL();
    return url;
  }

  Future sendAvatar(String path) async {
    File file = File(path);

    try{
      await _storage.ref('images').child('profile/${_auth.currentUser.uid}').putFile(file);
      String url = await _storage.ref('images').child('profile/${_auth.currentUser.uid}').getDownloadURL();
      return url;
    } catch(e) {
      return null;
    }
  }

  Future setImage() async{
    PickedFile file = await ImagePicker().getImage(source: ImageSource.gallery);
    String url = await sendAvatar(file.path);
    return url;
  }
}