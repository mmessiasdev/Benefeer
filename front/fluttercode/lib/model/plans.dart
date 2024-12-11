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
  List<Profiles>? profiles;
  List<PlanStores>? planStores;

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
      this.planStores});

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
    if (json['profiles'] != null) {
      profiles = <Profiles>[];
      json['profiles'].forEach((v) {
        profiles!.add(new Profiles.fromJson(v));
      });
    }
    if (json['plan_stores'] != null) {
      planStores = <PlanStores>[];
      json['plan_stores'].forEach((v) {
        planStores!.add(new PlanStores.fromJson(v));
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
    if (this.profiles != null) {
      data['profiles'] = this.profiles!.map((v) => v.toJson()).toList();
    }
    if (this.planStores != null) {
      data['plan_stores'] = this.planStores!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Profiles {
  int? id;
  String? email;
  int? user;
  String? fullname;
  int? plan;
  String? publishedAt;
  String? createdAt;
  String? updatedAt;

  Profiles(
      {this.id,
      this.email,
      this.user,
      this.fullname,
      this.plan,
      this.publishedAt,
      this.createdAt,
      this.updatedAt});

  Profiles.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    user = json['user'];
    fullname = json['fullname'];
    plan = json['plan'];
    publishedAt = json['published_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['user'] = this.user;
    data['fullname'] = this.fullname;
    data['plan'] = this.plan;
    data['published_at'] = this.publishedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class PlanStores {
  int? id;
  String? name;
  String? desc;
  String? benefits;
  Null? profile;
  int? plan;
  String? urlLogo;
  String? publishedAt;
  String? createdAt;
  String? updatedAt;

  PlanStores(
      {this.id,
      this.name,
      this.desc,
      this.benefits,
      this.profile,
      this.plan,
      this.urlLogo,
      this.publishedAt,
      this.createdAt,
      this.updatedAt});

  PlanStores.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    desc = json['desc'];
    benefits = json['benefits'];
    profile = json['profile'];
    plan = json['plan'];
    urlLogo = json['urlLogo'];
    publishedAt = json['published_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['desc'] = this.desc;
    data['benefits'] = this.benefits;
    data['profile'] = this.profile;
    data['plan'] = this.plan;
    data['urlLogo'] = this.urlLogo;
    data['published_at'] = this.publishedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
