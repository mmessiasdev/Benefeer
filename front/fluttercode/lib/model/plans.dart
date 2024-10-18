import 'package:flutter/material.dart';

class Plans {
  int? id;
  String? name;
  String? desc;
  double? value;
  String? benefits;
  String? rules;
  String? publishedAt;
  String? createdAt;
  String? updatedAt;
  List<LocalStores>? localStores;

  Plans(
      {this.id,
      this.name,
      this.desc,
      this.value,
      this.benefits,
      this.rules,
      this.publishedAt,
      this.createdAt,
      this.updatedAt,
      this.localStores});

  Plans.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    desc = json['desc'];
    value = json['value'];
    benefits = json['benefits'];
    rules = json['rules'];
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
    data['value'] = this.value;
    data['benefits'] = this.benefits;
    data['rules'] = this.rules;
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
  String? cEP;
  String? benefit;
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
      this.cEP,
      this.benefit,
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
    cEP = json['CEP'];
    benefit = json['benefit'];
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
    data['CEP'] = this.cEP;
    data['benefit'] = this.benefit;
    data['published_at'] = this.publishedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
