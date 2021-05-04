import 'dart:math';

import 'package:firebase_storage/firebase_storage.dart';

class Storage {
  var _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  Future<String> uploadImage(file, uid) async {
    String fileName = uid;
    StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('Profile').child(fileName);
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(file);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    var downUrl = await taskSnapshot.ref.getDownloadURL();
    String url = downUrl.toString();
    return url;
  }

  Future<String> uploadImageNotProfile(file) async {
    String fileName = getRandomString(23);
    StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('All').child(fileName);
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(file);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    var downUrl = await taskSnapshot.ref.getDownloadURL();
    String url = downUrl.toString();
    return url;
  }
}
