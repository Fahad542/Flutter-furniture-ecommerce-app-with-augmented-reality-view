import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mart/consts/consts.dart';
import 'package:mart/services/firestore_services%20.dart';
import 'package:mart/widgets_common/loading_indicator.dart';

class wishlist_screen extends StatefulWidget {
  const wishlist_screen({super.key});

  @override
  State<wishlist_screen> createState() => _nameState();
}

class _nameState extends State<wishlist_screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
            title: "My Wishlist"
                .text
                .color(darkFontGrey)
                .fontFamily(semibold)
                .make()),
        body: StreamBuilder(
            stream: FirestoreServices.getallwishlist(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: loadingindicator(),
                );
              } else if (snapshot.data!.docs.isEmpty) {
                return "No Wishlist yet!"
                    .text
                    .color(darkFontGrey)
                    .makeCentered();
              } else {
                var data = snapshot.data!.docs;
                return Column(children: [
                  Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              leading: Image.network(
                                "${data[index]['p_images'][0]}",
                                width: 80,
                                fit: BoxFit.cover,
                              ),
                              title: "${data[index]['p_name']}"
                                  .text
                                  .fontFamily(semibold)
                                  .size(16)
                                  .make(),
                              subtitle: "${data[index]['p_price']}"
                                  .numCurrency
                                  .text
                                  .color(redColor)
                                  .fontFamily(semibold)
                                  .make(),
                              trailing: const Icon(
                                Icons.favorite,
                                color: redColor,
                              ).onTap(() async {
                                await firestore
                                    .collection(ProductsCollection)
                                    .doc(data[index].id)
                                    .set({
                                  'p_wishlist': FieldValue.arrayRemove(
                                      [auth.currentUser!.uid])
                                }, SetOptions(merge: true));
                              }),
                            );
                          }))
                ]);
              }
            }));
  }
}
