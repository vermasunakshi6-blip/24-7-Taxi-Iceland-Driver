class GetShareRideRequestModel {
  int? status;
  String? message;
  List<RequestData>? data;

  GetShareRideRequestModel({this.status, this.message, this.data});

  GetShareRideRequestModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <RequestData>[];
      json['data'].forEach((v) {
        data!.add(RequestData.fromJson(v));
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

class RequestData {
  String? sId;
  UserId? userId;
  String? fromAddress;
  String? toAddress;
  FromLocation? fromLocation;
  FromLocation? toLocation;
  List<ContactData>? contactData;
  int? status;
  String? createdAt;
  String? updatedAt;
  int? iV;

  RequestData(
      {this.sId,
      this.userId,
      this.fromAddress,
      this.toAddress,
      this.fromLocation,
      this.toLocation,
      this.contactData,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.iV});

  RequestData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId =
        json['userId'] != null ? UserId.fromJson(json['userId']) : null;
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
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    if (userId != null) {
      data['userId'] = userId!.toJson();
    }
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
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class UserId {
  String? sId;
  String? firstName;
  String? lastName;
  String? phone;

  UserId({this.sId, this.firstName, this.lastName, this.phone});

  UserId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['phone'] = phone;
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
  String? userId;
  String? name;
  String? phone;
  int? status;
  String? sId;

  ContactData({this.userId, this.name, this.phone, this.status, this.sId});

  ContactData.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    name = json['name'];
    phone = json['phone'];
    status = json['status'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['name'] = name;
    data['phone'] = phone;
    data['status'] = status;
    data['_id'] = sId;
    return data;
  }
}