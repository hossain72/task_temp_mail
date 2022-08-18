import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/color_manager.dart';
import '../controllers/message_details_controller.dart';

class MessageDetailsView extends GetView<MessageDetailsController> {
  final controller = Get.find<MessageDetailsController>();

  @override
  Widget build(BuildContext context) {
    final width = ScreenUtil().screenWidth;
    final height = ScreenUtil().screenHeight;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ColorManager.white,
        title: Text(
          'Message',
          style: TextStyle(
              color: Colors.blue, fontSize: 22.sp, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(
              Icons.arrow_back,
              color: ColorManager.black,
            )),
        centerTitle: true,
      ),
      body: Container(
        width: width,
        height: height,
        color: ColorManager.white,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16..r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  controller.messageDetails.subject,
                  style:
                      TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      controller.messageDetails.from.name,
                      style: TextStyle(
                          fontSize: 16.sp, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      controller.dateTime,
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: ColorManager.grey),
                    )
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  controller.messageDetails.intro,
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: ColorManager.grey),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
