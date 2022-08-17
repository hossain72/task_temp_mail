import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../routes/app_pages.dart';
import '../controllers/signup_controller.dart';
import '../../../core/constants/color_manager.dart';

class SignupView extends GetView<SignupController> {
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
                          children: [
                            Text(
                              'Sign Up',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 22.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 30.h,
                            ),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Select a domain",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: 16.h,
                            ),
                            Form(
                              key: _formKey,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  DropdownButtonFormField(
                                      elevation: 0,
                                      value: controller.selectedDomain.value,
                                      validator: (String? value) {
                                        if (value!.isEmpty) {
                                          return "Please select category type";
                                        }
                                      },
                                      isExpanded: true,
                                      dropdownColor: ColorManager.grey,
                                      decoration: InputDecoration(
                                          contentPadding: EdgeInsets.all(18.r),
                                          hintText: 'Please select domain',
                                          border: const OutlineInputBorder()),
                                      items: controller.domainLists
                                          .map<DropdownMenuItem<String>>(
                                              (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      onChanged: (String? newValue) {
                                        controller.changeValue(newValue!);
                                      }),
                                  SizedBox(
                                    height: 16.h,
                                  ),
                                  TextFormField(
                                      controller: controller.emailController,
                                      keyboardType: TextInputType.text,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.deny(RegExp(
                                            r'[-~!@#$%^&*()_+`{}|<>?;:./=,\"]')),
                                        FilteringTextInputFormatter.deny(
                                            RegExp("'")),
                                        FilteringTextInputFormatter.deny(
                                            RegExp(r'\[')),
                                        FilteringTextInputFormatter.deny(
                                            RegExp(r'\]')),
                                        FilteringTextInputFormatter.deny(
                                            RegExp('[ ]')),
                                      ],
                                      decoration: InputDecoration(
                                          isDense: true,
                                          contentPadding: EdgeInsets.all(20.r),
                                          hintText: 'Email Address',
                                          border: const OutlineInputBorder(),
                                          suffix: Text(
                                            "@${controller.selectedDomain.value}",
                                          )),
                                      validator: (String? value) {
                                        if (value!.isEmpty) {
                                          return "Email address is required";
                                        } else {
                                          return null;
                                        }
                                      }),
                                  SizedBox(
                                    height: 16.h,
                                  ),
                                  TextFormField(
                                      controller: controller.passwordController,
                                      obscureText:
                                          controller.hidePassword.value,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                          hintText: 'Password',
                                          border: const OutlineInputBorder(),
                                          contentPadding: EdgeInsets.all(20.r),
                                          suffixIcon: Padding(
                                            padding:
                                                EdgeInsets.only(right: 10.r),
                                            child: IconButton(
                                                icon: Icon(
                                                  controller.hidePassword.value
                                                      ? Icons.visibility_off
                                                      : Icons.visibility,
                                                  color: ColorManager.grey,
                                                ),
                                                onPressed: () {
                                                  controller.passwordHide();
                                                }),
                                          )),
                                      validator: (String? value) {
                                        if (value!.isEmpty) {
                                          return "Password is required";
                                        } else {
                                          return null;
                                        }
                                      }),
                                  SizedBox(
                                    height: 16.h,
                                  ),
                                  TextFormField(
                                      controller:
                                          controller.confirmPasswordController,
                                      obscureText:
                                          controller.hideConfirmPassword.value,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                          hintText: 'Confirm Password',
                                          border: const OutlineInputBorder(),
                                          contentPadding: EdgeInsets.all(20.r),
                                          suffixIcon: Padding(
                                            padding:
                                                EdgeInsets.only(right: 10.r),
                                            child: IconButton(
                                                icon: Icon(
                                                  controller.hideConfirmPassword
                                                          .value
                                                      ? Icons.visibility_off
                                                      : Icons.visibility,
                                                  color: ColorManager.grey,
                                                ),
                                                onPressed: () {
                                                  controller
                                                      .confirmPasswordHide();
                                                }),
                                          )),
                                      validator: (String? value) {
                                        if (value!.isEmpty) {
                                          return "Password is required";
                                        } else if (value !=
                                            controller
                                                .passwordController.text) {
                                          return "Password does not match";
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
                                  final email =
                                      controller.emailController.text +
                                          "@" +
                                          controller.selectedDomain.value;
                                  final password =
                                      controller.passwordController.text;
                                  print(email);
                                  controller.signUp(email, password);
                                }
                              },
                              style: TextButton.styleFrom(
                                  minimumSize: Size(200.w, 50.h),
                                  backgroundColor: Colors.blue,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(4.r))),
                              child: Text(
                                "Signup",
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                    color: ColorManager.white),
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            RichText(
                              text: TextSpan(
                                  text: "Already have an account? ",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  children: [
                                    TextSpan(
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            Get.offAllNamed(Routes.SIGNIN);
                                          },
                                        text: "Signin",
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
