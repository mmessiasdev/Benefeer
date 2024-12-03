class CarrouselBannerModel {
  int? id;
  String? title;
  String? desc;
  String? publishedAt;
  String? createdAt;
  String? updatedAt;
  List<Banners>? banners;

  CarrouselBannerModel(
      {this.id,
      this.title,
      this.desc,
      this.publishedAt,
      this.createdAt,
      this.updatedAt,
      this.banners});

  CarrouselBannerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    desc = json['desc'];
    publishedAt = json['published_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['banners'] != null) {
      banners = <Banners>[];
      json['banners'].forEach((v) {
        banners!.add(new Banners.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['desc'] = this.desc;
    data['published_at'] = this.publishedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.banners != null) {
      data['banners'] = this.banners!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Banners {
  int? id;
  String? title;
  String? urlimage;
  String? urlroute;
  String? publishedAt;
  String? createdAt;
  String? updatedAt;

  Banners(
      {this.id,
      this.title,
      this.urlimage,
      this.urlroute,
      this.publishedAt,
      this.createdAt,
      this.updatedAt});

  Banners.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    urlimage = json['urlimage'];
    urlroute = json['urlroute'];
    publishedAt = json['published_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['urlimage'] = this.urlimage;
    data['urlroute'] = this.urlroute;
    data['published_at'] = this.publishedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
