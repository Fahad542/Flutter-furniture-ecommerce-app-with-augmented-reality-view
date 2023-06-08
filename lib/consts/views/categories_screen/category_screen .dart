import 'package:mart/consts/consts.dart';
import 'package:mart/consts/lists.dart';
import 'package:mart/consts/views/categories_screen/category_details .dart';
import 'package:mart/controllers/product_controller.dart';
import 'package:mart/widgets_common/bg_widget.dart';
import 'package:get/get.dart';

class Categoryscreen extends StatelessWidget {
  const Categoryscreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());
    return bgWidget(
        child: Scaffold(
      appBar: AppBar(
        title: categories.text.fontFamily(bold).white.make(),
      ),
      body: Container(
        padding: const EdgeInsets.all(12),
        child: GridView.builder(
            shrinkWrap: true,
            itemCount: 6,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                mainAxisExtent: 200),
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Image.asset(
                    catimages[index],
                    height: 100,
                    width: 180,
                    fit: BoxFit.contain,
                  ),
                  10.heightBox,
                  categorieslist[index]
                      .text
                      .color(darkFontGrey)
                      .align(TextAlign.center)
                      .make(),
                ],
              )
                  .box
                  .white
                  .rounded
                  .clip(Clip.antiAlias)
                  .outerShadowSm
                  .make()
                  .onTap(() {
                controller.getSubCategories(categorieslist[index]);
                Get.to(
                  () => Categorydetails(title: categorieslist[index]),
                );
              });
            }),
      ),
    ));
  }
}
