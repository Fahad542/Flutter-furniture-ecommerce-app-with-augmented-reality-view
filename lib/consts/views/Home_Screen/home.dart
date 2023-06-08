import 'package:mart/consts/consts.dart';
import 'package:mart/consts/views/Home_Screen/home_screen%20.dart';
import 'package:mart/consts/views/cart_screen/cart_screen%20.dart';
import 'package:mart/consts/views/categories_screen/category_screen%20.dart';
import 'package:mart/consts/views/google%20map/google_map.dart';
import 'package:mart/consts/views/profile_screen/profile_screen%20.dart';
import 'package:mart/controllers/controllers%20.dart';
import 'package:get/get.dart';
import 'package:mart/src/ar_category_list.dart/item_list_screen.dart';
import 'package:mart/widgets_common/exit_dailog.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());

    var navbarItem = [
      BottomNavigationBarItem(
          icon: Image.asset(icHome, width: 26), label: home),
      BottomNavigationBarItem(
          icon: Image.asset(icCategories, width: 26), label: categories),
      BottomNavigationBarItem(
          icon: Image.asset(icCart, width: 26), label: cart),
      BottomNavigationBarItem(
          icon: Image.asset(iccore, width: 30), label: arview),
      BottomNavigationBarItem(
          icon: Image.asset(icmap, width: 28), label: "Map"),
      BottomNavigationBarItem(
          icon: Image.asset(icProfile, width: 26), label: "Account"),
    ];

    var navBody = [
      HomeScreen(),
      const Categoryscreen(),
      const CartScreen(),
      ItemsListScreen(),
      const googlemap(),
      const ProfileScreen(),
    ];

    return WillPopScope(
        onWillPop: () async {
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) => exitdailog(context));
          return false;
        },
        child: Scaffold(
            body: Column(
              children: [
                Obx(() => Expanded(
                    child:
                        navBody.elementAt(controller.currentNavIndex.value))),
              ],
            ),
            bottomNavigationBar: Obx(
              () => BottomNavigationBar(
                currentIndex: controller.currentNavIndex.value,
                selectedItemColor: redColor,
                selectedLabelStyle: const TextStyle(fontFamily: semibold),
                type: BottomNavigationBarType.fixed,
                backgroundColor: whiteColor,
                items: navbarItem,
                onTap: (value) {
                  controller.currentNavIndex.value = value;
                },
              ),
            )));
  }
}
