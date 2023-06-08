import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mart/consts/consts.dart';
import 'package:mart/models/category_models.dart';

class ProductController extends GetxController {
  var subcat = [];
  var quantity = 0.obs;
  var colorindex = 0.obs;
  var totalprice = 0.obs;
  var isFav = false.obs;
  getSubCategories(title) async {
    subcat.clear();
    var data = await rootBundle.loadString("lib/services/category_model.json");
    var decoded = categoryModelFromJson(data);
    var s =
        decoded.categories.where((element) => element.name == title).toList();
    for (var e in s[0].subcaterogy) {
      subcat.add(e);
    }
  }

  ChangeColorIndex(index) {
    colorindex.value = index;
  }

  increasequantity(totalQuantity) {
    if (quantity.value < totalQuantity) {
      quantity.value++;
    }
  }

  decreasequantity() {
    if (quantity.value > 0) {
      quantity.value--;
    }
  }

  calculatetotalprice(price) {
    totalprice.value = price * quantity.value;
  }

  addtocart(
      {title, img, sellername, color, qty, tprice, vendorID, context}) async {
    await firestore.collection(cartcollection).doc().set({
      'title': title,
      'img': img,
      'sellername': sellername,
      'color': color,
      'qty': qty,
      'vendor_id': vendorID,
      'tprice': tprice,
      'added_by': auth.currentUser!.uid
    }).catchError((error) {
      VxToast.show(context, msg: error.toString());
    });
  }

  resetvalues() {
    totalprice.value = 0;
    quantity.value = 0;
    colorindex.value = 0;
  }

  AddtoWishlist(docId, context) async {
    await firestore.collection(ProductsCollection).doc(docId).set({
      'p_wishlist': FieldValue.arrayUnion([currentUser!.uid])
    }, SetOptions(merge: true));
    isFav(true);
    VxToast.show(context, msg: "Added to Wishlist");
  }

  RemovefromWishlist(docId, context) async {
    await firestore.collection(ProductsCollection).doc(docId).set({
      'p_wishlist': FieldValue.arrayRemove([currentUser!.uid])
    }, SetOptions(merge: true));

    isFav(false);
    VxToast.show(context, msg: "Remove From Wishlist");
  }

  checIffav(data) async {
    if (data['p_wishlist'].contains(currentUser!.uid)) {
      isFav(true);
    } else {
      isFav(false);
    }
  }
}
