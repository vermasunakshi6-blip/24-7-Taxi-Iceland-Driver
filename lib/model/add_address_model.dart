class AddAddressModel {
  int? status;
  String? message;
  Data? data;

  AddAddressModel({this.status, this.message, this.data});

  AddAddressModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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
  String? address;
  String? aptSuite;
  String? country;
  String? state;
  String? cityProvince;
  String? zipcode;
  String? addressName;
  String? latitude;
  String? longitude;
  int? isDefault;
  String? sId;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Data(
      {this.userId,
      this.address,
      this.aptSuite,
      this.country,
      this.state,
      this.cityProvince,
      this.zipcode,
      this.addressName,
      this.latitude,
      this.longitude,
      this.isDefault,
      this.sId,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    address = json['address'];
    aptSuite = json['aptSuite'];
    country = json['country'];
    state = json['state'];
    cityProvince = json['cityProvince'];
    zipcode = json['zipcode'];
    addressName = json['addressName'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    isDefault = json['isDefault'];
    sId = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['address'] = address;
    data['aptSuite'] = aptSuite;
    data['country'] = country;
    data['state'] = state;
    data['cityProvince'] = cityProvince;
    data['zipcode'] = zipcode;
    data['addressName'] = addressName;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['isDefault'] = isDefault;
    data['_id'] = sId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}