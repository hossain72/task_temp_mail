import 'dart:convert';

import 'package:get/get.dart';

import '../../../core/constants/api_link.dart';
import '../../../data/models/domain_list_model.dart';

class DomainListProvider extends GetConnect {
  Future<DomainListModel?> getDomains() async {
    final response = await get('${ApiLink.API_LINK}domains',
        headers: {"Content-Type": "application/json"});

    var jsonData = json.decode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return DomainListModel.fromJson(jsonData);
    } else {
      return null;
    }
  }
}
