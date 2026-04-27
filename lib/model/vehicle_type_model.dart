class VehicleTypeModel {
  int? status;
  String? message;
  List<Data>? data;

  VehicleTypeModel({this.status, this.message, this.data});

  VehicleTypeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
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

class Data {
  String? sId;
  String? vehicleName;
  int? numberOfPerson;
  String? vehicleImages;
  int? baseFare;
  int? costPerMinute;
  int? costPerMile;
  int? bookingFee;
  int? adminFee;
  String? continents;
  int? status;
  String? createdAt;
  String? updatedAt;
  int? iV;
  int? isActive;
  String? createdAtVehicle;
  String? features;
  List<Legs>? legs;
  int? rideCompatibility;
  String? tokenType;
  dynamic usdPrice;
  String? cryptoPrice;

  Data(
      {this.sId,
      this.vehicleName,
      this.numberOfPerson,
      this.vehicleImages,
      this.baseFare,
      this.costPerMinute,
      this.costPerMile,
      this.bookingFee,
      this.adminFee,
      this.continents,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.isActive,
      this.createdAtVehicle,
      this.features,
      this.legs,
      this.rideCompatibility,
      this.tokenType,
      this.usdPrice,
      this.cryptoPrice});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    vehicleName = json['vehicleName'];
    numberOfPerson = json['numberOfPerson'];
    vehicleImages = json['vehicle_images'];
    baseFare = json['baseFare'];
    costPerMinute = json['costPerMinute'];
    costPerMile = json['costPerMile'];
    bookingFee = json['bookingFee'];
    adminFee = json['adminFee'];
    continents = json['continents'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    isActive = json['isActive'];
    createdAtVehicle = json['createdAtVehicle'];
    features = json['features'];
    if (json['legs'] != null) {
      legs = <Legs>[];
      json['legs'].forEach((v) {
        legs!.add(Legs.fromJson(v));
      });
    }
    rideCompatibility = json['rideCompatibility'];
    tokenType = json['tokenType'];
    usdPrice = json['usdPrice'];
    cryptoPrice = json['cryptoPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['vehicleName'] = vehicleName;
    data['numberOfPerson'] = numberOfPerson;
    data['vehicle_images'] = vehicleImages;
    data['baseFare'] = baseFare;
    data['costPerMinute'] = costPerMinute;
    data['costPerMile'] = costPerMile;
    data['bookingFee'] = bookingFee;
    data['adminFee'] = adminFee;
    data['continents'] = continents;
    data['status'] = status;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['isActive'] = isActive;
    data['createdAtVehicle'] = createdAtVehicle;
    data['features'] = features;
    if (legs != null) {
      data['legs'] = legs!.map((v) => v.toJson()).toList();
    }
    data['rideCompatibility'] = rideCompatibility;
    data['tokenType'] = tokenType;
    data['usdPrice'] = usdPrice;
    data['cryptoPrice'] = cryptoPrice;
    return data;
  }
}

class Legs {
  String? title;
  dynamic usdPrice;
  dynamic cryptoPrice;

  Legs({this.title, this.usdPrice, this.cryptoPrice});

  Legs.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    usdPrice = json['usdPrice'];
    cryptoPrice = json['cryptoPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['usdPrice'] = usdPrice;
    data['cryptoPrice'] = cryptoPrice;
    return data;
  }
}
class VehicleTypesDataModel {
  int? status;
  List<VehicleTypes>? vehicleTypes;

  VehicleTypesDataModel({this.status, this.vehicleTypes});

  VehicleTypesDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['vehicleTypes'] != null) {
      vehicleTypes = <VehicleTypes>[];
      json['vehicleTypes'].forEach((v) {
        vehicleTypes!.add( VehicleTypes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['status'] = status;
    if (vehicleTypes != null) {
      data['vehicleTypes'] = vehicleTypes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class VehicleTypes {
  String? sId;
  String? vehicleName;
  int? numberOfPerson;
  String? vehicleImages;
  int? baseFare;
  int? costPerMinute;
  int? costPerMile;
  int? bookingFee;
  int? adminFee;
  int? status;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? continents;
  int? isActive;
  String? createdAtVehicle;
  String? features;

  VehicleTypes(
      {this.sId,
      this.vehicleName,
      this.numberOfPerson,
      this.vehicleImages,
      this.baseFare,
      this.costPerMinute,
      this.costPerMile,
      this.bookingFee,
      this.adminFee,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.continents,
      this.isActive,
      this.createdAtVehicle,
      this.features});

  VehicleTypes.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    vehicleName = json['vehicleName'];
    numberOfPerson = json['numberOfPerson'];
    vehicleImages = json['vehicle_images'];
    baseFare = json['baseFare'];
    costPerMinute = json['costPerMinute'];
    costPerMile = json['costPerMile'];
    bookingFee = json['bookingFee'];
    adminFee = json['adminFee'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    continents = json['continents'];
    isActive = json['isActive'];
    createdAtVehicle = json['createdAtVehicle'];
    features = json['features'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['vehicleName'] = vehicleName;
    data['numberOfPerson'] = numberOfPerson;
    data['vehicle_images'] = vehicleImages;
    data['baseFare'] = baseFare;
    data['costPerMinute'] = costPerMinute;
    data['costPerMile'] = costPerMile;
    data['bookingFee'] = bookingFee;
    data['adminFee'] = adminFee;
    data['status'] = status;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['continents'] = continents;
    data['isActive'] = isActive;
    data['createdAtVehicle'] = createdAtVehicle;
    data['features'] = features;
    return data;
  }
}