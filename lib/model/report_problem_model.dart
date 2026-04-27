class ReportProblemModel {
  int? status;
  String? message;
  Data? data;

  ReportProblemModel({this.status, this.message, this.data});

  ReportProblemModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ?  Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? userId;
  String? issue;
  String? description;
  String? image;
  String? sId;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Data(
      {this.userId,
      this.issue,
      this.description,
      this.image,
      this.sId,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    issue = json['issue'];
    description = json['description'];
    image = json['image'];
    sId = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['userId'] = userId;
    data['issue'] = issue;
    data['description'] = description;
    data['image'] = image;
    data['_id'] = sId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}