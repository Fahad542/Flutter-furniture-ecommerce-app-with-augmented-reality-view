import 'package:get/get.dart';
import 'package:mart/consts/consts.dart';
import 'package:mart/models/category_models.dart';

class FirestoreServices {
  static getUser(uid) {
    return firestore
        .collection(usersCollection)
        .where('id', isEqualTo: uid)
        .snapshots();
  }

  // get product acc to category
  static getProducts(categories) {
    return firestore
        .collection(ProductsCollection)
        .where('p_category', isEqualTo: categories)
        .snapshots();
  }

  static GetCart(uid) {
    return firestore
        .collection(cartcollection)
        .where('added_by', isEqualTo: uid)
        .snapshots();
  }

  static deleteDocument(docId) {
    return firestore.collection(cartcollection).doc(docId).delete();
  }

  static deleteorder(docId) {
    return firestore.collection('orders').doc(docId).delete();
  }

  static getChatMessages(docId) {
    return firestore
        .collection(chatscollection)
        .doc(docId)
        .collection(messageCollection)
        .orderBy('created_on', descending: false)
        .snapshots();
  }

  static getallorders() {
    return firestore
        .collection(orderscollection)
        .where('order_by', isEqualTo: auth.currentUser!.uid)
        .snapshots();
  }

  static getallwishlist() {
    return firestore
        .collection(ProductsCollection)
        .where('p_wishlist', arrayContains: auth.currentUser!.uid)
        .snapshots();
  }

  static getAllMessages() {
    return firestore
        .collection(chatscollection)
        .where('fromId', isEqualTo: auth.currentUser!.uid)
        .snapshots();
  }

  static getfeatredproducts() {
    return firestore
        .collection(ProductsCollection)
        .where('is_featured', isEqualTo: true)
        .get();
  }

  static allproducts() {
    return firestore.collection(ProductsCollection).snapshots();
  }

  static getconst() async {
    var res = await Future.wait([
      firestore
          .collection(cartcollection)
          .where('added_by', isEqualTo: auth.currentUser!.uid)
          .get()
          .then((value) {
        return value.docs.length;
      }),
      firestore
          .collection(ProductsCollection)
          .where('p_wishlist', arrayContains: auth.currentUser!.uid)
          .get()
          .then((value) {
        return value.docs.length;
      }),
      firestore
          .collection(orderscollection)
          .where('order_by', isEqualTo: auth.currentUser!.uid)
          .get()
          .then((value) {
        return value.docs.length;
      })
    ]);
    return res;
  }

  static searchproducts(title) {
    return firestore
        .collection(ProductsCollection)
        .where('p_name', isLessThanOrEqualTo: title)
        .get();
  }
}
