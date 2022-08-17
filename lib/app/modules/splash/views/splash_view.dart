import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../controllers/splash_controller.dart';
import '../../../core/theme/assets_image_manager.dart';

class SplashView extends GetView<SplashController> {
  final controller = Get.find<SplashController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 80.w,
          height: 80.h,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.r),
              image: const DecorationImage(
                  image: AssetImage(AssetImageManager.logoImage),
                  fit: BoxFit.fill)),
        ),
      ),
    );
  }
}
