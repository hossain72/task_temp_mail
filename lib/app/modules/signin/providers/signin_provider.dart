import 'dart:convert';

import 'package:get/get.dart';

import '../../../core/constants/api_link.dart';
import '../../../data/models/signin_model.dart';

class SignInProvider extends GetConnect {
  Future<SigninModel?> signIn(String address, String password) async {
    Map<String, dynamic> body = {"address": address, "password": password};
    Map<String, String> headers = {"Content-Type": "application/json"};

    final response = await post('${ApiLink.API_LINK}token', json.encode(body),
        headers: headers);

    if (response.statusCode == 200) {
      return SigninModel.fromJson(response.body);
    } else {
      return null;
    }
  }
}
