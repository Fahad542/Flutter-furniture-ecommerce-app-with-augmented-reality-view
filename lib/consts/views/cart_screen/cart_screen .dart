import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:mart/consts/consts.dart';
import 'package:mart/consts/views/cart_screen/jash_cash.dart';
import 'package:mart/consts/views/cart_screen/payment_method.dart';
import 'package:mart/consts/views/cart_screen/shiping_screen.dart';
import 'package:mart/controllers/cart_controller.dart';
import 'package:mart/services/firestore_services%20.dart';
import 'package:mart/widgets_common/loading_indicator.dart';
import 'package:mart/widgets_common/our_button.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(cartcontroller());
    return Scaffold(
        backgroundColor: whiteColor,
        bottomNavigationBar: SizedBox(
            height: 60,
            child: ourButton(
              color: redColor,
              onPress: () {
                Get.to(() => const shiping_screen());
              },
              textColor: whiteColor,
              title: "Proceed to shipping",
            )),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: "Shopping cart"
              .text
              .color(darkFontGrey)
              .fontFamily(semibold)
              .make(),
        ),
        body: StreamBuilder(
            stream: FirestoreServices.GetCart(auth.currentUser!.uid),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: loadingindicator(),
                );
              } else if (snapshot.data!.docs.isEmpty) {
                return Center(
                  child: "Cart is empty".text.color(darkFontGrey).make(),
                );
              } else {
                var data = snapshot.data!.docs;
                controller.calculate(data);
                controller.productsnapshot = data;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(children: [
                    Expanded(
                      child: Container(
                          child: ListView.builder(
                              itemCount: data.length,
                              itemBuilder: (BuildContext context, int index) {
                                return ListTile(
                                  leading: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      "${index + 1}"
                                          .text
                                          .fontFamily(bold)
                                          .color(darkFontGrey)
                                          .xl
                                          .make(),
                                      10.widthBox,
                                      Image.network(
                                        "${data[index]['img']}",
                                        width: 80,
                                        fit: BoxFit.cover,
                                      ),
                                    ],
                                  ),
                                  title:
                                      "${data[index]['title']} (x${data[index]['qty']})"
                                          .text
                                          .fontFamily(semibold)
                                          .size(16)
                                          .make(),
                                  subtitle: "${data[index]['tprice']}"
                                      .text
                                      .color(redColor)
                                      .fontFamily(semibold)
                                      .make(),
                                  trailing: const Icon(
                                    Icons.delete,
                                    color: redColor,
                                  ).onTap(() {
                                    FirestoreServices.deleteDocument(
                                        data[index].id);
                                  }),
                                );
                              })),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        "Total price"
                            .text
                            .fontFamily(semibold)
                            .color(darkFontGrey)
                            .make(),
                        Obx(
                          () => "${controller.totalP.value}"
                              .numCurrency
                              .text
                              .fontFamily(semibold)
                              .color(redColor)
                              .make(),
                        ),
                      ],
                    )
                        .box
                        .padding(const EdgeInsets.all(12))
                        .color(lightGolden)
                        .width(context.screenWidth - 60)
                        .roundedSM
                        .make(),
                    10.heightBox,
                    SizedBox(
                      width: context.screenWidth - 60,
                    ),
                  ]),
                );
              }
            }));
  }

  static counter(index) {
    "${index + 1}".text.fontFamily(bold).color(darkFontGrey).xl;
  }
}
