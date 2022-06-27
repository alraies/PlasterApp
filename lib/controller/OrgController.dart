import 'package:efood_multivendor/data/model/response/org_model.dart';
import 'package:efood_multivendor/data/repository/org_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../data/api/api_checker.dart';
import '../helper/date_converter.dart';

class OrgController extends GetxController implements GetxService {
  final OrgRepo orgRepo;
  OrgController({@required this.orgRepo});
  List<OrgModel> _orgList;
  List<OrgModel> get orgList => _orgList;

  Future<void> getOrgList(bool reload) async {
    if (_orgList == null || reload) {
      Response response = await orgRepo.getOrgList(1);
      if (response.statusCode == 200) {
        _orgList = [];

        response.body.forEach((org) {
          _orgList.add(OrgModel.fromJson(org));
        });
      } else {
        ApiChecker.checkApi(response);
      }
      update();
    }
  }
}
