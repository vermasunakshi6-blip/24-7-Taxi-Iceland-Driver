class RoleChangeModel {
  int? status;
  String? message;
  Data? data;

  RoleChangeModel({this.status, this.message, this.data});

  RoleChangeModel.fromJson(Map<String, dynamic> json) {
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
  Location? location;
  String? profilePic;
  String? otp;
  int? profilePhotoStatus;
  int? drivingLicenceFrontStatus;
  int? drivingLicenceBackStatus;
  int? vehicleInsuranceStatus;
  int? registrationCertificateStatus;
  int? backgroundVerification;

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
      this.vehicleDetailStatus,
      this.deviceType,
      this.deviceToken,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.contacts,
      this.isOnline,
      this.location,
      this.profilePic,
      this.otp,
      this.profilePhotoStatus,
      this.drivingLicenceFrontStatus,
      this.drivingLicenceBackStatus,
      this.vehicleInsuranceStatus,
      this.registrationCertificateStatus,
      this.backgroundVerification});

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
    vehicleDetailStatus = json['vehicleDetailStatus'];
    deviceType = json['deviceType'];
    deviceToken = json['deviceToken'].cast<String>();
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    contacts = json['contacts'];
    isOnline = json['isOnline'];
    location = json['location'] != null
        ?  Location.fromJson(json['location'])
        : null;
    profilePic = json['profilePic'];
    otp = json['otp'];
    profilePhotoStatus = json['profile_photo_status'];
    drivingLicenceFrontStatus = json['driving_licence_front_status'];
    drivingLicenceBackStatus = json['driving_licence_back_status'];
    vehicleInsuranceStatus = json['vehicle_insurance_status'];
    registrationCertificateStatus = json['registration_certificate_status'];
    backgroundVerification = json['background_verification'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
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
    if (location != null) {
      data['location'] = location!.toJson();
    }
    data['profilePic'] = profilePic;
    data['otp'] = otp;
    data['profile_photo_status'] = profilePhotoStatus;
    data['driving_licence_front_status'] = drivingLicenceFrontStatus;
    data['driving_licence_back_status'] = drivingLicenceBackStatus;
    data['vehicle_insurance_status'] = vehicleInsuranceStatus;
    data['registration_certificate_status'] =
        registrationCertificateStatus;
    data['background_verification'] = backgroundVerification;
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