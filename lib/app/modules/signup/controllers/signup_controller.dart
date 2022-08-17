import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:temp_mail_task/app/routes/app_pages.dart';

import '../providers/signup_provider.dart';
import '../providers/domain_list_provider.dart';

class SignupController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final isLoading = false.obs;
  final hidePassword = true.obs;
  final hideConfirmPassword = true.obs;
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
      await SignupProvider().signUp(email, password).then((value) async {
        if (value.context != "/contexts/ConstraintViolationList") {
          await sendMail(email);
          Fluttertoast.showToast(
            msg: "Account has been created successfully.",
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.black,
            fontSize: 14.0,
            textColor: Colors.white,
            toastLength: Toast.LENGTH_LONG,
          );
          Get.offAndToNamed(Routes.SIGNIN);
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

  Future sendMail(String mail) async {
    String username = 'bdanohos1@gmail.com';
    String password = 'ximevbxbogxdotei';

    final smtpServer = gmail(username, password);

    final message = Message()
      ..from = Address(username, 'Anowar Hossain')
      ..recipients.add(mail)
      ..subject = 'Account Create'
      ..text = 'Your account has been created.';

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent.$e');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
  }
}
