import 'package:mart/consts/consts.dart';

Widget orderstatus({icon, color, title, showdone}) {
  return ListTile(
      leading: Icon(
        icon,
        color: color,
      )
          .box
          .border(color: color)
          .roundedSM
          .padding(const EdgeInsets.all(4))
          .make(),
      trailing: SizedBox(
          height: 100,
          width: 120,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            "$title".text.color(darkFontGrey).make(),
            showdone
                ? const Icon(
                    Icons.done,
                    color: redColor,
                  )
                : Container(),
          ])));
}
