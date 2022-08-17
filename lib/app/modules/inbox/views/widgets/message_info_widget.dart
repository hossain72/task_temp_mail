import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../data/models/messages_model.dart';
import '../../../../core/constants/color_manager.dart';


class MessageInfoWidget extends StatelessWidget {
  final MessagesModel messagesModel;

  const MessageInfoWidget({Key? key, required this.messagesModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: ListTile(
        title: Row(
          children: [
            Text(
              messagesModel.from.name,
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 6.w,
            ),
            Text(
              "<${messagesModel.from.address}>",
              style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: ColorManager.grey),
            ),
          ],
        ),
        subtitle: Text(messagesModel.subject),
      ),
    );
  }
}
