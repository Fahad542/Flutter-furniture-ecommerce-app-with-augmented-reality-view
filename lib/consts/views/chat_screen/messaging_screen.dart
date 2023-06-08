import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:mart/consts/consts.dart';
import 'package:mart/consts/views/chat_screen/chat_screen.dart';
import 'package:mart/services/firestore_services%20.dart';
import 'package:mart/widgets_common/loading_indicator.dart';

class messaging_screen extends StatefulWidget {
  const messaging_screen({super.key});

  @override
  State<messaging_screen> createState() => _nameState();
}

class _nameState extends State<messaging_screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
            title: "My Messages"
                .text
                .color(darkFontGrey)
                .fontFamily(semibold)
                .make()),
        body: StreamBuilder(
            stream: FirestoreServices.getAllMessages(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: loadingindicator(),
                );
              } else if (snapshot.data!.docs.isEmpty) {
                return "No Messages yet!"
                    .text
                    .color(darkFontGrey)
                    .makeCentered();
              } else {
                var data = snapshot.data!.docs;
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                              child: ListTile(
                            onTap: () {
                              Get.to(() => chatscreen(), arguments: [
                                data[index]['friendname'],
                                data[index]['toId'],
                              ]);
                            },
                            leading: const CircleAvatar(
                              backgroundColor: redColor,
                              child: Icon(
                                Icons.person,
                                color: whiteColor,
                              ),
                            ),
                            title: "${data[index]['friendname']}"
                                .text
                                .fontFamily(semibold)
                                .color(darkFontGrey)
                                .make(),
                            subtitle: "${data[index]["last_msg"]}".text.make(),
                          ));
                        },
                      ),
                    )
                  ],
                );
              }
            }));
  }
}
