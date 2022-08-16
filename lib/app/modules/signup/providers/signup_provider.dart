import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../core/utils/api_link.dart';
import '../../../data/models/signup_model.dart';

class SignupProvider extends GetConnect {
  Future<dynamic> signUp(String address, String password) async {
    var url = Uri.parse('${ApiLink.API_LINK}accounts');
    Map<String, dynamic> body = {"address": address, "password": password};

    final response = await http.post(url,
        body: json.encode(body), headers: {"Content-Type": "application/json"});

    print(response.statusCode);
    var jsonData = json.decode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return SignupModel.fromJson(jsonData);
    } else if (response.statusCode == 400 || response.statusCode == 422) {
      return null;
    } else {
      return null;
    }
  }
}
