import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:mart/consts/consts.dart';
import 'package:mart/consts/lists.dart';
import 'package:mart/consts/views/Home_Screen/components/featurebutton%20.dart';
import 'package:mart/consts/views/Home_Screen/search_screen.dart';
import 'package:mart/consts/views/categories_screen/item_details%20.dart';
import 'package:mart/controllers/controllers%20.dart';
import 'package:mart/controllers/home_controller.dart';
import 'package:mart/services/firestore_services%20.dart';
import 'package:mart/widgets_common/home_buttons%20.dart';
import 'package:mart/widgets_common/loading_indicator.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../controllers/product_controller.dart';
import '../../consts.dart';
import '../cart_screen/cart_screen .dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(Homecontroller());
    var controllers = Get.put(ProductController());

    int cartItemCount = 0;

    return Container(
      color: lightGrey,
      width: context.screenWidth,
      height: context.screenHeight,
      child: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Material(
                    borderRadius: BorderRadius.circular(
                        50.0), // Adjust the border radius as needed
                    clipBehavior: Clip.antiAlias,
                    child: Container(
                      alignment: Alignment.center,
                      height: 60,
                      decoration: BoxDecoration(color: lightGrey, boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.9),
                          spreadRadius: 4,
                          blurRadius: 5,
                          offset: Offset(0, 3), // Adjust the offset as needed
                        ),
                      ]),
                      child: TextFormField(
                        controller: controller.searchcontroller,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          suffixIcon: IconButton(
                            icon: Icon(
                              Icons.search,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              if (controller.searchcontroller.text.isNotEmpty) {
                                Get.to(() => searchscreen(
                                      title: controller.searchcontroller.text,
                                    ));
                              }
                            },
                          ),
                          filled: true,
                          fillColor: whiteColor,
                          hintText: searchanything,
                          hintStyle: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ),
                Stack(
                  children: [
                    IconButton(
                      icon: Icon(Icons.shopping_cart),
                      onPressed: () {
                        Get.to(() => CartScreen());
                      },
                    ),
                    Positioned(
                      top: 8.0,
                      right: 8.0,
                      child: Container(
                        padding: EdgeInsets.all(2.0),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        constraints: BoxConstraints(
                          minWidth: 16.0,
                          minHeight: 16.0,
                        ),
                        child: Text(
                          cartItemCount.toString(),
                          style: TextStyle(
                            fontSize: 10.0,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            20.heightBox,
            Expanded(
                child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(children: [
                      //swiper
                      VxSwiper.builder(
                          aspectRatio: 16 / 9,
                          autoPlay: true,
                          height: 150,
                          enlargeCenterPage: true,
                          itemCount: sliderlist.length,
                          itemBuilder: (context, index) {
                            return Image.asset(
                              sliderlist[index],
                              fit: BoxFit.fill,
                            )
                                .box
                                .rounded
                                .clip(Clip.antiAlias)
                                .margin(
                                    const EdgeInsets.symmetric(horizontal: 8))
                                .make();
                          }),

                      10.heightBox,

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(
                            2,
                            (index) => homebutton(
                                  height: context.screenHeight * 0.15,
                                  width: context.screenWidth / 2.5,
                                  icon: index == 0 ? icTodaysDeal : icFlashDeal,
                                  title: index == 0 ? todayDeal : flashsale,
                                )),
                      ),
                      20.heightBox,
                      //2 swiper
                      VxSwiper.builder(
                          aspectRatio: 16 / 9,
                          autoPlay: true,
                          height: 150,
                          enlargeCenterPage: true,
                          itemCount: sliderlist.length,
                          itemBuilder: (context, index) {
                            return Image.asset(
                              secondsliderlist[index],
                              fit: BoxFit.fill,
                            )
                                .box
                                .rounded
                                .clip(Clip.antiAlias)
                                .margin(
                                    const EdgeInsets.symmetric(horizontal: 8))
                                .make();
                          }),
                      20.heightBox,
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(
                              3,
                              (index) => homebutton(
                                    height: context.screenHeight * 0.12,
                                    width: context.screenWidth / 3.5,
                                    icon: index == 0
                                        ? icTopCategories
                                        : index == 1
                                            ? icBrands
                                            : icTopSeller,
                                    title: index == 0
                                        ? topCategories
                                        : index == 1
                                            ? brand
                                            : topseller,
                                  ))),
                      20.heightBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8, right: 8),
                            child: "Feature Categories"
                                .text
                                .color(Colors.red)
                                .size(17)
                                .fontFamily(semibold)
                                .makeCentered(),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: "SEE ALL"
                                .text
                                .size(6)
                                .color(Colors.black)
                                .make(),
                          )
                        ],
                      ),
                      20.heightBox,
                      SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                              children: List.generate(
                            3,
                            (index) => Column(
                              children: [
                                featurebutton(
                                    Icon: featuredimges1[index],
                                    title: featuredTitles1[index]),
                                10.heightBox,
                                featurebutton(
                                    Icon: featuredimges2[index],
                                    title: featuredTitles2[index])
                              ],
                            ),
                          ))),
                      20.heightBox,
//frraeted product

                      Container(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              featureProduct.text
                                  .color(Colors.red)
                                  .size(17)
                                  .fontFamily(semibold)
                                  .makeCentered(),
                              "SEE ALL".text.size(6).color(Colors.black).make()
                            ],
                          ),
                          20.heightBox,
                          SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: FutureBuilder(
                                  future:
                                      FirestoreServices.getfeatredproducts(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<QuerySnapshot> snapshot) {
                                    if (!snapshot.hasData) {
                                      return Center(
                                        child: loadingindicator(),
                                      );
                                    } else if (snapshot.data!.docs.isEmpty) {
                                      return "No featured products found "
                                          .text
                                          .color(whiteColor)
                                          .makeCentered();
                                    } else {
                                      var faeturedData = snapshot.data!.docs;
                                      return Row(
                                        children: List.generate(
                                            faeturedData.length,
                                            (index) => Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Image.network(
                                                      faeturedData[index]
                                                          ['p_images'][0],
                                                      width: 120,
                                                      height: 120,
                                                      fit: BoxFit.fill,
                                                    ),
                                                    10.heightBox,
                                                    "${faeturedData[index]['p_name']}"
                                                        .text
                                                        .fontFamily(semibold)
                                                        .color(darkFontGrey)
                                                        .make(),
                                                    10.heightBox,
                                                    "${faeturedData[index]['p_price']}"
                                                        .numCurrency
                                                        .text
                                                        .color(redColor)
                                                        .fontFamily(bold)
                                                        .size(16)
                                                        .make()
                                                  ],
                                                )
                                                    .box
                                                    .white
                                                    .margin(const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 4))
                                                    .roundedSM
                                                    .padding(
                                                        const EdgeInsets.all(8))
                                                    .make()
                                                    .onTap(() {
                                                  Get.to(() => itemdetails(
                                                        title:
                                                            "${faeturedData[index]['p_name']}",
                                                        data:
                                                            faeturedData[index],
                                                      ));
                                                })),
                                      );
                                    }
                                  }))
                        ],
                      )).box.padding(EdgeInsets.all(12.0)).roundedSM.make(),
                      20.heightBox,

                      // third swiper
                      VxSwiper.builder(
                          aspectRatio: 16 / 9,
                          autoPlay: true,
                          height: 150,
                          enlargeCenterPage: true,
                          itemCount: sliderlist.length,
                          itemBuilder: (context, index) {
                            return Image.asset(
                              sliderlist[index],
                              fit: BoxFit.fill,
                            )
                                .box
                                .rounded
                                .clip(Clip.antiAlias)
                                .margin(
                                    const EdgeInsets.symmetric(horizontal: 8))
                                .make();
                          }),
                      20.heightBox,

                      Padding(
                          padding: EdgeInsets.all(8),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: "All Products"
                                .text
                                .fontFamily(semibold)
                                .color(darkFontGrey)
                                .size(18)
                                .color(redColor)
                                .makeCentered(),
                          )),

                      10.heightBox,

                      StreamBuilder(
                          stream: FirestoreServices.allproducts(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (!snapshot.hasData) {
                              return loadingindicator();
                            } else {
                              var allproductsdata = snapshot.data!.docs;
                              return GridView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: allproductsdata.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          mainAxisSpacing: 8,
                                          crossAxisSpacing: 8,
                                          mainAxisExtent: 300),
                                  itemBuilder: (context, index) {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Image.network(
                                            allproductsdata[index]['p_images']
                                                [0],
                                            height: 150,
                                            width: 150,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        const Spacer(),
                                        5.heightBox,
                                        "${allproductsdata[index]['p_name']}"
                                            .text
                                            .fontFamily(semibold)
                                            .color(darkFontGrey)
                                            .make(),
                                        10.heightBox,
                                        "${allproductsdata[index]['p_price']}"
                                            .numCurrency
                                            .text
                                            .color(redColor)
                                            .fontFamily(bold)
                                            .size(16)
                                            .make(),
                                        10.heightBox,
                                      ],
                                    )
                                        .box
                                        .white
                                        .margin(const EdgeInsets.symmetric(
                                            horizontal: 4))
                                        .roundedSM
                                        .shadow
                                        .padding(const EdgeInsets.all(12))
                                        .make()
                                        .onTap(() {
                                      Get.to(() => itemdetails(
                                            title:
                                                "${allproductsdata[index]['p_name']}",
                                            data: allproductsdata[index],
                                          ));
                                    });
                                  });
                            }
                          })
                    ])))
          ],
        ),
      )),
    );
  }
}
