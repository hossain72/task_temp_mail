import 'dart:convert';

import 'package:get/get.dart';

import '../../../data/signup_error_model.dart';
import '../../../core/constants/api_link.dart';
import '../../../data/models/signup_model.dart';

class SignupProvider extends GetConnect {
  Future<dynamic> signUp(String address, String password) async {
    Map<String, dynamic> body = {"address": address, "password": password};
    Map<String, String> header = {"Content-Type": "application/json"};

    final response = await post('${ApiLink.API_LINK}accounts', jsonEncode(body),
        headers: header);

    var jsonData = jsonDecode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return SignupModel.fromJson(jsonData);
    } else if (response.statusCode == 400 || response.statusCode == 422) {
      return SignupErrorModel.fromJson(jsonData);
    } else {
      return null;
    }
  }
}
