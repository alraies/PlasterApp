class OrgModel {
  int _orgId;
  String _OrgName;
  String _photo;
  String _Notes;
  int _IsActive;

  OrgModel(
      {int orgId, String OrgName, String photo, String Notes, int IsActive}) {
    this._orgId = orgId;
    this._OrgName = OrgName;
    this._photo = photo;
    this._Notes = Notes;
    this._IsActive = IsActive;
  }

  int get orgId => _orgId;
  String get OrgName => _OrgName;
  String get photo => _photo;
  String get Notes => _Notes;
  int get IsActive => _IsActive;

  OrgModel.fromJson(Map<String, dynamic> json) {
    _orgId = json['orgId'];
    _OrgName = json['OrgName'];
    _photo = json['photo'];
    _Notes = json['Notes'];
    _IsActive = json['IsActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orgId'] = this._orgId;
    data['OrgName'] = this._OrgName;
    data['photo'] = this._photo;
    data['Notes'] = this._Notes;
    data['IsActive'] = this._IsActive;

    return data;
  }
}
