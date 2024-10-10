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
    id = json['online_stores']['id'];
    name = json['online_stores']['name'];
    desc = json['online_stores']['desc'];
    afflink = json['online_stores']['afflink'];
    percentcashback = json['online_stores']['percentcashback'];
    logourl = json['online_stores']['logourl'];
    createdAt = json['online_stores']['created_at'];
    updatedAt = json['online_stores']['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['online_stores']['id'] = this.id;
    data['online_stores']['name'] = this.name;
    data['online_stores']['desc'] = this.desc;
    data['online_stores']['afflink'] = this.afflink;
    data['online_stores']['percentcashback'] = this.percentcashback;
    data['online_stores']['logourl'] = this.logourl;
    data['online_stores']['created_at'] = this.createdAt;
    data['online_stores']['updated_at'] = this.updatedAt;
    return data;
  }
}
