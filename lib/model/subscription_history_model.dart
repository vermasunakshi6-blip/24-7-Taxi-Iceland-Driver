class SubscriptionHistoryModel {
  int? status;
  String? message;
  List<UserHistory>? userHistory;

  SubscriptionHistoryModel({this.status, this.message, this.userHistory});

  SubscriptionHistoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['userHistory'] != null) {
      userHistory = <UserHistory>[];
      json['userHistory'].forEach((v) {
        userHistory!.add(UserHistory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (userHistory != null) {
      data['userHistory'] = userHistory!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserHistory {
  String? sId;
  String? userId;
  String? price;
  String? packageDate;
  String? type;
  String? validate;
  int? status;
  String? createdAt;
  String? updatedAt;
  int? iV;

  UserHistory(
      {this.sId,
      this.userId,
      this.price,
      this.packageDate,
      this.type,
      this.validate,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.iV});

  UserHistory.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    price = json['price'];
    packageDate = json['packageDate'];
    type = json['type'];
    validate = json['validate'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['userId'] = userId;
    data['price'] = price;
    data['packageDate'] = packageDate;
    data['type'] = type;
    data['validate'] = validate;
    data['status'] = status;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}