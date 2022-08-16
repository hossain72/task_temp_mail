import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../providers/domain_list_provider.dart';
import '../providers/signup_provider.dart';

class SignupController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final hidePassword = true.obs;
  final hideConfirmPassword = true.obs;
  final isLoading = false.obs;
  List<String> domainLists = [];
  final selectedDomain = "".obs;

  @override
  void onInit() {
    super.onInit();
    getDomainList();
  }

  passwordHide() {
    hidePassword.value = !hidePassword.value;
    update();
  }

  confirmPasswordHide() {
    hideConfirmPassword.value = !hideConfirmPassword.value;
    update();
  }

  changeValue(String value) {
    selectedDomain.value = value;
    update();
  }

  getDomainList() async {
    try {
      isLoading.value = true;
      update();
      await DomainListProvider().getDomains().then((value) {
        value!.hydraMember.asMap().forEach((key, value) {
          if (value.isActive == true) {
            domainLists.add(value.domain);
          }
        });
      });
      selectedDomain.value = domainLists[0];
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
      update();
    }
  }

  signUp(String email, String password) async {
    try {
      isLoading.value = true;
      update();
      await SignupProvider().signUp(email, password).then((value) {
        if (value.context != "/contexts/ConstraintViolationList") {
          Fluttertoast.showToast(
            msg: "Account has been created successfully.",
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.black,
            fontSize: 14.0,
            textColor: Colors.white,
            toastLength: Toast.LENGTH_LONG,
          );
          Get.offAndToNamed('/signin');
        } else if (value.context == "/contexts/ConstraintViolationList") {
          Fluttertoast.showToast(
            msg: value.hydraDescription.toString(),
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.black,
            fontSize: 14.0,
            textColor: Colors.white,
            toastLength: Toast.LENGTH_LONG,
          );
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
