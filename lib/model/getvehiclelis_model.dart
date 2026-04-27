class GetVehicleList {
  int? status;
  String? message;
  List<Data>? data;

  GetVehicleList({this.status, this.message, this.data});

  GetVehicleList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(  Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =   <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? sId;
  String? driverid;
  String? vehicleId;
  String? vehicleType;
  String? vehicleMake;
  String? vehicleModel;
  String? vehicleYear;
  String? registrationNumber;
  String? vehicleColor;
  String? vehicleImages;
  int? isDefault;
  int? isDelete;
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
      {this.sId,
      this.driverid,
      this.vehicleId,
      this.vehicleType,
      this.vehicleMake,
      this.vehicleModel,
      this.vehicleYear,
      this.registrationNumber,
      this.vehicleColor,
      this.vehicleImages,
      this.isDefault,
      this.isDelete,
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
    sId = json['_id'];
    driverid = json['driverid'];
    vehicleId = json['vehicle_id'];
    vehicleType = json['vehicle_type'];
    vehicleMake = json['vehicle_make'];
    vehicleModel = json['vehicle_model'];
    vehicleYear = json['vehicle_year'];
    registrationNumber = json['registration_number'];
    vehicleColor = json['vehicle_color'];
    vehicleImages = json['vehicle_images'];
    isDefault = json['is_default'];
    isDelete = json['is_delete'];
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
    data['_id'] = sId;
    data['driverid'] = driverid;
    data['vehicle_id'] = vehicleId;
    data['vehicle_type'] = vehicleType;
    data['vehicle_make'] = vehicleMake;
    data['vehicle_model'] = vehicleModel;
    data['vehicle_year'] = vehicleYear;
    data['registration_number'] = registrationNumber;
    data['vehicle_color'] = vehicleColor;
    data['vehicle_images'] = vehicleImages;
    data['is_default'] = isDefault;
    data['is_delete'] = isDelete;
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