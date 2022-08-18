import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:temp_mail_task/app/data/models/messages_model.dart';

class MessageDetailsController extends GetxController {
  late final MessagesModel messageDetails = Get.arguments as MessagesModel;
  late final now = DateTime.now();
  late DateTime currentDate, messageDate;
  late String dateTime;
  late final dateFormat = DateFormat('yyyy-MM-dd');
  late final newDateFormat = DateFormat('d MMM');
  late final timeFormat = DateFormat('hh:mm a');

  @override
  void onInit() {
    super.onInit();
    currentDate = DateTime.parse(dateFormat.format(now));
    messageDate = DateTime.parse(dateFormat.format(messageDetails.createdAt));
    if (messageDate.difference(currentDate).inDays == 0) {
      dateTime = timeFormat.format(messageDetails.createdAt);
    } else if (messageDate.difference(currentDate).inDays == -1) {
      dateTime = "Yesterday ";
    } else {
      dateTime = newDateFormat.format(messageDetails.createdAt);
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
