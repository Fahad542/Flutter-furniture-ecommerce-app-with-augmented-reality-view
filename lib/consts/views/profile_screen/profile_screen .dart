import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mart/consts/consts.dart';
import 'package:mart/consts/lists.dart';
import 'package:mart/consts/views/auth_screen/login_screen.dart';
import 'package:mart/consts/views/chat_screen/messaging_screen.dart';
import 'package:mart/consts/views/order_screen/order_screen.dart';
import 'package:mart/consts/views/profile_screen/details_card .dart';
import 'package:mart/consts/views/profile_screen/edit_profile_screen%20.dart';
import 'package:mart/consts/views/wishlist_screen/wishlist_screen.dart';
import 'package:mart/controllers/auth_controller%20.dart';
import 'package:mart/controllers/profile_controller%20.dart';
import 'package:mart/services/firestore_services%20.dart';
import 'package:mart/widgets_common/bg_widget.dart';
import 'package:get/get.dart';
import 'package:mart/widgets_common/loading_indicator.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());

    return bgWidget(
        child: Scaffold(
      body: StreamBuilder(
          stream: FirestoreServices.getUser(auth.currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                  child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(redColor),
              ));
            } else {
              var data = snapshot.data!.docs[0];
              return SafeArea(
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                //edit profile button
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: const Align(
                          alignment: Alignment.topRight,
                          child: Icon(Icons.edit, color: whiteColor))
                      .onTap(() {
                    controller.nameController.text = data['name'];

                    Get.to(() => EditProfileScreen(data: data));
                  }),
                ),
                // user details

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(children: [
                    data['imgeUrl'] == ''
                        ? Image.asset(imgProfile2,
                                width: 100, fit: BoxFit.cover)
                            .box
                            .roundedFull
                            .clip(Clip.antiAlias)
                            .make()
                        : Image.network(data['imgeUrl'],
                                width: 100, fit: BoxFit.cover)
                            .box
                            .roundedFull
                            .clip(Clip.antiAlias)
                            .make(),
                    10.widthBox,
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        "${data['name']}"
                            .text
                            .fontFamily(semibold)
                            .white
                            .make(),
                        "${data['email']}".text.white.make(),
                      ],
                    )),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          side: const BorderSide(
                        color: whiteColor,
                      )),
                      onPressed: () async {
                        await Get.put(AuthController()).signoutMethod(context);

                        Get.offAll(() => const LoginScreen());
                        // Get.reset();

                        VxToast.show(context, msg: loggedout);
                      },
                      child: logout.text.fontFamily(semibold).white.make(),
                    )
                  ]),
                ),
                10.heightBox,
                FutureBuilder(
                  future: FirestoreServices.getconst(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: loadingindicator(),
                      );
                    } else {
                      var countdata = snapshot.data;
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          detailscard(
                              count: countdata[0].toString(),
                              title: "in your cart",
                              width: context.screenWidth / 3.4),
                          detailscard(
                              count: countdata[1].toString(),
                              title: "in your wishlist",
                              width: context.screenWidth / 3.4),
                          detailscard(
                              count: countdata[2].toString(),
                              title: "your orders",
                              width: context.screenWidth / 3.4)
                        ],
                      );
                    }
                  },
                ),
                10.heightBox,

                ///buttons section
                ListView.separated(
                        shrinkWrap: true,
                        separatorBuilder: (context, index) {
                          return const Divider(color: lightGrey);
                        },
                        itemCount: profilebuttonlist.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            onTap: () {
                              switch (index) {
                                case 0:
                                  Get.to(() => const orderscreen());
                                  break;
                                case 1:
                                  Get.to(() => const wishlist_screen());
                                  break;
                                case 2:
                                  Get.to(() => const messaging_screen());
                              }
                            },
                            leading: Image.asset(
                              profilebuttonIcon[index],
                              width: 22,
                            ),
                            title: profilebuttonlist[index]
                                .text
                                .fontFamily(semibold)
                                .color(darkFontGrey)
                                .make(),
                          );
                        })
                    .box
                    .white
                    .rounded
                    .margin(const EdgeInsets.all(12))
                    .padding(const EdgeInsets.symmetric(horizontal: 16))
                    .shadowSm
                    .make()
                    .box
                    .color(redColor)
                    .make(),
              ]));
            }
          }),
    ));
  }
}
