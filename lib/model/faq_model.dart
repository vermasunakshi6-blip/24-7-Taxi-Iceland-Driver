class FaqModel {
  int? status;
  String? message;
  List<FaqData>? data;

  FaqModel({this.status, this.message, this.data});

  FaqModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <FaqData>[];
      json['data'].forEach((v) {
        data!.add(FaqData.fromJson(v));
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

class FaqData {
  String? sId;
  String? faqid;
  String? question;
  String? answer;
  String? createdAt;
  String? updatedAt;
  int? iV;

  FaqData(
      {this.sId,
      this.faqid,
      this.question,
      this.answer,
      this.createdAt,
      this.updatedAt,
      this.iV});

  FaqData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    faqid = json['faqid'];
    question = json['question'];
    answer = json['answer'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['faqid'] = faqid;
    data['question'] = question;
    data['answer'] = answer;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}