import 'package:get/get.dart';
import 'package:mart/consts/consts.dart';
import 'package:mart/consts/views/cart_screen/payment_method.dart';
import 'package:mart/controllers/cart_controller.dart';
import 'package:mart/widgets_common/custom_textfields.dart';
import 'package:mart/widgets_common/our_button.dart';

class shiping_screen extends StatefulWidget {
  const shiping_screen({super.key});

  @override
  State<shiping_screen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<shiping_screen> {
  @override
  Widget build(BuildContext context) {
    var controller = Get.find<cartcontroller>();
    return Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
            title: "Shiping Screen"
                .text
                .fontFamily(semibold)
                .size(16)
                .color(darkFontGrey)
                .make()),
        bottomNavigationBar: SizedBox(
            height: 60,
            child: ourButton(
              onPress: () {
                if (controller.addresscontroller.text.length > 10) {
                  Get.to(() => payment_method());
                } else {
                  VxToast.show(context, msg: "Please fill the form");
                }
              },
              color: redColor,
              textColor: whiteColor,
              title: "Continue",
            )),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(children: [
            customTextField(
                hint: "Address",
                isPass: false,
                title: "Address",
                controller: controller.addresscontroller),
            customTextField(
                hint: "City",
                isPass: false,
                title: "City",
                controller: controller.citycontroller),
            customTextField(
                hint: "State",
                isPass: false,
                title: "State",
                controller: controller.statecontroller),
            customTextField(
                hint: "Postal Code",
                isPass: false,
                title: "Postal Code",
                controller: controller.postalcodecontroller),
            customTextField(
                hint: "Phone",
                isPass: false,
                title: "Phone",
                controller: controller.phonecontroller),
          ]),
        )));
  }
}
