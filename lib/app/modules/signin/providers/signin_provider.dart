import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../core/utils/api_link.dart';
import '../../../data/models/signin_model.dart';

class SignInProvider extends GetConnect {
  Future<SigninModel?> signIn(String address, String password) async {
    var url = Uri.parse('${ApiLink.API_LINK}token');
    Map<String, dynamic> body = {"address": address, "password": password};

    final response = await http.post(url,
        body: json.encode(body), headers: {"Content-Type": "application/json"});

    print(response.statusCode);
    var jsonData = json.decode(response.body);
    if (response.statusCode == 200) {
      return SigninModel.fromJson(jsonData);
    } else {
      return null;
    }
  }
}
