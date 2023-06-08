import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:mart/consts/consts.dart';
import 'package:mart/controllers/controllers%20.dart';

import 'home_controller.dart';

class ChatsController extends GetxController {
  @override
  void onInit() {
    getChatID();
    super.onInit();
  }

  var chats = firestore.collection(chatscollection);
  var friendName = Get.arguments[0];
  var friendId = Get.arguments[1];
  var senderName = Get.find<Homecontroller>().username;
  var currentId = currentUser!.uid;
  var msgController = TextEditingController();
  dynamic chatDocID;
  var isloading = false.obs;
  getChatID() async {
    isloading(true);
    await chats
        .where('users', isEqualTo: {
          friendId: null,
          currentId: null,
        })
        .limit(1)
        .get()
        .then((QuerySnapshot snapshot) {
          if (snapshot.docs.isNotEmpty) {
            chatDocID = snapshot.docs.single.id;
          } else {
            chats.add({
              'created_on': null,
              'last_msg': '',
              'users': {friendId: null, currentId: null},
              'toId': '',
              'fromId': '',
              'friendname': friendName,
              'sender_name': senderName
            }).then((value) {
              {
                chatDocID = value.id;
              }
            });
          }
        });
    isloading(false);
  }

  sendMsg(msg) async {
    if (msg.trim().isNotEmpty) {
      chats.doc(chatDocID).update({
        'create_on': FieldValue.serverTimestamp(),
        'last_msg': msg,
        'toId': friendId,
        'fromId': currentId,
      });

      chats.doc(chatDocID).collection(messageCollection).doc().set({
        'created_on': FieldValue.serverTimestamp(),
        'msg': msg,
        'uid': currentId,
      });
    }
  }
}
