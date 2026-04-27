class CustomerProfileModel {
  int? status;
  String? message;
  Data? data;

  CustomerProfileModel({this.status, this.message, this.data});

  CustomerProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ?   Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =   <String, dynamic>{};
    data['status'] =  status;
    data['message'] =  message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
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
  int? isOnline;
  int? vehicleDetailStatus;
  String? deviceType;
  List<String>? deviceToken;
  double? latitude;
  double? longitude;
  Location? location;
  String? lastLogin;
  bool? isLoggedIn;
  bool? isRegistered;
  String? regDate;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? contacts;
  String? profilePic;
  String? myCode;
  String? otp;
  int? registerType;
  int? isSubscription;
  int? averageRating;
  String? expiryDate;

  Data(
      {this.sId,
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
      this.isOnline,
      this.vehicleDetailStatus,
      this.deviceType,
      this.deviceToken,
      this.latitude,
      this.longitude,
      this.location,
      this.lastLogin,
      this.isLoggedIn,
      this.isRegistered,
      this.regDate,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.contacts,
      this.profilePic,
      this.myCode,
      this.otp,
      this.registerType,
      this.isSubscription,
      this.averageRating,
      this.expiryDate});

  Data.fromJson(Map<String, dynamic> json) {
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
    isOnline = json['isOnline'];
    vehicleDetailStatus = json['vehicleDetailStatus'];
    deviceType = json['deviceType'];
    deviceToken = json['deviceToken'].cast<String>();
    latitude = json['latitude'];
    longitude = json['longitude'];
    location = json['location'] != null
        ? Location.fromJson(json['location'])
        : null;
    lastLogin = json['lastLogin'];
    isLoggedIn = json['isLoggedIn'];
    isRegistered = json['isRegistered'];
    regDate = json['regDate'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    contacts = json['contacts'];
    profilePic = json['profilePic'];
    myCode = json['myCode'];
    otp = json['otp'];
    registerType = json['registerType'];
    isSubscription = json['isSubscription'];
    averageRating = json['averageRating'];
    expiryDate = json['expiryDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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
    data['isOnline'] = isOnline;
    data['vehicleDetailStatus'] = vehicleDetailStatus;
    data['deviceType'] = deviceType;
    data['deviceToken'] = deviceToken;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    if (location != null) {
      data['location'] = location!.toJson();
    }
    data['lastLogin'] = lastLogin;
    data['isLoggedIn'] = isLoggedIn;
    data['isRegistered'] = isRegistered;
    data['regDate'] = regDate;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['contacts'] = contacts;
    data['profilePic'] = profilePic;
    data['myCode'] = myCode;
    data['otp'] = otp;
    data['registerType'] = registerType;
    data['isSubscription'] = isSubscription;
    data['averageRating'] = averageRating;
    data['expiryDate'] = expiryDate;
    return data;
  }
}
class Location {
  String? type;
  List<double>? coordinates;

  Location({this.type, this.coordinates});

  Location.fromJson(Map<String, dynamic> json) {
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