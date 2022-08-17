import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../core/utils/api_link.dart';
import '../../../data/models/messages_list_model.dart';

class MessagesProvider extends GetConnect {
  Future<MessagesListModel?> getMessagesData(var token) async {
    final response = await http.get(Uri.parse("${ApiLink.API_LINK}messages"),
        headers: {
          "Authorization": 'Bearer $token',
          "Content-Type": "application/json"
        });

    print(response.statusCode);
    var jsonData = json.decode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return MessagesListModel.fromJson(jsonData);
    } else {
      return null;
    }
  }
}
