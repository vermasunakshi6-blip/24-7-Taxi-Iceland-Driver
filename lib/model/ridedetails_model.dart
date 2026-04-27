class RideDetails {
  int? status;
  String? message;
  List<Data>? data;
 
  RideDetails({this.status, this.message, this.data});
 
  RideDetails.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add( Data.fromJson(v));
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
 
class Data {
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
  String? currencysymbol;
  int? status;
  int? saftyNotification;
  int? stopNotification;
  int? tax;
  List<Null>? declineddrivers;
  List<CustomerData>? customerdata;
  List<ShareRideData>? shareRideData;
  List<String>? visibleRide;
  int? isScheduledRide;
  int? packageType;
  String? packageWeight;
  int? deliveryType;
  String? recipientsName;
  String? recipientsNumber;
  int? bookingRideStatus;
  List<Splits>? splits;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? rideAccpetDate;
  String? acceptId;
  String? otp;
  String? driverName;
  String? driverPhone;
  int? driverRating;
  String? driverPhoto;
  String? vehicleModel;
  String? vehicleNumber;
  String? vehiclePhoto;
  String? customerId;
  VehcleTypes? vehcleTypes;
  String? priceInUSD;
  int? driverAcceptRequest;
 
  Data(
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
      this.currencysymbol,
      this.status,
      this.saftyNotification,
      this.stopNotification,
      this.tax,
      this.declineddrivers,
      this.customerdata,
      this.visibleRide,
      this.isScheduledRide,
      this.packageType,
      this.packageWeight,
      this.deliveryType,
      this.recipientsName,
      this.recipientsNumber,
      this.bookingRideStatus,
      this.splits,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.rideAccpetDate,
      this.acceptId,
      this.otp,
      this.driverName,
      this.driverPhone,
      this.driverRating,
      this.driverPhoto,
      this.vehicleModel,
      this.vehicleNumber,
      this.vehiclePhoto,
      this.customerId,
      this.vehcleTypes,
      this.priceInUSD,
      this.driverAcceptRequest,
      });
 
  Data.fromJson(Map<String, dynamic> json) {
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
    driverId = json['driverId'];
    price = json['price'];
    currencysymbol = json['currencySymbol'];
    status = json['status'];
    saftyNotification = json['safty_notification'];
    stopNotification = json['stop_notification'];
    tax = json['tax'];
    declineddrivers = json['declineddrivers'];
    if (json['customerData'] != null) {
      customerdata = <CustomerData>[];
      json['customerData'].forEach((v) {
        customerdata!.add(CustomerData.fromJson(v));
      });
    }
    if (json['shareRideData'] != null) {
      shareRideData = <ShareRideData>[];
      json['shareRideData'].forEach((v) {
        shareRideData!.add(ShareRideData.fromJson(v));
      });
    }
    visibleRide = json['visibleRide'].cast<String>();
    isScheduledRide = json['isScheduledRide'];
    packageType = json['packageType'];
    packageWeight = json['packageWeight'];
    deliveryType = json['deliveryType'];
    recipientsName = json['recipientsName'];
    recipientsNumber = json['recipientsNumber'];
    bookingRideStatus = json['bookingRideStatus'];
    if (json['splits'] != null) {
      splits = <Splits>[];
      json['splits'].forEach((v) {
        splits!.add(Splits.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    rideAccpetDate = json['rideAccpet_date'];
    acceptId = json['acceptId'];
    otp = json['otp'];
    driverName = json['driver_name'];
    driverPhone = json['driver_phone'];
    driverRating = json['driver_rating'];
    driverPhoto = json['driver_photo'];
    vehicleModel = json['vehicle_model'];
    vehicleNumber = json['vehicle_number'];
    vehiclePhoto = json['vehicle_photo'];
    customerId = json['customerId'];
    driverAcceptRequest = json['DriverAcceptRequest'];
    vehcleTypes = json['vehcleTypes'] != null
        ? VehcleTypes.fromJson(json['vehcleTypes'])
        : null;
        priceInUSD = json['priceInUSD'];
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
    data['driverId'] = driverId;
    data['price'] = price;
    data['currencySymbol'] = currencysymbol;
    data['status'] = status;
    data['safty_notification'] = saftyNotification;
    data['stop_notification'] = stopNotification;
    data['tax'] = tax;
    data['declineddrivers'] = declineddrivers;
    if (customerdata != null) {
      data['customerData'] = customerdata!.map((v) => v.toJson()).toList();
    }
    if (shareRideData != null) {
      data['shareRideData'] = shareRideData!.map((v) => v.toJson()).toList();
    }
    data['visibleRide'] = visibleRide;
    data['isScheduledRide'] = isScheduledRide;
    data['packageType'] = packageType;
    data['packageWeight'] = packageWeight;
    data['deliveryType'] = deliveryType;
    data['recipientsName'] = recipientsName;
    data['recipientsNumber'] = recipientsNumber;
    data['bookingRideStatus'] = bookingRideStatus;
    if (splits != null) {
      data['splits'] = splits!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['rideAccpet_date'] = rideAccpetDate;
    data['acceptId'] = acceptId;
    data['otp'] = otp;
    data['driver_name'] = driverName;
    data['driver_phone'] = driverPhone;
    data['driver_rating'] = driverRating;
    data['driver_photo'] = driverPhoto;
    data['vehicle_model'] = vehicleModel;
    data['vehicle_number'] = vehicleNumber;
    data['vehicle_photo'] = vehiclePhoto;
    data['customerId'] = customerId;
    if (vehcleTypes != null) {
      data['vehcleTypes'] = vehcleTypes!.toJson();
    }
    data['priceInUSD'] = priceInUSD;
    data['DriverAcceptRequest'] = driverAcceptRequest;
    
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
  List<Members>? members;
  int? status;
  String? sId;
 
  Stops(
      {this.stopAddress,
      this.stopLatitude,
      this.stopLongitude,
      this.members,
      this.status,
      this.sId});
 
  Stops.fromJson(Map<String, dynamic> json) {
    stopAddress = json['stop_address'];
    stopLatitude = json['stop_latitude'];
    stopLongitude = json['stop_longitude'];
    if (json['members'] != null) {
      members = <Members>[];
      json['members'].forEach((v) {
        members!.add(  Members.fromJson(v));
      });
    }
    status = json['status'];
    sId = json['_id'];
  }
 
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['stop_address'] = stopAddress;
    data['stop_latitude'] = stopLatitude;
    data['stop_longitude'] = stopLongitude;
    if (members != null) {
      data['members'] = members!.map((v) => v.toJson()).toList();
    }
    data['status'] = status;
    data['_id'] = sId;
    return data;
  }
}
 
class Members {
  String? name;
  String? number;
  int? status;
  String? sId;
 
  Members({this.name, this.number, this.status, this.sId});
 
  Members.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    number = json['number'];
    status = json['status'];
    sId = json['_id'];
  }
 
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['name'] = name;
    data['number'] = number;
    data['status'] = status;
    data['_id'] = sId;
    return data;
  }
}
 
class Splits {
  String? name;
  String? number;
  double? price;
  int? status;
  String? sId;
 
  Splits({this.name, this.number, this.price, this.status, this.sId});
 
  Splits.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    number = json['number'];
    price = json['price'];
    status = json['status'];
    sId = json['_id'];
  }
 
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['name'] = name;
    data['number'] = number;
    data['price'] = price;
    data['status'] = status;
    data['_id'] = sId;
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
class ShareRideData {
  String? userId;
  String? name;
  String? phone;
  String? shareRideId;
 
  ShareRideData({this.userId, this.name, this.phone, this.shareRideId});
 
  ShareRideData.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    name = json['name'];
    phone = json['phone'];
    shareRideId = json['shareRideId'];
  }
 
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['name'] = name;
    data['phone'] = phone;
    data['shareRideId'] = shareRideId;
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
      this.continents});
 
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
    return data;
  }
 
 
  
}