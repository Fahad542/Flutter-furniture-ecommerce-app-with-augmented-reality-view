import 'package:mart/consts/consts.dart';
import 'package:mart/consts/lists.dart';
import 'package:mart/consts/views/Home_Screen/home.dart';
import 'package:mart/consts/views/auth_screen/signup_screen.dart';
import 'package:mart/controllers/auth_controller%20.dart';
import 'package:mart/widgets_common/applogo_widget.dart';
import 'package:mart/widgets_common/bg_widget.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:mart/widgets_common/custom_textfields.dart';
import 'package:mart/widgets_common/our_button.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());

    return bgWidget(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            (context.screenHeight * 0.1).heightBox,
            applogoWidget(),
            10.heightBox,
            "Log in to $appname".text.fontFamily(bold).white.size(18).make(),
            10.heightBox,
            Obx(
              () => Column(
                children: [
                  customTextField(
                    hint: emailHint,
                    title: email,
                    isPass: false,
                    controller: controller.emailController,
                  ),
                  customTextField(
                    hint: passwordHint,
                    title: password,
                    isPass: true,
                    controller: controller.passwordController,
                  ),
                  Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                          onPressed: () {}, child: forgetpass.text.make())),
                  5.heightBox,
                  controller.isloading.value
                      ? const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(redColor),
                        )
                      : ourButton(
                          color: golden,
                          title: login,
                          textColor: darkFontGrey,
                          onPress: () async {
                            //progress indicator true on login button
                            controller.isloading(true);

                            await controller
                                .loginMethod(context: context)
                                .then((value) {
                              if (value != null) {
                                VxToast.show(context, msg: loggedin);
                                Get.offAll(() => const Home());
                              } else {
                                //ghalat login details dalne ke bad
                                //wapas login button show hojaye progress
                                //indicator band hone ke bad
                                //VxToast.show(context, msg: errorlogin);

                                controller.isloading(false);
                              }
                            });
                          },
                        ).box.width(context.screenWidth - 50).make(),
                  5.heightBox,
                  createNewAccount.text.color(fontGrey).make(),
                  5.heightBox,
                  ourButton(
                      color: darkFontGrey,
                      title: signup,
                      textColor: whiteColor,
                      onPress: () {
                        Get.to(() => const SignUpScreen());
                      }).box.width(context.screenWidth - 50).make(),
                ],
              )
                  .box
                  .white
                  .rounded
                  .padding(const EdgeInsets.all(16))
                  .width(context.screenWidth - 70)
                  .shadowSm
                  .make(),
            ),
            10.heightBox,
            loginwith.text.color(fontGrey).make(),
            5.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                  3,
                  (index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                          backgroundColor: lightGrey,
                          radius: 25,
                          child: Image.asset(
                            socialIconList[index],
                            width: 30,
                          )))),
            )
          ],
        ),
      ),
    ));
  }
}
