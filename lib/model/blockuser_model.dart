class BlockUserModel {
  int? status;
  BlockData? data;
  String? message;

  BlockUserModel({this.status, this.data, this.message});

  BlockUserModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? BlockData.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    return data;
  }
}

class BlockData {
  String? sId;
  String? userId;
  String? blockUserId;
  int? status;
  String? createdAt;
  String? updatedAt;
  int? iV;

  BlockData(
      {this.sId,
      this.userId,
      this.blockUserId,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.iV});

  BlockData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    blockUserId = json['blockUserId'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['userId'] = userId;
    data['blockUserId'] = blockUserId;
    data['status'] = status;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}