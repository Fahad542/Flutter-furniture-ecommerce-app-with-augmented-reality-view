import 'package:get/get.dart';
import 'package:mart/consts/consts.dart';
import 'package:mart/consts/lists.dart';
import 'package:mart/consts/views/chat_screen/chat_screen.dart';
import 'package:mart/controllers/product_controller.dart';
import 'package:mart/src/screen.dart/arview.dart';
import 'package:mart/widgets_common/our_button.dart';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class itemdetails extends StatelessWidget {
  final String? title;
  final dynamic data;
  const itemdetails({Key? key, required this.title, this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());
    return WillPopScope(
        onWillPop: () async {
          controller.resetvalues();
          return true;
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Scaffold(
            backgroundColor: lightGrey,
            appBar: AppBar(
                leading: IconButton(
                  onPressed: () {
                    controller.resetvalues();
                    Get.back();
                  },
                  icon: const Icon(Icons.arrow_back),
                ),
                title: title!.text.color(darkFontGrey).fontFamily(bold).make(),
                actions: [
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.share,
                        color: darkFontGrey,
                      )),
                  Obx((() => IconButton(
                      onPressed: () {
                        if (controller.isFav.value) {
                          controller.RemovefromWishlist(data.id, context);
                        } else {
                          controller.AddtoWishlist(data.id, context);
                        }
                      },
                      icon: Icon(
                        Icons.favorite_outline,
                        color: controller.isFav.value ? redColor : darkFontGrey,
                      ))))
                ]),
            body: Column(children: [
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(8),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      VxSwiper.builder(
                          autoPlay: true,
                          height: 350,
                          itemCount: data['p_images'].length,
                          aspectRatio: 16 / 9,
                          viewportFraction: 1.0,
                          itemBuilder: (context, index) {
                            return Image.network(
                              data["p_images"][index],
                              width: double.infinity,
                              fit: BoxFit.fill,
                            );
                          }),
                      10.heightBox,
                      // title and details section
                      title!.text
                          .size(16)
                          .color(darkFontGrey)
                          .fontFamily(semibold)
                          .make(),
                      10.heightBox,

                      10.heightBox,
                      VxRating(
                        isSelectable: false,
                        value: double.parse(data['ratings']),
                        onRatingUpdate: (value) {},
                        normalColor: textfieldGrey,
                        selectionColor: golden,
                        count: 5,
                        size: 25,
                        maxRating: 5,
                      ),
                      10.heightBox,
                      "${data['p_price']}"
                          .numCurrency
                          .text
                          .color(redColor)
                          .fontFamily(bold)
                          .size(18)
                          .make(),
                      10.heightBox,
                      Row(
                        children: [
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              "Sellers".text.white.fontFamily(semibold).make(),
                              5.heightBox,
                              "In house Brands"
                                  .text
                                  .fontFamily(semibold)
                                  .color(darkFontGrey)
                                  .size(16)
                                  .make()
                            ],
                          )),
                          const CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.message_rounded,
                              color: darkFontGrey,
                            ),
                          ).onTap(() {
                            Get.to(() => const chatscreen(), arguments: [
                              data['p_seller'],
                              data['vendor_id']
                            ]);
                          })
                        ],
                      )
                          .box
                          .height(60)
                          .padding(const EdgeInsets.symmetric(horizontal: 16))
                          .color(textfieldGrey)
                          .make(),
                      10.heightBox,

                      //color section
                      10.heightBox,
                      Obx(
                        () => Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 100,
                                  child: "Color : "
                                      .text
                                      .color(Colors.black)
                                      .make(),
                                ),
                                Row(
                                    children: List.generate(
                                        data['p_colors'].length,
                                        (index) => Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                VxBox()
                                                    .size(40, 40)
                                                    .roundedFull
                                                    .color(Color(
                                                            data['p_colors']
                                                                [index])
                                                        .withOpacity(1.0))
                                                    .margin(const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 4))
                                                    .make()
                                                    .onTap(() {
                                                  controller.ChangeColorIndex(
                                                      index);
                                                }),
                                                Visibility(
                                                    visible: index ==
                                                        controller
                                                            .colorindex.value,
                                                    child: const Icon(
                                                      Icons.done,
                                                      color: Colors.white,
                                                    ))
                                              ],
                                            )))
                              ],
                            ).box.padding(const EdgeInsets.all(8)).make(),

//quantity row
                            Row(
                              children: [
                                SizedBox(
                                  width: 100,
                                  child: "Quantity: "
                                      .text
                                      .color(textfieldGrey)
                                      .make(),
                                ),
                                Obx(
                                  () => Row(
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            controller.decreasequantity();
                                            controller.calculatetotalprice(
                                                int.parse(data['p_price']));
                                          },
                                          icon: const Icon(Icons.remove)),
                                      controller.quantity.value.text
                                          .size(16)
                                          .color(darkFontGrey)
                                          .fontFamily(bold)
                                          .make(),
                                      IconButton(
                                          onPressed: () {
                                            controller.increasequantity(
                                                int.parse(data['p_quantity']));
                                            controller.calculatetotalprice(
                                                int.parse(data['p_price']));
                                          },
                                          icon: const Icon(Icons.add)),
                                      10.widthBox,
                                      "(${data['p_quantity']} available)"
                                          .text
                                          .color(textfieldGrey)
                                          .make(),
                                    ],
                                  ),
                                ),
                              ],
                            ).box.padding(const EdgeInsets.all(8)).make(),

                            //total row
                            Row(
                              children: [
                                SizedBox(
                                  width: 100,
                                  child: "  Total: "
                                      .text
                                      .color(textfieldGrey)
                                      .make(),
                                ),
                                "${controller.totalprice.value}"
                                    .numCurrency
                                    .text
                                    .color(redColor)
                                    .size(16)
                                    .fontFamily(bold)
                                    .make(),
                              ],
                            )
                          ],
                        )
                            .box
                            .white
                            .shadowSm
                            .padding(EdgeInsets.all(10))
                            .roundedSM
                            .make(),
                      ),
                      // description
                      10.heightBox,
                      "Description"
                          .text
                          .color(darkFontGrey)
                          .fontFamily(semibold)
                          .make(),

                      10.heightBox,
                      "${data['p_description']} "
                          .text
                          .color(textfieldGrey)
                          .make(),
                      10.heightBox,
                      //buttons section
                      ListView(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: List.generate(
                            itemdetailbuttonlist.length,
                            (index) => ListTile(
                                  title: "${itemdetailbuttonlist[index]}"
                                      .text
                                      .fontFamily(semibold)
                                      .color(darkFontGrey)
                                      .make(),
                                  trailing: const Icon(Icons.arrow_forward),
                                )),
                      ),
                      20.heightBox,
                    ],
                  ),
                ),
              )),
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ourButton(
                        color: redColor,
                        onPress: () {
                          if (controller.quantity.value > 0) {
                            controller.addtocart(
                                color: data['p_colors']
                                    [controller.colorindex.value],
                                context: context,
                                vendorID: data['vendor_id'],
                                img: data['p_images'][0],
                                qty: controller.quantity.value,
                                sellername: data['p_seller'],
                                title: data['p_name'],
                                tprice: controller.totalprice.value);
                            VxToast.show(context, msg: "Added to cart");
                          } else {
                            VxToast.show(context,
                                msg: "Minimum 1 product is required");
                          }
                        },
                        textColor: whiteColor,
                        title: "Add To Cart")
                    .box
                    .roundedSM
                    .make(),
              )
            ]),
          ),
        ));
  }
}
