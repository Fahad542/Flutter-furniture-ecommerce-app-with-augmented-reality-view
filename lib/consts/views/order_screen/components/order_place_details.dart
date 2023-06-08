import 'package:mart/consts/consts.dart';
import 'package:mart/consts/views/wishlist_screen/wishlist_screen.dart';

Widget order_place_details({data, title1, title2, d1, d2}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),

    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          "$title1".text.fontFamily(semibold).make(),
          "$d1".text.color(redColor).fontFamily(semibold).make()
        ]),
        SizedBox(
            width: 130,
            child: // Column
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              "$title2".text.fontFamily(semibold).make(),
              "$d2".text.make()
            ]))
      ],
    ), // Row
  );
}
