class SharedTripModel {
  int? status;
  String? message;
  List<SharedData>? data;

  SharedTripModel({this.status, this.message, this.data});

  SharedTripModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <SharedData>[];
      json['data'].forEach((v) {
        data!.add(SharedData.fromJson(v));
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

class SharedData {
  String? sId;
  String? userId;
  String? fromAddress;
  String? toAddress;
  FromLocation? fromLocation;
  FromLocation? toLocation;
  String? vehicleType;
  List<Stops>? stops;
  List<dynamic>? splits;
  String? driverId;
  String? price;
  String? currencySymbol;
  int? status;
  int? saftyNotification;
  int? stopNotification;
  int? tax;
  List<dynamic>? declinedDrivers;
  String? rideType;
  List<CustomerData>? customerData;
  List<String>? visibleRide;
  int? isScheduledRide;
  String? ridebookingDate;
  String? ridebookingTime;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? rideAccpetDate;
  String? acceptId;
  String? otp;
  String? driverName;
  int? driverRating;
  String? driverPhoto;
  String? vehicleModel;
  String? vehicleNumber;
  String? vehiclePhoto;
  String? customerId;
  VehcleTypes? vehcleTypes;

  SharedData(
      {this.sId,
      this.userId,
      this.fromAddress,
      this.toAddress,
      this.fromLocation,
      this.toLocation,
      this.vehicleType,
      this.stops,
      this.splits,
      this.driverId,
      this.price,
      this.currencySymbol,
      this.status,
      this.saftyNotification,
      this.stopNotification,
      this.tax,
      this.declinedDrivers,
      this.rideType,
      this.customerData,
      this.visibleRide,
      this.isScheduledRide,
      this.ridebookingDate,
      this.ridebookingTime,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.rideAccpetDate,
      this.acceptId,
      this.otp,
      this.driverName,
      this.driverRating,
      this.driverPhoto,
      this.vehicleModel,
      this.vehicleNumber,
      this.vehiclePhoto,
      this.customerId,
      this.vehcleTypes});

  SharedData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    fromAddress = json['from_address'];
    toAddress = json['to_address'];
    fromLocation = json['from_location'] != null
        ? FromLocation.fromJson(json['from_location'])
        : null;
    toLocation = json['to_location'] != null
        ? FromLocation.fromJson(json['to_location'])
        : null;
    vehicleType = json['vehicleType'];
    if (json['stops'] != null) {
      stops = <Stops>[];
      json['stops'].forEach((v) {
        stops!.add(Stops.fromJson(v));
      });
    }
    splits = json['splits'] ?? [];
    driverId = json['driverId'];
    price = json['price'];
    currencySymbol = json['currencySymbol'];
    status = json['status'];
    saftyNotification = json['safty_notification'];
    stopNotification = json['stop_notification'];
    tax = json['tax'];

 declinedDrivers = json['declinedDrivers'] ?? [];

    
    rideType = json['rideType'];
    if (json['customerData'] != null) {
      customerData = <CustomerData>[];
      json['customerData'].forEach((v) {
        customerData!.add(CustomerData.fromJson(v));
      });
    }
    visibleRide = json['visibleRide'].cast<String>();
    isScheduledRide = json['isScheduledRide'];
    ridebookingDate = json['ridebooking_date'];
    ridebookingTime = json['ridebooking_time'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    rideAccpetDate = json['rideAccpet_date'];
    acceptId = json['acceptId'];
    otp = json['otp'];
    driverName = json['driver_name'];
    driverRating = json['driver_rating'];
    driverPhoto = json['driver_photo'];
    vehicleModel = json['vehicle_model'];
    vehicleNumber = json['vehicle_number'];
    vehiclePhoto = json['vehicle_photo'];
    customerId = json['customerId'];
    vehcleTypes = json['vehcleTypes'] != null
        ? VehcleTypes.fromJson(json['vehcleTypes'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['userId'] = userId;
    data['from_address'] = fromAddress;
    data['to_address'] = toAddress;
    if (fromLocation != null) {
      data['from_location'] = fromLocation!.toJson();
    }
    if (toLocation != null) {
      data['to_location'] = toLocation!.toJson();
    }
    data['vehicleType'] = vehicleType;
    if (stops != null) {
      data['stops'] = stops!.map((v) => v.toJson()).toList();
    }
    if (splits != null) {
      data['splits'] = splits!.map((v) => v.toJson()).toList();
    }
    data['driverId'] = driverId;
    data['price'] = price;
    data['currencySymbol'] = currencySymbol;
    data['status'] = status;
    data['safty_notification'] = saftyNotification;
    data['stop_notification'] = stopNotification;
    data['tax'] = tax;
    if (declinedDrivers != null) {
      data['declinedDrivers'] =
          declinedDrivers!.map((v) => v.toJson()).toList();
    }
    data['rideType'] = rideType;
    if (customerData != null) {
      data['customerData'] = customerData!.map((v) => v.toJson()).toList();
    }
    data['visibleRide'] = visibleRide;
    data['isScheduledRide'] = isScheduledRide;
    data['ridebooking_date'] = ridebookingDate;
    data['ridebooking_time'] = ridebookingTime;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['rideAccpet_date'] = rideAccpetDate;
    data['acceptId'] = acceptId;
    data['otp'] = otp;
    data['driver_name'] = driverName;
    data['driver_rating'] = driverRating;
    data['driver_photo'] = driverPhoto;
    data['vehicle_model'] = vehicleModel;
    data['vehicle_number'] = vehicleNumber;
    data['vehicle_photo'] = vehiclePhoto;
    data['customerId'] = customerId;
    if (vehcleTypes != null) {
      data['vehcleTypes'] = vehcleTypes!.toJson();
    }
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

class Stops {
  String? stopAddress;
  String? stopLatitude;
  String? stopLongitude;
  int? status;
  String? sId;
  List<dynamic>? members;

  Stops(
      {this.stopAddress,
      this.stopLatitude,
      this.stopLongitude,
      this.status,
      this.sId,
      this.members});

  Stops.fromJson(Map<String, dynamic> json) {
    stopAddress = json['stop_address'];
    stopLatitude = json['stop_latitude'];
    stopLongitude = json['stop_longitude'];
    status = json['status'];
    sId = json['_id'];
    


     members = json['members'] ?? [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['stop_address'] = stopAddress;
    data['stop_latitude'] = stopLatitude;
    data['stop_longitude'] = stopLongitude;
    data['status'] = status;
    data['_id'] = sId;
    if (members != null) {
      data['members'] = members!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CustomerData {
  String? name;
  String? phone;
  String? email;

  CustomerData({this.name, this.phone, this.email});

  CustomerData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['phone'] = phone;
    data['email'] = email;
    return data;
  }
}

class VehcleTypes {
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

  VehcleTypes(
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

  VehcleTypes.fromJson(Map<String, dynamic> json) {
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