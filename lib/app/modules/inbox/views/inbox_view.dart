import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'widgets/message_info_widget.dart';
import '../controllers/inbox_controller.dart';
import '../../../core/constants/color_manager.dart';

class InboxView extends GetView<InboxController> {
  @override
  Widget build(BuildContext context) {
    final width = ScreenUtil().screenWidth;
    final height = ScreenUtil().screenHeight;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          title: Text(
            "Inbox",
            style: TextStyle(
                color: Colors.blue, fontSize: 22.sp, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () => controller.getRefreshMessage(),
              icon: const Icon(
                Icons.refresh,
                color: Colors.blue,
              ),
            ),
            IconButton(
              onPressed: () => controller.logOut(),
              icon: const Icon(
                Icons.logout,
                color: Colors.red,
              ),
            ),
          ],
        ),
        body: Obx(() => controller.isLoading.value == true
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : controller.messagesList.isEmpty
                ? const Center(
                    child: Text(
                      "No Messages",
                      style: TextStyle(fontSize: 22),
                    ),
                  )
                : Container(
                    width: width,
                    height: height,
                    color: ColorManager.white,
                    child: ListView.separated(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        padding: EdgeInsets.all(16.r),
                        separatorBuilder: (_, int index) =>
                            SizedBox(height: 10.h),
                        itemCount: controller.messagesList.length,
                        itemBuilder: (_, index) => MessageInfoWidget(
                              messagesModel: controller.messagesList[index],
                            )),
                  )));
  }
}
