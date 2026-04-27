class EstimatedPriceModel {
  int? status;
  String? message;
  Data? data;

  EstimatedPriceModel({this.status, this.message, this.data});

  EstimatedPriceModel.fromJson(Map<String, dynamic> json) {
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
  int? baseFare;
  double? fareFromDistance;
  int? fareFromTime;
  int? bookingFee;
  int? adminFee;
  double? totalFare;

  Data(
      {this.baseFare,
      this.fareFromDistance,
      this.fareFromTime,
      this.bookingFee,
      this.adminFee,
      this.totalFare});

  Data.fromJson(Map<String, dynamic> json) {
    baseFare = json['baseFare'];
    fareFromDistance = json['fareFromDistance'];
    fareFromTime = json['fareFromTime'];
    bookingFee = json['bookingFee'];
    adminFee = json['adminFee'];
    totalFare = json['totalFare'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['baseFare'] = baseFare;
    data['fareFromDistance'] = fareFromDistance;
    data['fareFromTime'] = fareFromTime;
    data['bookingFee'] = bookingFee;
    data['adminFee'] = adminFee;
    data['totalFare'] = totalFare;
    return data;
  }
}