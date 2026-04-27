// ignore_for_file: unnecessary_new

class EventCategoriesModel {
  int? status;
  String? message;
  List<CatgoriesData>? data;

  EventCategoriesModel({this.status, this.message, this.data});

  EventCategoriesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <CatgoriesData>[];
      json['data'].forEach((v) {
        data!.add(new CatgoriesData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CatgoriesData {
  String? sId;
  String? categoryName;
  String? banner;
  String? createdAt;
  String? updatedAt;
  int? iV;

  CatgoriesData(
      {this.sId,
      this.categoryName,
      this.banner,
      this.createdAt,
      this.updatedAt,
      this.iV});

  CatgoriesData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    categoryName = json['categoryName'];
    banner = json['banner'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['categoryName'] = categoryName;
    data['banner'] = banner;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}