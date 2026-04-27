class AddProfilePhotoModel {
  int? status;
  String? message;
  Data? data;

  AddProfilePhotoModel({this.status, this.message, this.data});

  AddProfilePhotoModel.fromJson(Map<String, dynamic> json) {
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
  String? userId;
  int? iV;
  int? backgroundVerification;
  String? createdAt;
  int? drivingLicenceBackStatus;
  int? drivingLicenceFrontStatus;
  int? profilePhotoStatus;
  int? registrationCertificateStatus;
  String? updatedAt;
  int? vehicleInsuranceStatus;
  String? profilePhoto;

  Data(
      {this.sId,
      this.userId,
      this.iV,
      this.backgroundVerification,
      this.createdAt,
      this.drivingLicenceBackStatus,
      this.drivingLicenceFrontStatus,
      this.profilePhotoStatus,
      this.registrationCertificateStatus,
      this.updatedAt,
      this.vehicleInsuranceStatus,
      this.profilePhoto});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    iV = json['__v'];
    backgroundVerification = json['background_verification'];
    createdAt = json['createdAt'];
    drivingLicenceBackStatus = json['driving_licence_back_status'];
    drivingLicenceFrontStatus = json['driving_licence_front_status'];
    profilePhotoStatus = json['profile_photo_status'];
    registrationCertificateStatus = json['registration_certificate_status'];
    updatedAt = json['updatedAt'];
    vehicleInsuranceStatus = json['vehicle_insurance_status'];
    profilePhoto = json['profile_photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['_id'] = sId;
    data['userId'] = userId;
    data['__v'] = iV;
    data['background_verification'] =backgroundVerification;
    data['createdAt'] = createdAt;
    data['driving_licence_back_status'] = drivingLicenceBackStatus;
    data['driving_licence_front_status'] =drivingLicenceFrontStatus;
    data['profile_photo_status'] = profilePhotoStatus;
    data['registration_certificate_status'] =
       registrationCertificateStatus;
    data['updatedAt'] = updatedAt;
    data['vehicle_insurance_status'] = vehicleInsuranceStatus;
    data['profile_photo'] = profilePhoto;
    return data;
  }
}