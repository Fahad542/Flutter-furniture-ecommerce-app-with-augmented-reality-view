import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:mart/consts/consts.dart';
import 'package:mart/consts/views/order_screen/orders_details.dart';
import 'package:mart/services/firestore_services%20.dart';
import 'package:mart/widgets_common/loading_indicator.dart';

class orderscreen extends StatefulWidget {
  const orderscreen({super.key});

  @override
  State<orderscreen> createState() => _nameState();
}

class _nameState extends State<orderscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
            title: "My Orders"
                .text
                .color(darkFontGrey)
                .fontFamily(semibold)
                .make()),
        body: StreamBuilder(
            stream: FirestoreServices.getallorders(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: loadingindicator(),
                );
              } else if (snapshot.data!.docs.isEmpty) {
                return "No orders yet!".text.color(darkFontGrey).makeCentered();
              } else {
                var data = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      leading: "${index + 1}"
                          .text
                          .fontFamily(bold)
                          .color(darkFontGrey)
                          .xl
                          .make(),
                      title: data[index]['order_code']
                          .toString()
                          .text
                          .color(redColor)
                          .fontFamily(semibold)
                          .make(),
                      subtitle: data[index]['total_amount']
                          .toString()
                          .numCurrency
                          .text
                          .fontFamily(bold)
                          .make(),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.delete,
                            color: redColor,
                          ).onTap(() {
                            FirestoreServices.deleteorder(data[index].id);
                          }),
                          IconButton(
                            onPressed: () {
                              Get.to(() => (Orders_details(data: data[index])));
                            },
                            icon: const Icon(Icons.arrow_forward_ios_rounded,
                                color: darkFontGrey),
                          ),
                        ],
                      ),
                    );
                    ;
                  },
                );
              }
            }));
  }
}
