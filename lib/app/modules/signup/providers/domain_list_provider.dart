import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../core/utils/api_link.dart';
import '../../../data/models/domain_list_model.dart';

class DomainListProvider extends GetConnect {
  Future<DomainListModel?> getDomains() async {
    var url = Uri.parse('${ApiLink.API_LINK}domains');

    final response =
        await http.get(url, headers: {"Content-Type": "application/json"});

    var jsonData = json.decode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return DomainListModel.fromJson(jsonData);
    } else {
      return null;
    }
  }
}
