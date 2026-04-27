class EditProfileModel {
  int? status;
  String? message;
  Data? data;

  EditProfileModel({this.status, this.message, this.data});

  EditProfileModel.fromJson(Map<String, dynamic> json) {
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
  dynamic location;
  dynamic latitude;
  dynamic longitude;
  String? sId;
  String? firstName;
  String? lastName;
  String? countryCode;
  String? phone;
  String? email;
  String? country;
  String? state;
  String? city;
  String? regType;
  String? currentType;
  int? status;
  int? isDelete;
  int? vehicleDetailStatus;
  String? deviceType;
  List<String>? deviceToken;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? contacts;
  int? isOnline;
  String? profilePic;

  Data(
      {this.location,
      this.latitude,
      this.longitude,
      this.sId,
      this.firstName,
      this.lastName,
      this.countryCode,
      this.phone,
      this.email,
      this.country,
      this.state,
      this.city,
      this.regType,
      this.currentType,
      this.status,
      this.isDelete,
      this.vehicleDetailStatus,
      this.deviceType,
      this.deviceToken,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.contacts,
      this.isOnline,
      this.profilePic});

  Data.fromJson(Map<String, dynamic> json) {
    location = json['location'] != null
        ?  Location.fromJson(json['location'])
        : null;
    latitude = json['latitude'];
    longitude = json['longitude'];
    sId = json['_id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    countryCode = json['countryCode'];
    phone = json['phone'];
    email = json['email'];
    country = json['country'];
    state = json['state'];
    city = json['city'];
    regType = json['regType'];
    currentType = json['currentType'];
    status = json['status'];
    isDelete = json['isDelete'];
    vehicleDetailStatus = json['vehicleDetailStatus'];
    deviceType = json['deviceType'];
    deviceToken = json['deviceToken'].cast<String>();
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    contacts = json['contacts'];
    isOnline = json['isOnline'];
    profilePic = json['profilePic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    if (location != null) {
      data['location'] = location!.toJson();
    }
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['_id'] = sId;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['countryCode'] = countryCode;
    data['phone'] = phone;
    data['email'] = email;
    data['country'] = country;
    data['state'] = state;
    data['city'] = city;
    data['regType'] = regType;
    data['currentType'] = currentType;
    data['status'] = status;
    data['isDelete'] = isDelete;
    data['vehicleDetailStatus'] = vehicleDetailStatus;
    data['deviceType'] = deviceType;
    data['deviceToken'] = deviceToken;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['contacts'] = contacts;
    data['isOnline'] = isOnline;
    data['profilePic'] = profilePic;
    return data;
  }
}

class Location {
  List<int>? coordinates;
  String? type;

  Location({this.coordinates, this.type});

  Location.fromJson(Map<String, dynamic> json) {
    coordinates = json['coordinates'].cast<int>();
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['coordinates'] = coordinates;
    data['type'] = type;
    return data;
  }
}