import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../routes/app_pages.dart';

enum AuthStatus { NOT_LOGGED_IN, LOGGED_IN }

class SplashController extends GetxController {
  AuthStatus authStatus = AuthStatus.NOT_LOGGED_IN;
  final localStorage = GetStorage();

  @override
  void onInit() {
    super.onInit();
    if (localStorage.read('token') == null) {
      authStatus = AuthStatus.NOT_LOGGED_IN;
    } else {
      authStatus = AuthStatus.LOGGED_IN;
    }
    changePage();
  }

  changePage() {
    Future.delayed(const Duration(seconds: 3), () {
      switch (authStatus) {
        case AuthStatus.NOT_LOGGED_IN:
          Get.offAllNamed(Routes.SIGNIN);
          break;
        case AuthStatus.LOGGED_IN:
          Get.offAllNamed(Routes.INBOX);
          break;
      }
    });
  }
}
