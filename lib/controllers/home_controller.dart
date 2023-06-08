import 'package:get/get.dart';
import 'package:mart/consts/consts.dart';

class Homecontroller extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getusername();
  }

  var navIndex = 0.obs;
  var username = '';

  var featuredlist = [];
  var searchcontroller = TextEditingController();

  getusername() async {
    var n = await firestore
        .collection('users')
        .where('id', isEqualTo: auth.currentUser!.uid)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        return value.docs.single['name'];
      }
    });

    username = n;
    print(username);
  }
}

var featuredlist = [];
var searchcontroller = TextEditingController();
