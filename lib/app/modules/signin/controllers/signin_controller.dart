import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:temp_mail_task/app/routes/app_pages.dart';

import '../providers/signin_provider.dart';

class SigninController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final localStorage = GetStorage();
  final isLoading = false.obs;
  final hidePassword = true.obs;

  @override
  void onInit() {
    super.onInit();
  }

  passwordHide() {
    hidePassword.value = !hidePassword.value;
    update();
  }

  signIn(String email, String password) async {
    try {
      isLoading.value = true;
      update();
      await SignInProvider().signIn(email, password).then((value) {
        if (value != null) {
          localStorage.write('token', value.token);
          print(value.token);
          Get.offAllNamed(Routes.HOME);
        } else {
          Fluttertoast.showToast(
            msg: "Something is wrong",
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.black,
            fontSize: 14.0,
            textColor: Colors.white,
            toastLength: Toast.LENGTH_LONG,
          );
        }
      });
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
      update();
    }
  }
}
