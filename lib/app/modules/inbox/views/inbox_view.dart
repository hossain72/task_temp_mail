import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:temp_mail_task/app/core/theme/color_manager.dart';

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
              icon: Icon(
                Icons.refresh,
                color: Colors.blue,
              ),
            ),
            IconButton(
              onPressed: () {
                controller.logOut();
              },
              icon: Icon(
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
                          return Card(
                            elevation: 10,
                            child: ListTile(
                              title: Row(
                                children: [
                                  Text(
                                    controller.messagesList[index].from.name,
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    width: 6.w,
                                  ),
                                  Text(
                                    "<${controller.messagesList[index].from.address}>",
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                        color: ColorManager.grey),
                                  ),
                                ],
                              ),
                              subtitle:
                                  Text(controller.messagesList[index].subject),
                            ),
                          );
                        }),
                  )));
  }
}
