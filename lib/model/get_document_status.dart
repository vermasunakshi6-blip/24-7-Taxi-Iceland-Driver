class GetDocumentStatus {
  int? status;
  String? message;
  Data? data;

  GetDocumentStatus({this.status, this.message, this.data});

  GetDocumentStatus.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ?   Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =   <String, dynamic>{};
    data['status'] = status;
    data['message'] =  message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? profilePhotoStatus;
  int? drivingLicenceFrontStatus;
  int? drivingLicenceBackStatus;
  int? vehicleInsuranceStatus;
  int? registrationCertificateStatus;
  int? backgroundVerification;

  Data(
      {this.profilePhotoStatus,
      this.drivingLicenceFrontStatus,
      this.drivingLicenceBackStatus,
      this.vehicleInsuranceStatus,
      this.registrationCertificateStatus,
      this.backgroundVerification});

  Data.fromJson(Map<String, dynamic> json) {
    profilePhotoStatus = json['profile_photo_status'];
    drivingLicenceFrontStatus = json['driving_licence_front_status'];
    drivingLicenceBackStatus = json['driving_licence_back_status'];
    vehicleInsuranceStatus = json['vehicle_insurance_status'];
    registrationCertificateStatus = json['registration_certificate_status'];
    backgroundVerification = json['background_verification'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =   <String, dynamic>{};
    data['profile_photo_status'] =  profilePhotoStatus;
    data['driving_licence_front_status'] =  drivingLicenceFrontStatus;
    data['driving_licence_back_status'] =  drivingLicenceBackStatus;
    data['vehicle_insurance_status'] =  vehicleInsuranceStatus;
    data['registration_certificate_status'] =
         registrationCertificateStatus;
    data['background_verification'] =  backgroundVerification;
    return data;
  }
}