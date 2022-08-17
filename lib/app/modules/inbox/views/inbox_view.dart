import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'widgets/message_info_widget.dart';

import '../controllers/inbox_controller.dart';

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
          title: const Text(
            "Inbox",
            style: TextStyle(
                color: Colors.blue, fontSize: 22, fontWeight: FontWeight.bold),
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
                    padding: EdgeInsets.all(16.r),
                    child: ListView.separated(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        separatorBuilder: (_, int index) {
                          return SizedBox(height: 10.h);
                        },
                        itemCount: controller.messagesList.length,
                        itemBuilder: (_, index) {
                          return MessageInfoWidget(
                            messagesModel: controller.messagesList[index],
                          );
                        }),
                  )));
  }
}
