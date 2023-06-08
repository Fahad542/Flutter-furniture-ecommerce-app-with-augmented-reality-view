import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:mart/consts/consts.dart';
import 'package:mart/consts/lists.dart';
import 'package:mart/consts/views/Home_Screen/home.dart';
import 'package:mart/controllers/cart_controller.dart';
import 'package:mart/widgets_common/loading_indicator.dart';
import 'package:mart/widgets_common/our_button.dart';

class payment_method extends StatefulWidget {
  const payment_method({super.key});

  @override
  State<payment_method> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<payment_method> {
  @override
  Widget build(BuildContext context) {
    var controller = Get.find<cartcontroller>();
    return Obx(() => Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
            title: "Choose Payment Method"
                .text
                .fontFamily(semibold)
                .size(16)
                .color(darkFontGrey)
                .make()),
        bottomNavigationBar: SizedBox(
            height: 60,
            child: controller.placingorder.value
                ? Center(
                    child: loadingindicator(),
                  )
                : ourButton(
                    onPress: () async {
                      await controller.placemyorder(
                          orderpaymentmethod:
                              paymentMethods[controller.paymentindex.value],
                          totalamount: controller.totalP.value);
                      await controller.clearcart();
                      VxToast.show(context, msg: "Order placed succesfully");
                      Get.offAll(const Home());
                    },
                    color: redColor,
                    textColor: whiteColor,
                    title: "Place my order",
                  )),
        body: Padding(
            padding: const EdgeInsets.all(8),
            child: Obx(
              (() => Column(
                      children:
                          List.generate(paymentmethodsimg.length, (index) {
                    return GestureDetector(
                        onTap: () {
                          controller.changepaymentindex(index);
                        },
                        child: Container(
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                    style: BorderStyle.solid,
                                    color:
                                        controller.paymentindex.value == index
                                            ? redColor
                                            : Colors.transparent,
                                    width: 4)),
                            margin: const EdgeInsets.only(bottom: 8),
                            child:
                                Stack(alignment: Alignment.topRight, children: [
                              Image.asset(
                                paymentmethodsimg[index],
                                width: double.infinity,
                                height: 120,
                                colorBlendMode:
                                    controller.paymentindex.value == index
                                        ? BlendMode.darken
                                        : BlendMode.color,
                                color: controller.paymentindex.value == index
                                    ? Colors.black.withOpacity(0.4)
                                    : Colors.transparent,
                                fit: BoxFit.cover,
                              ),
                              controller.paymentindex.value == index
                                  ? Transform.scale(
                                      scale: 1.3,
                                      child: Checkbox(
                                        activeColor: Colors.green,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                        value: true,
                                        onChanged: ((value) {}),
                                      ))
                                  : Container(),
                              Positioned(
                                bottom: 10,
                                right: 10,
                                child: paymentMethods[index]
                                    .text
                                    .white
                                    .fontFamily(bold)
                                    .size(16)
                                    .make(),
                              )
                            ])));
                  }))),
            ))));
  }
}
