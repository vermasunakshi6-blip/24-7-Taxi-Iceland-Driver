class SendShareRideRequestModel {
  int? status;
  String? message;
  Data? data;

  SendShareRideRequestModel({this.status, this.message, this.data});

  SendShareRideRequestModel.fromJson(Map<String, dynamic> json) {
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
  String? fromAddress;
  String? toAddress;
  FromLocation? fromLocation;
  FromLocation? toLocation;
  List<ContactData>? contactData;
  int? status;
  String? sId;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Data(
      {this.userId,
      this.fromAddress,
      this.toAddress,
      this.fromLocation,
      this.toLocation,
      this.contactData,
      this.status,
      this.sId,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    fromAddress = json['from_address'];
    toAddress = json['to_address'];
    fromLocation = json['from_location'] != null
        ? FromLocation.fromJson(json['from_location'])
        : null;
    toLocation = json['to_location'] != null
        ? FromLocation.fromJson(json['to_location'])
        : null;
    if (json['contactData'] != null) {
      contactData = <ContactData>[];
      json['contactData'].forEach((v) {
        contactData!.add(ContactData.fromJson(v));
      });
    }
    status = json['status'];
    sId = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['from_address'] = fromAddress;
    data['to_address'] = toAddress;
    if (fromLocation != null) {
      data['from_location'] = fromLocation!.toJson();
    }
    if (toLocation != null) {
      data['to_location'] = toLocation!.toJson();
    }
    if (contactData != null) {
      data['contactData'] = contactData!.map((v) => v.toJson()).toList();
    }
    data['status'] = status;
    data['_id'] = sId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class FromLocation {
  String? type;
  List<double>? coordinates;

  FromLocation({this.type, this.coordinates});

  FromLocation.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    coordinates = json['coordinates'].cast<double>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['coordinates'] = coordinates;
    return data;
  }
}

class ContactData {
  String? name;
  String? phone;
  int? status;
  String? sId;

  ContactData({this.name, this.phone, this.status, this.sId});

  ContactData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    status = json['status'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['phone'] = phone;
    data['status'] = status;
    data['_id'] = sId;
    return data;
  }
}