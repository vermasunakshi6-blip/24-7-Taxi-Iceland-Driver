class FaqTitlesModel {
  int? status;
  String? message;
  List<FaqTitleData>? data;

  FaqTitlesModel({this.status, this.message, this.data});

  FaqTitlesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <FaqTitleData>[];
      json['data'].forEach((v) {
        data!.add(FaqTitleData.fromJson(v));
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

class FaqTitleData {
  String? sId;
  String? id;
  String? title;
  String? createdAt;
  String? updatedAt;
  int? iV;

  FaqTitleData(
      {this.sId, this.id, this.title, this.createdAt, this.updatedAt, this.iV});

  FaqTitleData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    id = json['id'];
    title = json['title'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['id'] = id;
    data['title'] = title;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}