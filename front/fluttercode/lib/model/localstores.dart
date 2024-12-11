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
  int? cashback;
  bool? ative;
  String? publishedAt;
  String? createdAt;
  String? updatedAt;
  List<Null>? verifiquedBuyLocalStores;

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
      this.cashback,
      this.ative,
      this.publishedAt,
      this.createdAt,
      this.updatedAt,
      this.verifiquedBuyLocalStores});

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
    cashback = json['cashback'];
    ative = json['ative'];
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
    data['cashback'] = this.cashback;
    data['ative'] = this.ative;
    data['published_at'] = this.publishedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
