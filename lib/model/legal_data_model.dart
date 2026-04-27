class LegalDataModel {
  int? status;
  String? message;
  List<LegalData>? data;

  LegalDataModel({this.status, this.message, this.data});

  LegalDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <LegalData>[];
      json['data'].forEach((v) {
        data!.add( LegalData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LegalData {
  String? sId;
  String? title;
  String? content;
  String? createdAt;
  String? updatedAt;
  int? iV;

  LegalData(
      {this.sId,
      this.title,
      this.content,
      this.createdAt,
      this.updatedAt,
      this.iV});

  LegalData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    content = json['content'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['_id'] = sId;
    data['title'] = title;
    data['content'] = content;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}