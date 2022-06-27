import 'package:efood_multivendor/data/api/api_client.dart';
import 'package:efood_multivendor/util/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/response/response.dart';

class OrgRepo {
  final ApiClient apiClient;
  OrgRepo({@required this.apiClient});

  Future<Response> getOrgList(int userId) async {
    return await apiClient.getData('${AppConstants.ORG_URI}');
  }
}
