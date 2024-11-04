class Plans {
  int? id;
  String? name;
  String? desc;
  String? benefits;
  String? rules;
  double? value;
  String? color;
  String? publishedAt;
  String? createdAt;
  String? updatedAt;
  List<Null>? profiles;
  List<LocalStores>? localStores;

  Plans(
      {this.id,
      this.name,
      this.desc,
      this.benefits,
      this.rules,
      this.value,
      this.color,
      this.publishedAt,
      this.createdAt,
      this.updatedAt,
      this.profiles,
      this.localStores});

  Plans.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    desc = json['desc'];
    benefits = json['benefits'];
    rules = json['rules'];
    value = json['value'];
    color = json['color'];
    publishedAt = json['published_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['local_stores'] != null) {
      localStores = <LocalStores>[];
      json['local_stores'].forEach((v) {
        localStores!.add(new LocalStores.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['desc'] = this.desc;
    data['benefits'] = this.benefits;
    data['rules'] = this.rules;
    data['value'] = this.value;
    data['color'] = this.color;
    data['published_at'] = this.publishedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.localStores != null) {
      data['local_stores'] = this.localStores!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LocalStores {
  int? id;
  String? name;
  String? rules;
  String? localization;
  String? phone;
  String? urllogo;
  String? code;
  int? cep;
  String? benefit;
  Null? verifiqued;
  String? publishedAt;
  String? createdAt;
  String? updatedAt;

  LocalStores(
      {this.id,
      this.name,
      this.rules,
      this.localization,
      this.phone,
      this.urllogo,
      this.code,
      this.cep,
      this.benefit,
      this.verifiqued,
      this.publishedAt,
      this.createdAt,
      this.updatedAt});

  LocalStores.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    rules = json['rules'];
    localization = json['localization'];
    phone = json['phone'];
    urllogo = json['urllogo'];
    code = json['code'];
    cep = json['cep'];
    benefit = json['benefit'];
    verifiqued = json['verifiqued'];
    publishedAt = json['published_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['rules'] = this.rules;
    data['localization'] = this.localization;
    data['phone'] = this.phone;
    data['urllogo'] = this.urllogo;
    data['code'] = this.code;
    data['cep'] = this.cep;
    data['benefit'] = this.benefit;
    data['verifiqued'] = this.verifiqued;
    data['published_at'] = this.publishedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
