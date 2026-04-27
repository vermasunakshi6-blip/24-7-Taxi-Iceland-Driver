class SplitAmountModel {
  int? status;
  String? message;
  List<Data>? data;

  SplitAmountModel({this.status, this.message, this.data});

  SplitAmountModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
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

class Data {
  String? name;
  String? number;
  Location? location;
  String? amountPaid;
  String? tokenType;

  Data(
      {this.name, this.number, this.location, this.amountPaid, this.tokenType});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    number = json['number'];
    location = json['location'] != null
        ?  Location.fromJson(json['location'])
        : null;
    amountPaid = json['price'];
    tokenType = json['tokenType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['number'] = number;
    if (location != null) {
      data['location'] = location!.toJson();
    }
    data['price'] = amountPaid;
    data['tokenType'] = tokenType;
    return data;
  }
}

class Location {
  String? address;
  double? lat;
  double? lng;
  String? pickup;

  Location({this.address, this.lat, this.lng, this.pickup});

  Location.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    lat = json['lat'];
    lng = json['lng'];
    pickup = json['pickup'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['address'] = address;
    data['lat'] = lat;
    data['lng'] = lng;
    data['pickup'] = pickup;
    return data;
  }
}