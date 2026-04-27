class GetSavedAddressesModel {
  int? status;
  String? message;
  List<AddressData>? data;

  GetSavedAddressesModel({this.status, this.message, this.data});

  GetSavedAddressesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <AddressData>[];
      json['data'].forEach((v) {
        data!.add(AddressData.fromJson(v));
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

class AddressData {
  String? sId;
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
  String? createdAt;
  String? updatedAt;
  int? iV;

  AddressData(
      {this.sId,
      this.userId,
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
      this.createdAt,
      this.updatedAt,
      this.iV});

  AddressData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
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
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
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
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}