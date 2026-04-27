class WalletBalanceModel {
  int? status;
  String? message;
  String? currencySymbol;
  Object? totalPrice;

  WalletBalanceModel(
      {this.status, this.message, this.currencySymbol, this.totalPrice});

  WalletBalanceModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    currencySymbol = json['currencySymbol'];
    totalPrice = json['totalPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['currencySymbol'] = currencySymbol;
    data['totalPrice'] = totalPrice;
    return data;
  }
}
