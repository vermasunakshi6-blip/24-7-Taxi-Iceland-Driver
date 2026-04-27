class TotalRewardsModel {
  int? status;
  String? message;
  Errors? errors;
  TotalData? data;

  TotalRewardsModel({this.status, this.message, this.data,this.errors});

  TotalRewardsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    errors =
        json['errors'] != null ? Errors.fromJson(json['errors']) : null;
    data = json['data'] != null ? TotalData.fromJson(json['data']) : null;
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
class TotalData {
  String? currency;
  dynamic totalAmount;
  dynamic cryptoPrice;

  TotalData({this.currency, this.totalAmount, this.cryptoPrice});

  TotalData.fromJson(Map<String, dynamic> json) {
    currency = json['currency'];
    totalAmount = json['totalAmount'];
    cryptoPrice = json['cryptoPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['currency'] = currency;
    data['totalAmount'] = totalAmount;
    data['cryptoPrice'] = cryptoPrice;
    return data;
  }
}