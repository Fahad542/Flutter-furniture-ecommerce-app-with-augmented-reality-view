import 'package:mart/consts/consts.dart';
import 'package:mart/consts/views/Home_Screen/home.dart';
import 'package:mart/controllers/auth_controller%20.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:mart/consts/consts.dart';
import 'package:mart/consts/lists.dart';
import 'package:mart/widgets_common/applogo_widget.dart';
import 'package:mart/widgets_common/bg_widget.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:mart/widgets_common/custom_textfields.dart';
import 'package:mart/widgets_common/our_button.dart';
import 'package:mart/widgets_common/applogo_widget.dart';
import 'package:mart/widgets_common/bg_widget.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignUpScreen> {
  bool? isCheck = false;

  var controller = Get.put(AuthController());

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordRetypeController = TextEditingController();

  Widget build(BuildContext context) {
    return bgWidget(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    (context.screenHeight * 0.1).heightBox,
                    applogoWidget(),
                    10.heightBox,
                    "Join The $appname"
                        .text
                        .fontFamily(bold)
                        .white
                        .size(18)
                        .make(),
                    10.heightBox,
                    Obx(
                      () => Column(
                        children: [
                          customTextField(
                            hint: nameHint,
                            title: name,
                            controller: nameController,
                            isPass: false,
                          ),
                          customTextField(
                            hint: emailHint,
                            title: email,
                            controller: emailController,
                            isPass: false,
                          ),
                          customTextField(
                            hint: passwordHint,
                            title: password,
                            controller: passwordController,
                            isPass: true,
                          ),
                          customTextField(
                            hint: passwordHint,
                            title: retypePassword,
                            controller: passwordRetypeController,
                            isPass: true,
                          ),
                          Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                  onPressed: () {},
                                  child: forgetpass.text.make())),
                          /*  5.heightBox,
                  ourButton(
                          color: golden,
                          title: login,
                          textColor: darkFontGrey,
                          onPress: () {})
                      .box
                      .width(context.screenWidth - 50)
                      .make(),
                      */
                          Row(
                            children: [
                              Checkbox(
                                checkColor: redColor,
                                value: isCheck,
                                onChanged: (newValue) {
                                  setState(() {
                                    isCheck = newValue;
                                  });
                                },
                              ),
                              10.widthBox,
                              Expanded(
                                  child: RichText(
                                      text: const TextSpan(
                                children: [
                                  TextSpan(
                                      text: "I agree to the ",
                                      style: TextStyle(
                                        fontFamily: regular,
                                        color: redColor,
                                      )),
                                  TextSpan(
                                      text: termsconditions,
                                      style: TextStyle(
                                        fontFamily: regular,
                                        color: redColor,
                                      )),
                                  TextSpan(
                                      text: " and ",
                                      style: TextStyle(
                                        fontFamily: regular,
                                        color: fontGrey,
                                      )),
                                  TextSpan(
                                      text: privacypolicy,
                                      style: TextStyle(
                                        fontFamily: regular,
                                        color: redColor,
                                      )),
                                ],
                              ))),
                            ],
                          ),
                          5.heightBox,
                          createNewAccount.text.color(fontGrey).make(),
                          5.heightBox,
                          controller.isloading.value
                              ? const CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation(redColor),
                                )
                              : ourButton(
                                  color:
                                      isCheck == true ? redColor : darkFontGrey,
                                  title: signup,
                                  textColor: whiteColor,
                                  onPress: () async {
                                    if (isCheck != false) {
                                      controller.isloading(true);
                                      try {
                                        await controller
                                            .signupMethod(
                                                context: context,
                                                email: emailController.text,
                                                password:
                                                    passwordController.text)
                                            .then((value) {
                                          return controller.storeUserData(
                                              email: emailController.text,
                                              password: passwordController.text,
                                              name: nameController.text);
                                        }).then((value) {
                                          VxToast.show(context, msg: loggedin);
                                          Get.offAll(() => const Home());
                                        });
                                      } catch (e) {
                                        auth.signOut();
                                        VxToast.show(context,
                                            msg: e.toString());
                                        controller.isloading(false);
                                      }
                                    }
                                  },
                                ).box.width(context.screenWidth - 50).make(),
                          10.heightBox,
                          RichText(
                              text: const TextSpan(children: [
                            TextSpan(
                                text: alreadyacc,
                                style: TextStyle(
                                    fontFamily: bold, color: fontGrey)),
                            TextSpan(
                                text: login,
                                style: TextStyle(
                                    fontFamily: bold, color: redColor)),
                          ])).onTap(() {
                            Get.back();
                          }),
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
                  ],
                ),
              ),
            )));
  }
}
