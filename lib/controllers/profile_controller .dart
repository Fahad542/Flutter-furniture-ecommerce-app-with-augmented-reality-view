import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mart/consts/consts.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class ProfileController extends GetxController {
  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection(usersCollection);
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var profileImgPath = ''.obs;
  var profileImgLink = '';
  var isloading = false.obs;
  var nameController = TextEditingController();
  var oldpassController = TextEditingController();
  var newpassController = TextEditingController();
  changeImage(context) async {
    try {
      final img = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 70);
      if (img == null) return;
      profileImgPath.value = img.path;
    } on PlatformException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }

  UploadProfileImg() async {
    var filename = basename(profileImgPath.value);
    var destination = 'images/${auth.currentUser!.uid}/filename';
    Reference ref = FirebaseStorage.instance.ref().child(destination);
    await ref.putFile(File(profileImgPath.value));
    profileImgLink = await ref.getDownloadURL();
  }

  UpdateProfile({name, password, imgUrl}) async {
    var store =
        firestore.collection(usersCollection).doc(auth.currentUser!.uid);
    await store.update(
      {'name': name, 'password': password, 'imgeUrl': imgUrl},
    );
    isloading(false);
  }

  // Other methods in your ProfileController class

  changeauthpassword({email, password, newpassword}) async {
    final cred = EmailAuthProvider.credential(email: email, password: password);
    await currentUser!.reauthenticateWithCredential(cred).then((value) {
      currentUser!.updatePassword(newpassword);
    }).catchError((error) {
      print(error.toString());
    });
  }
}
