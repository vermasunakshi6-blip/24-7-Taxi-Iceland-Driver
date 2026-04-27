class GetReportReasonModel {
  int? status;
  String? message;
  List<ReasonsData>? data;

  GetReportReasonModel({this.status, this.message, this.data});

  GetReportReasonModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ReasonsData>[];
      json['data'].forEach((v) {
        data!.add(ReasonsData.fromJson(v));
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

class ReasonsData {
  String? sId;
  String? titleid;
  String? question;
  String? createdAt;
  String? updatedAt;
  int? iV;

  ReasonsData(
      {this.sId,
      this.titleid,
      this.question,
      this.createdAt,
      this.updatedAt,
      this.iV});

  ReasonsData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    titleid = json['titleid'];
    question = json['question'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['titleid'] = titleid;
    data['question'] = question;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}