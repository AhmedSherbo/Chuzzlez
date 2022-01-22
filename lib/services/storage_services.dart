import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:chuzzlez/providers/user_provider.dart';
import 'package:provider/provider.dart';

class StorageRepo {
  FirebaseStorage storage =
      FirebaseStorage.instanceFor(bucket: "gs://chuzzlez-c0983.appspot.com");

  Future<String> uploadFile(File file) async {
    var uid = FirebaseAuth.instance.currentUser?.uid;
    print("heiii" + uid!);
    var storageRef = storage.ref().child("user/profile/${uid}");
    var uploadTask = storageRef.putFile(file);
    var completedTask = await uploadTask;
    String downloadUrl = await completedTask.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<String> getUserProfileImage(String uid) async {
    return await storage.ref().child("user/profile/$uid").getDownloadURL();
  }

  Future<void> uploadProfilePicture(File image) async {
    var user = await UserProvider().getUser;
  }
}
