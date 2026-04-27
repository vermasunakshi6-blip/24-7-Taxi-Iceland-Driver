class RegisterModel {
  int? status;
  String? message;
  Data? data;

  RegisterModel({this.status, this.message, this.data});

  RegisterModel.fromJson(Map<String, dynamic> json) {
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
  String? sId;
  String? createdAt;
  String? updatedAt;
  int? iV;
  int? profilePhotoStatus;
  int? drivingLicenceFrontStatus;
  int? drivingLicenceBackStatus;
  int? vehicleInsuranceStatus;
  int? registrationCertificateStatus;
  int? backgroundVerification;

  Data(
      {this.firstName,
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
      this.sId,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.profilePhotoStatus,
      this.drivingLicenceFrontStatus,
      this.drivingLicenceBackStatus,
      this.vehicleInsuranceStatus,
      this.registrationCertificateStatus,
      this.backgroundVerification});

  Data.fromJson(Map<String, dynamic> json) {
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
    sId = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    profilePhotoStatus = json['profile_photo_status'];
    drivingLicenceFrontStatus = json['driving_licence_front_status'];
    drivingLicenceBackStatus = json['driving_licence_back_status'];
    vehicleInsuranceStatus = json['vehicle_insurance_status'];
    registrationCertificateStatus = json['registration_certificate_status'];
    backgroundVerification = json['background_verification'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
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
    data['_id'] = sId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
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