import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:mart/consts/consts.dart';
import 'package:mart/controllers/controllers%20.dart';
import 'package:mart/controllers/home_controller.dart';

class cartcontroller extends GetxController {
  var totalP = 0.obs;

  var addresscontroller = TextEditingController();
  var citycontroller = TextEditingController();
  var statecontroller = TextEditingController();
  var postalcodecontroller = TextEditingController();
  var phonecontroller = TextEditingController();
  var paymentindex = 0.obs;

  late dynamic productsnapshot;
  var products = [];
  var vendors = [];
  var placingorder = false.obs;
  calculate(data) {
    totalP.value = 0;
    for (var i = 0; i < data.length; i++) {
      totalP.value = totalP.value + int.parse(data[i]['tprice'].toString());
    }
  }

  changepaymentindex(index) {
    paymentindex.value = index;
  }

  placemyorder({required orderpaymentmethod, required totalamount}) async {
    placingorder(true);
    await getproductdetails();
    await firestore.collection(orderscollection).doc().set({
      'order_code': "233981237",
      'order_date': FieldValue.serverTimestamp(),
      'order_by': auth.currentUser!.uid,
      'order_by_name': Get.find<Homecontroller>().username,
      'order_by_email': auth.currentUser!.email,
      'order_by_address': addresscontroller.text,
      'order_by_state': statecontroller.text,
      'order_by_city': citycontroller.text,
      'order_by_phone': phonecontroller.text,
      'order_by_postalcode': postalcodecontroller.text,
      'Shiping_method': "Home Delivery",
      'payment_method': orderpaymentmethod,
      'order_placed': true,
      'order_confirmed': false,
      'order_delivered': false,
      'order_on_delivery': false,
      'total_amount': totalamount,
      'orders': FieldValue.arrayUnion(products),
      'vendors': FieldValue.arrayUnion(vendors)
    });
    placingorder(false);
  }

  getproductdetails() {
    products.clear();
    vendors.clear();
    for (var i = 0; i < productsnapshot.length; i++) {
      products.add({
        'color': productsnapshot[i]['color'],
        'img': productsnapshot[i]['img'],
        'vendor_id': productsnapshot[i]['vendor_id'],
        'tprice': productsnapshot[i]['tprice'],
        'qty': productsnapshot[i]['qty'],
        'title': productsnapshot[i]['title'],
      });
      vendors.add(productsnapshot[i]['vendor_id']);
    }
  }

  clearcart() {
    for (var i = 0; i < productsnapshot.length; i++) {
      firestore.collection(cartcollection).doc(productsnapshot[i].id).delete();
    }
  }
}
