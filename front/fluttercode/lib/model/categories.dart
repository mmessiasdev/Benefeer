class CategoriesModel {
  int? id;
  String? name;
  OnlineStore? onlineStore;
  String? illustrationurl;
  String? createdAt;
  String? updatedAt;

  CategoriesModel(
      {this.id,
      this.name,
      this.onlineStore,
      this.illustrationurl,
      this.createdAt,
      this.updatedAt});

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    onlineStore = json['online_store'] != null
        ? new OnlineStore.fromJson(json['online_store'])
        : null;
    illustrationurl = json['illustrationurl'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.onlineStore != null) {
      data['online_store'] = this.onlineStore!.toJson();
    }
    data['illustrationurl'] = this.illustrationurl;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class OnlineStore {
  int? id;
  String? name;
  String? desc;
  String? afflink;
  int? percentcashback;
  String? logourl;
  String? createdAt;
  String? updatedAt;

  OnlineStore(
      {this.id,
      this.name,
      this.desc,
      this.afflink,
      this.percentcashback,
      this.logourl,
      this.createdAt,
      this.updatedAt});

  OnlineStore.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    desc = json['desc'];
    afflink = json['afflink'];
    percentcashback = json['percentcashback'];
    logourl = json['logourl'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['desc'] = this.desc;
    data['afflink'] = this.afflink;
    data['percentcashback'] = this.percentcashback;
    data['logourl'] = this.logourl;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
