import 'package:get/get.dart';

import '../modules/inbox/bindings/inbox_binding.dart';
import '../modules/inbox/views/inbox_view.dart';
import '../modules/message_details/bindings/message_details_binding.dart';
import '../modules/message_details/views/message_details_view.dart';
import '../modules/signin/bindings/signin_binding.dart';
import '../modules/signin/views/signin_view.dart';
import '../modules/signup/bindings/signup_binding.dart';
import '../modules/signup/views/signup_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.SIGNUP,
      page: () => SignupView(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: _Paths.SIGNIN,
      page: () => SigninView(),
      binding: SigninBinding(),
    ),
    GetPage(
      name: _Paths.INBOX,
      page: () => InboxView(),
      binding: InboxBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.MESSAGE_DETAILS,
      page: () => MessageDetailsView(),
      binding: MessageDetailsBinding(),
    ),
  ];
}
