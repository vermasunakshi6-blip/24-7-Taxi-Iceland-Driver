class GetVehicleInfoModel {
  int? status;
  String? message;
  List<Data>? data;

  GetVehicleInfoModel({this.status, this.message, this.data});

  GetVehicleInfoModel.fromJson(Map<String, dynamic> json) {
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
    data['status'] =  status;
    data['message'] =  message;
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
  List<String>? vehicleImages;
  int? isDefault;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? profilePhoto;
  String? drivingLicenceBack;
  String? drivingLicenceFront;
  String? vehicleInsurance;
  String? registrationCertificate;
  String? vehicleImagePath;
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
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.profilePhoto,
      this.drivingLicenceBack,
      this.drivingLicenceFront,
      this.vehicleInsurance,
      this.registrationCertificate,
      this.vehicleImagePath,
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
    vehicleImages = json['vehicle_images'].cast<String>();
    isDefault = json['is_default'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    profilePhoto = json['profile_photo'];
    drivingLicenceBack = json['driving_licence_back'];
    drivingLicenceFront = json['driving_licence_front'];
    vehicleInsurance = json['vehicle_insurance'];
    registrationCertificate = json['registration_certificate'];
    vehicleImagePath = json['vehicleImagePath'];
    backgroundVerification = json['background_verification'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =   <String, dynamic>{};
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
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['profile_photo'] = profilePhoto;
    data['driving_licence_back'] = drivingLicenceBack;
    data['driving_licence_front'] = drivingLicenceFront;
    data['vehicle_insurance'] = vehicleInsurance;
    data['registration_certificate'] = registrationCertificate;
    data['vehicleImagePath'] = vehicleImagePath;
    data['background_verification'] = backgroundVerification;
    return data;
  }
}