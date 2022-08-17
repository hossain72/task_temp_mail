import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../routes/app_pages.dart';
import '../providers/messages_provider.dart';
import '../../../data/models/messages_model.dart';

class InboxController extends GetxController {
  final localStorage = GetStorage();
  final messagesList = <MessagesModel>[].obs;
  final token = ''.obs;
  final isLoading = false.obs;

  @override
  void onInit() async {
    super.onInit();
    token.value = localStorage.read('token');
    update();
    await getMessages();
  }

  getMessages() async {
    try {
      isLoading.value = true;
      update();
      await MessagesProvider().getMessagesData(token.value).then((value) {
        if (value!.hydraMember.isNotEmpty) {
          value.hydraMember.asMap().forEach((key, value) {
            MessagesModel messagesModel = MessagesModel(
                value.id,
                value.type,
                value.hydraMemberId,
                value.accountId,
                value.msgid,
                value.from,
                value.to,
                value.subject,
                value.intro,
                value.seen,
                value.isDeleted,
                value.hasAttachments,
                value.size,
                value.downloadUrl,
                value.createdAt,
                value.updatedAt);
            messagesList.add(messagesModel);
            update();
          });
        } else {
          Fluttertoast.showToast(
            msg: "No Messages",
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

  getRefreshMessage() async {
    try {
      isLoading.value = true;
      messagesList.clear();
      update();
      await MessagesProvider().getMessagesData(token.value).then((value) {
        if (value!.hydraMember.isNotEmpty) {
          value.hydraMember.asMap().forEach((key, value) {
            MessagesModel messagesModel = MessagesModel(
                value.id,
                value.type,
                value.hydraMemberId,
                value.accountId,
                value.msgid,
                value.from,
                value.to,
                value.subject,
                value.intro,
                value.seen,
                value.isDeleted,
                value.hasAttachments,
                value.size,
                value.downloadUrl,
                value.createdAt,
                value.updatedAt);
            messagesList.add(messagesModel);
            update();
          });
        } else {
          Fluttertoast.showToast(
            msg: "No Messages",
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

  logOut() {
    localStorage.remove('token');
    Get.offAllNamed(Routes.SIGNIN);
  }
}
