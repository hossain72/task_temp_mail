import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme/color_manager.dart';
import '../controllers/signin_controller.dart';

class SigninView extends GetView<SigninController> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final width = ScreenUtil().screenWidth;
    final height = ScreenUtil().screenHeight;
    return SafeArea(
      child: Scaffold(
          body: Obx(() => controller.isLoading.value == false
              ? Container(
                  width: width,
                  height: height,
                  color: ColorManager.white,
                  child: Center(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 16.r, right: 16.r, top: 20.r, bottom: 16.r),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Sign In',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 22.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 30.h,
                            ),
                            Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  TextFormField(
                                      controller: controller.emailController,
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: InputDecoration(
                                        hintText: 'Email Address',
                                        border: const OutlineInputBorder(),
                                        contentPadding: EdgeInsets.all(20.r),
                                      ),
                                      validator: (String? value) {
                                        if (value!.isEmpty) {
                                          return "Email is required";
                                        } else {
                                          return null;
                                        }
                                      }),
                                  SizedBox(
                                    height: 16.h,
                                  ),
                                  TextFormField(
                                      controller: controller.passwordController,
                                      keyboardType: TextInputType.text,
                                      obscureText:
                                          controller.hidePassword.value,
                                      decoration: InputDecoration(
                                        hintText: 'Password',
                                        border: const OutlineInputBorder(),
                                        contentPadding: EdgeInsets.all(20.r),
                                        suffixIcon: IconButton(
                                            icon: Icon(
                                              controller.hidePassword.value
                                                  ? Icons.visibility_off
                                                  : Icons.visibility,
                                              color: ColorManager.grey,
                                            ),
                                            onPressed: () =>
                                                controller.passwordHide()),
                                      ),
                                      validator: (String? value) {
                                        if (value!.isEmpty) {
                                          return "Password is required";
                                        } else {
                                          return null;
                                        }
                                      })
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 30.h,
                            ),
                            TextButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  final email = controller.emailController.text;
                                  final password =
                                      controller.passwordController.text;
                                  controller.signIn(email, password);
                                }
                              },
                              style: TextButton.styleFrom(
                                  minimumSize: Size(200.w, 50.h),
                                  backgroundColor: Colors.blue,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(4.r))),
                              child: Text(
                                "Signin",
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                    color: ColorManager.white),
                              ),
                            ),
                            SizedBox(
                              height: 30.h,
                            ),
                            RichText(
                              text: TextSpan(
                                  text: "Don\'t have an account? ",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  children: [
                                    TextSpan(
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            Get.toNamed('/signup');
                                          },
                                        text: "Create account",
                                        style: TextStyle(
                                          color: Colors.blue,
                                          fontSize: 16.sp,
                                        ))
                                  ]),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ))),
    );
  }
}
