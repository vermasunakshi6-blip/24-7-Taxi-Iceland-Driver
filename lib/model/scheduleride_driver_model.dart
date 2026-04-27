class ScheduleRideDriver {
  int? status;
  String? message;
  List<ScheduledData>? data;

  ScheduleRideDriver({this.status, this.message, this.data});

  ScheduleRideDriver.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ScheduledData>[];
      json['data'].forEach((v) {
        data!.add( ScheduledData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ScheduledData {
  String? sId;
  String? userId;
  String? fromAddress;
  String? toAddress;
  FromLocation? fromLocation;
  FromLocation? toLocation;
  String? vehicleType;
  List<Stops>? stops;
  
  String? driverId;
  String? price;
  String? currencySymbol;
  int? status;
  int? saftyNotification;
  int? stopNotification;
  int? tax;
  List<Null>? declinedDrivers;
  String? eventId;
  String? rideType;
  List<CustomerData>? customerData;
  List<Null>? shareRideData;
  List<String>? visibleRide;
  int? isScheduledRide;
  int? bookingRideStatus;
  int? driverAcceptRequest;
  String? ridebookingDate;
  String? ridebookingTime;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? rideAccpetDate;
  String? acceptId;
  String? otp;
  String? userName;
  int? userRating;
  String? userPhoto;
  VehcleTypes? vehcleTypes;
  String? priceInUSD;

  ScheduledData(
      {this.sId,
      this.userId,
      this.fromAddress,
      this.toAddress,
      this.fromLocation,
      this.toLocation,
      this.vehicleType,
      this.stops,
      
      this.driverId,
      this.price,
      this.currencySymbol,
      this.status,
      this.saftyNotification,
      this.stopNotification,
      this.tax,
      this.declinedDrivers,
      this.eventId,
      this.rideType,
      this.customerData,
      this.shareRideData,
      this.visibleRide,
      this.isScheduledRide,
      this.bookingRideStatus,
      this.driverAcceptRequest,
      this.ridebookingDate,
      this.ridebookingTime,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.rideAccpetDate,
      this.acceptId,
      this.otp,
      this.userName,
      this.userRating,
      this.userPhoto,
      this.vehcleTypes,
      this.priceInUSD});

  ScheduledData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    fromAddress = json['from_address'];
    toAddress = json['to_address'];
    fromLocation = json['from_location'] != null
        ?  FromLocation.fromJson(json['from_location'])
        : null;
    toLocation = json['to_location'] != null
        ?  FromLocation.fromJson(json['to_location'])
        : null;
    vehicleType = json['vehicleType'];
    if (json['stops'] != null) {
      stops = <Stops>[];
      json['stops'].forEach((v) {
        stops!.add( Stops.fromJson(v));
      });
    }
    
    driverId = json['driverId'];
    price = json['price'];
    currencySymbol = json['currencySymbol'];
    status = json['status'];
    saftyNotification = json['safty_notification'];
    stopNotification = json['stop_notification'];
    tax = json['tax'];
    
    eventId = json['eventId'];
    rideType = json['rideType'];
    if (json['customerData'] != null) {
      customerData = <CustomerData>[];
      json['customerData'].forEach((v) {
        customerData!.add( CustomerData.fromJson(v));
      });
    }
    
    visibleRide = json['visibleRide'].cast<String>();
    isScheduledRide = json['isScheduledRide'];
    bookingRideStatus = json['bookingRideStatus'];
    driverAcceptRequest = json['DriverAcceptRequest'];
    ridebookingDate = json['ridebooking_date'];
    ridebookingTime = json['ridebooking_time'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    rideAccpetDate = json['rideAccpet_date'];
    acceptId = json['acceptId'];
    otp = json['otp'];
    userName = json['user_name'];
    userRating = json['user_rating'];
    userPhoto = json['user_photo'];
    vehcleTypes = json['vehcleTypes'] != null
        ?  VehcleTypes.fromJson(json['vehcleTypes'])
        : null;
    priceInUSD = json['priceInUSD'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
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
  
    data['driverId'] = driverId;
    data['price'] = price;
    data['currencySymbol'] = currencySymbol;
    data['status'] = status;
    data['safty_notification'] = saftyNotification;
    data['stop_notification'] = stopNotification;
    data['tax'] = tax;
    
    data['eventId'] = eventId;
    data['rideType'] = rideType;
    if (customerData != null) {
      data['customerData'] = customerData!.map((v) => v.toJson()).toList();
    }
     
    data['visibleRide'] = visibleRide;
    data['isScheduledRide'] = isScheduledRide;
    data['bookingRideStatus'] = bookingRideStatus;
    data['DriverAcceptRequest'] = driverAcceptRequest;
    data['ridebooking_date'] = ridebookingDate;
    data['ridebooking_time'] = ridebookingTime;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['rideAccpet_date'] = rideAccpetDate;
    data['acceptId'] = acceptId;
    data['otp'] = otp;
    data['user_name'] = userName;
    data['user_rating'] = userRating;
    data['user_photo'] = userPhoto;
    if (vehcleTypes != null) {
      data['vehcleTypes'] = vehcleTypes!.toJson();
    }
    data['priceInUSD'] = priceInUSD;
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
    final Map<String, dynamic> data =  <String, dynamic>{};
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
  List<Null>? members;

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
    
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['stop_address'] = stopAddress;
    data['stop_latitude'] = stopLatitude;
    data['stop_longitude'] = stopLongitude;
    data['status'] = status;
    data['_id'] = sId;
   
    return data;
  }
}

class CustomerData {
  String? name;
  String? phone;
  Null email;

  CustomerData({this.name, this.phone, this.email});

  CustomerData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
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
    final Map<String, dynamic> data =  <String, dynamic>{};
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
