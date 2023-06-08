import 'package:mart/consts/consts.dart';

import 'package:mart/consts/consts.dart';

Widget featurebutton({String? title, Icon}) {
  return Row(
    children: [
      Image.asset(Icon, width: 70, fit: BoxFit.cover),
      10.widthBox,
      title!.text.fontFamily(semibold).color(darkFontGrey).make(),
    ],
  )
      .box
      .width(200)
      .height(80)
      .margin(const EdgeInsets.symmetric(horizontal: 4))
      .white
      .roundedSM
      .outerShadow
      .padding(const EdgeInsets.all(4))
      .make();
}
