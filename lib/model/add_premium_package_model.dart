class AddPremiumPackageModel {
  int? status;
  String? message;
  Errors? errors;
  Data? data;

  AddPremiumPackageModel({this.status, this.message, this.data, this.errors});

  AddPremiumPackageModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    errors =
        json['errors'] != null ? Errors.fromJson(json['errors']) : null;
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (errors != null) {
      data['errors'] = errors!.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? userId;
  String? price;
  String? packageDate;
  String? type;
  String? validate;
  int? status;
  String? sId;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Data(
      {this.userId,
      this.price,
      this.packageDate,
      this.type,
      this.validate,
      this.status,
      this.sId,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    price = json['price'];
    packageDate = json['packageDate'];
    type = json['type'];
    validate = json['validate'];
    status = json['status'];
    sId = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['price'] = price;
    data['packageDate'] = packageDate;
    data['type'] = type;
    data['validate'] = validate;
    data['status'] = status;
    data['_id'] = sId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
  
}
class Errors {
  String? views;

  Errors({this.views});

  Errors.fromJson(Map<String, dynamic> json) {
    views = json['views'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['views'] = views;
    return data;
  }
}