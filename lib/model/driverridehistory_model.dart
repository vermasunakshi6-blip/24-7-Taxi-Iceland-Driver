// class DriverRideHistory {
//   int? status;
//   String? message;
//   List<RideHistory>? rideHistory;
//   int? completedRidesCount;

//   DriverRideHistory({this.status, this.message, this.rideHistory});

//   DriverRideHistory.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     if (json['rideHistory'] != null) {
//       rideHistory = <RideHistory>[];
//       json['rideHistory'].forEach((v) {
//         rideHistory!.add(RideHistory.fromJson(v));
//       });
//     }
//     completedRidesCount = json['completedRidesCount'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['status'] = status;
//     data['message'] = message;
//     if (rideHistory != null) {
//       data['rideHistory'] = rideHistory!.map((v) => v.toJson()).toList();
//     }
//     data['completedRidesCount'] = completedRidesCount;
//     return data;
//   }
// }

// class RideHistory {
//   String? sId;
//   UserId? userId;
//   String? fromAddress;
//   String? toAddress;
//   FromLocation? fromLocation;
//   FromLocation? toLocation;
//   String? vehicleType;
//   List<Stops>? stops;
//   String? driverId;
//   String? price;
//   String? currencySymbol;
//   int? status;
//   int? saftyNotification;
//   int? stopNotification;
//   int? tax;
//   List<dynamic>? declinedDrivers;
//   List<CustomerData>? customerData;
//   List<String>? visibleRide;
//   int? isScheduledRide;
//   int? packageType;
//   String? packageWeight;
//   int? deliveryType;
//   String? recipientsName;
//   String? recipientsNumber;
//   int? bookingRideStatus;
//   List<Splits>? splits;
//   String? createdAt;
//   String? updatedAt;
//   int? iV;
//   String? rideAccpetDate;
//   String? acceptId;
//   String? otp;
//   String? rideArriveDate;
//   String? rideStartDate;
//   String? adminFees;
//   String? driverAmount;
//   String? rideCompletDate;
//   dynamic tripRating;
//   String? vehicleImage;
//   String? profilePicUser;
//   String? vehiclModel;
//   String? vehiclNumber;
//   String? vehiclColor;
//   int? userRating;
//   String? rideType;
//   String? ridebookingDate;
//   String? ridebookingTime;

//   RideHistory(
//       {this.sId,
//       this.userId,
//       this.fromAddress,
//       this.toAddress,
//       this.fromLocation,
//       this.toLocation,
//       this.vehicleType,
//       this.stops,
//       this.driverId,
//       this.price,
//       this.currencySymbol,
//       this.status,
//       this.saftyNotification,
//       this.stopNotification,
//       this.tax,
//       this.declinedDrivers,
//       this.customerData,
//       this.visibleRide,
//       this.isScheduledRide,
//       this.packageType,
//       this.packageWeight,
//       this.deliveryType,
//       this.recipientsName,
//       this.recipientsNumber,
//       this.bookingRideStatus,
//       this.splits,
//       this.createdAt,
//       this.updatedAt,
//       this.iV,
//       this.rideAccpetDate,
//       this.acceptId,
//       this.otp,
//       this.rideArriveDate,
//       this.rideStartDate,
//       this.adminFees,
//       this.driverAmount,
//       this.rideCompletDate,
//       this.tripRating,
//       this.vehicleImage,
//       this.profilePicUser,
//       this.vehiclModel,
//       this.vehiclNumber,
//       this.vehiclColor,
//       this.userRating,
//       this.rideType,
//       this.ridebookingDate,
//       this.ridebookingTime});

//   RideHistory.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     userId =
//         json['userId'] != null ? UserId.fromJson(json['userId']) : null;
//     fromAddress = json['from_address'];
//     toAddress = json['to_address'];
//     fromLocation = json['from_location'] != null
//         ? FromLocation.fromJson(json['from_location'])
//         : null;
//     toLocation = json['to_location'] != null
//         ? FromLocation.fromJson(json['to_location'])
//         : null;
//     vehicleType = json['vehicleType'];
//     if (json['stops'] != null) {
//       stops = <Stops>[];
//       json['stops'].forEach((v) {
//         stops!.add(Stops.fromJson(v));
//       });
//     }
//     driverId = json['driverId'];
//     price = json['price'];
//     currencySymbol = json['currencySymbol'];
//     status = json['status'];
//     saftyNotification = json['safty_notification'];
//     stopNotification = json['stop_notification'];
//     tax = json['tax'];
//     declinedDrivers = json['declinedDrivers'];
//     if (json['customerData'] != null) {
//       customerData = <CustomerData>[];
//       json['customerData'].forEach((v) {
//         customerData!.add(CustomerData.fromJson(v));
//       });
//     }
//     visibleRide = json['visibleRide'].cast<String>();
//     isScheduledRide = json['isScheduledRide'];
//     packageType = json['packageType'];
//     packageWeight = json['packageWeight'];
//     deliveryType = json['deliveryType'];
//     recipientsName = json['recipientsName'];
//     recipientsNumber = json['recipientsNumber'];
//     bookingRideStatus = json['bookingRideStatus'];
//     if (json['splits'] != null) {
//       splits = <Splits>[];
//       json['splits'].forEach((v) {
//         splits!.add(Splits.fromJson(v));
//       });
//     }
//     createdAt = json['createdAt'];
//     updatedAt = json['updatedAt'];
//     iV = json['__v'];
//     rideAccpetDate = json['rideAccpet_date'];
//     acceptId = json['acceptId'];
//     otp = json['otp'];
//     rideArriveDate = json['rideArrive_date'];
//     rideStartDate = json['rideStart_date'];
//     adminFees = json['admin_fees'];
//     driverAmount = json['driver_amount'];
//     rideCompletDate = json['rideComplet_date'];
//     tripRating = json['tripRating'];
//     vehicleImage = json['vehicleImage'];
//     profilePicUser = json['profilePicUser'];
//     vehiclModel = json['vehiclModel'];
//     vehiclNumber = json['vehiclNumber'];
//     vehiclColor = json['vehiclColor'];
//     userRating = json['user_rating'];
//     rideType = json['rideType'];
//     ridebookingDate = json['ridebooking_date'];
//     ridebookingTime = json['ridebooking_time'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['_id'] = sId;
//     if (userId != null) {
//       data['userId'] = userId!.toJson();
//     }
//     data['from_address'] = fromAddress;
//     data['to_address'] = toAddress;
//     if (fromLocation != null) {
//       data['from_location'] = fromLocation!.toJson();
//     }
//     if (toLocation != null) {
//       data['to_location'] = toLocation!.toJson();
//     }
//     data['vehicleType'] = vehicleType;
//     if (stops != null) {
//       data['stops'] = stops!.map((v) => v.toJson()).toList();
//     }
//     data['driverId'] = driverId;
//     data['price'] = price;
//     data['currencySymbol'] = currencySymbol;
//     data['status'] = status;
//     data['safty_notification'] = saftyNotification;
//     data['stop_notification'] = stopNotification;
//     data['tax'] = tax;
//     data['declinedDrivers'] = declinedDrivers;
//     if (customerData != null) {
//       data['customerData'] = customerData!.map((v) => v.toJson()).toList();
//     }
//     data['visibleRide'] = visibleRide;
//     data['isScheduledRide'] = isScheduledRide;
//     data['packageType'] = packageType;
//     data['packageWeight'] = packageWeight;
//     data['deliveryType'] = deliveryType;
//     data['recipientsName'] = recipientsName;
//     data['recipientsNumber'] = recipientsNumber;
//     data['bookingRideStatus'] = bookingRideStatus;
//     if (splits != null) {
//       data['splits'] = splits!.map((v) => v.toJson()).toList();
//     }
//     data['createdAt'] = createdAt;
//     data['updatedAt'] = updatedAt;
//     data['__v'] = iV;
//     data['rideAccpet_date'] = rideAccpetDate;
//     data['acceptId'] = acceptId;
//     data['otp'] = otp;
//     data['rideArrive_date'] = rideArriveDate;
//     data['rideStart_date'] = rideStartDate;
//     data['admin_fees'] = adminFees;
//     data['driver_amount'] = driverAmount;
//     data['rideComplet_date'] = rideCompletDate;
//     data['tripRating'] = tripRating;
//     data['vehicleImage'] = vehicleImage;
//     data['profilePicUser'] = profilePicUser;
//     data['vehiclModel'] = vehiclModel;
//     data['vehiclNumber'] = vehiclNumber;
//     data['vehiclColor'] = vehiclColor;
//     data['user_rating'] = userRating;
//     data['rideType'] = rideType;
//     data['ridebooking_date'] = ridebookingDate;
//     data['ridebooking_time'] = ridebookingTime;
//     return data;
//   }
// }

// class UserId {
//   String? sId;
//   String? firstName;
//   String? profilePic;

//   UserId({this.sId, this.firstName, this.profilePic});

//   UserId.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     firstName = json['firstName'];
//     profilePic = json['profilePic'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['_id'] = sId;
//     data['firstName'] = firstName;
//     data['profilePic'] = profilePic;
//     return data;
//   }
// }

// class FromLocation {
//   String? type;
//   List<double>? coordinates;

//   FromLocation({this.type, this.coordinates});

//   FromLocation.fromJson(Map<String, dynamic> json) {
//     type = json['type'];
//     coordinates = json['coordinates'].cast<double>();
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['type'] = type;
//     data['coordinates'] = coordinates;
//     return data;
//   }
// }

// class Stops {
//   String? stopAddress;
//   String? stopLatitude;
//   String? stopLongitude;
//   int? status;
//   String? sId;
//   List<dynamic>? members;

//   Stops(
//       {this.stopAddress,
//       this.stopLatitude,
//       this.stopLongitude,
//       this.status,
//       this.sId,
//       this.members});

//   Stops.fromJson(Map<String, dynamic> json) {
//     stopAddress = json['stop_address'];
//     stopLatitude = json['stop_latitude'];
//     stopLongitude = json['stop_longitude'];
//     status = json['status'];
//     sId = json['_id'];
//     members = json['members'];
    
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['stop_address'] = stopAddress;
//     data['stop_latitude'] = stopLatitude;
//     data['stop_longitude'] = stopLongitude;
//     data['status'] = status;
//     data['_id'] = sId;
//     data['members'] = members;
    
//     return data;
//   }
// }

// class CustomerData {
//   String? name;
//   String? phone;
//   String? email;

//   CustomerData({this.name, this.phone, this.email});

//   CustomerData.fromJson(Map<String, dynamic> json) {
//     name = json['name'];
//     phone = json['phone'];
//     email = json['email'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['name'] = name;
//     data['phone'] = phone;
//     data['email'] = email;
//     return data;
//   }
// }

// class Splits {
//   String? name;
//   String? number;
//   double? price;
//   int? status;
//   String? sId;

//   Splits({this.name, this.number, this.price, this.status, this.sId});

//   Splits.fromJson(Map<String, dynamic> json) {
//     name = json['name'];
//     number = json['number'];
//     price = json['price'];
//     status = json['status'];
//     sId = json['_id'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['name'] = name;
//     data['number'] = number;
//     data['price'] = price;
//     data['status'] = status;
//     data['_id'] = sId;
//     return data;
//   }
// }




class DriverRideHistory {
  int? status;
  String? message;
  List<RideHistory>? rideHistory;
  int? completedRidesCount;

  DriverRideHistory(
      {this.status, this.message, this.rideHistory, this.completedRidesCount});

  DriverRideHistory.fromJson(Map<String, dynamic> json) {
    final s = json['status'];
    status = s is int ? s : (s is String ? int.tryParse(s) : null);
    message = json['message']?.toString();
    final list = json['rideHistory'] ?? json['ride_history'];
    if (list is List && list.isNotEmpty) {
      rideHistory = <RideHistory>[];
      for (final e in list) {
        if (e is! Map) continue;
        try {
          rideHistory!.add(RideHistory.fromJson(Map<String, dynamic>.from(e)));
        } catch (_) {}
      }
    } else {
      rideHistory = <RideHistory>[];
    }
    completedRidesCount = json['completedRidesCount'] ?? json['completed_rides_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.rideHistory != null) {
      data['rideHistory'] = this.rideHistory!.map((v) => v.toJson()).toList();
    }
    data['completedRidesCount'] = this.completedRidesCount;
    return data;
  }
}

class RideHistory {
  String? sId;
  UserId? userId;
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
  String? eventId;
  String? rideType;
  List<CustomerData>? customerData;
  List<dynamic>? shareRideData;
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
  String? rideArriveDate;
  String? rideStartDate;
  String? adminFees;
  String? driverAmount;
  String? rideCompletDate;
  int? tripRating;
  String? vehicleImage;
  String? profilePicUser;
  String? vehiclModel;
  String? vehiclNumber;
  String? vehiclColor;
  int? userRating;

  RideHistory(
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
      this.rideArriveDate,
      this.rideStartDate,
      this.adminFees,
      this.driverAmount,
      this.rideCompletDate,
      this.tripRating,
      this.vehicleImage,
      this.profilePicUser,
      this.vehiclModel,
      this.vehiclNumber,
      this.vehiclColor,
      this.userRating});

  RideHistory.fromJson(Map<String, dynamic> json) {
    sId = json['_id']?.toString();
    try {
      userId = json['userId'] != null && json['userId'] is Map
          ? UserId.fromJson(Map<String, dynamic>.from(json['userId']))
          : null;
    } catch (_) {
      userId = null;
    }
    fromAddress = json['from_address']?.toString();
    toAddress = json['to_address']?.toString();
    try {
      fromLocation = json['from_location'] != null && json['from_location'] is Map
          ? FromLocation.fromJson(Map<String, dynamic>.from(json['from_location']))
          : null;
    } catch (_) {
      fromLocation = null;
    }
    try {
      toLocation = json['to_location'] != null && json['to_location'] is Map
          ? FromLocation.fromJson(Map<String, dynamic>.from(json['to_location']))
          : null;
    } catch (_) {
      toLocation = null;
    }
    vehicleType = json['vehicleType']?.toString();
    final stopsList = json['stops'];
    if (stopsList is List) {
      stops = stopsList
          .whereType<Map>()
          .map((v) => Stops.fromJson(Map<String, dynamic>.from(v)))
          .toList();
    } else {
      stops = <Stops>[];
    }

    final splitsList = json['splits'];
    if (splitsList is List) {
      splits = List<dynamic>.from(splitsList);
    } else {
      splits = <dynamic>[];
    }
    driverId = json['driverId'];
    price = json['price'];
    currencySymbol = json['currencySymbol'];
    status = json['status'];
    saftyNotification = json['safty_notification'];
    stopNotification = json['stop_notification'];
    tax = json['tax'];
    final declinedList = json['declinedDrivers'];
    if (declinedList is List) {
      declinedDrivers = List<dynamic>.from(declinedList);
    } else {
      declinedDrivers = <dynamic>[];
    }
    eventId = json['eventId'];
    rideType = json['rideType'];
    final customerList = json['customerData'];
    if (customerList is List) {
      customerData = <CustomerData>[];
      for (final v in customerList) {
        if (v is! Map) continue;
        try {
          customerData!.add(CustomerData.fromJson(Map<String, dynamic>.from(v)));
        } catch (_) {}
      }
    } else {
      customerData = <CustomerData>[];
    }
    final shareList = json['shareRideData'];
    if (shareList is List) {
      shareRideData = List<dynamic>.from(shareList);
    } else {
      shareRideData = <dynamic>[];
    }

    final visibleList = json['visibleRide'];
    if (visibleList is List) {
      visibleRide = visibleList.map((e) => e.toString()).toList();
    } else {
      visibleRide = <String>[];
    }
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
    rideArriveDate = json['rideArrive_date'];
    rideStartDate = json['rideStart_date'];
    adminFees = json['admin_fees'];
    driverAmount = json['driver_amount'];
    rideCompletDate = json['rideComplet_date'];
    tripRating = json['tripRating'];
    vehicleImage = json['vehicleImage'];
    profilePicUser = json['profilePicUser'];
    vehiclModel = json['vehiclModel'];
    vehiclNumber = json['vehiclNumber'];
    vehiclColor = json['vehiclColor'];
    userRating = json['user_rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.userId != null) {
      data['userId'] = this.userId!.toJson();
    }
    data['from_address'] = this.fromAddress;
    data['to_address'] = this.toAddress;
    if (this.fromLocation != null) {
      data['from_location'] = this.fromLocation!.toJson();
    }
    if (this.toLocation != null) {
      data['to_location'] = this.toLocation!.toJson();
    }
    data['vehicleType'] = this.vehicleType;
    if (this.stops != null) {
      data['stops'] = this.stops!.map((v) => v.toJson()).toList();
    }
    if (this.splits != null) {
      data['splits'] = this.splits;
    }
    data['driverId'] = this.driverId;
    data['price'] = this.price;
    data['currencySymbol'] = this.currencySymbol;
    data['status'] = this.status;
    data['safty_notification'] = this.saftyNotification;
    data['stop_notification'] = this.stopNotification;
    data['tax'] = this.tax;
    if (this.declinedDrivers != null) {
      data['declinedDrivers'] = this.declinedDrivers;
    }
    data['eventId'] = this.eventId;
    data['rideType'] = this.rideType;
    if (this.customerData != null) {
      data['customerData'] = this.customerData!.map((v) => v.toJson()).toList();
    }
    if (this.shareRideData != null) {
      data['shareRideData'] = this.shareRideData;
    }
    data['visibleRide'] = this.visibleRide;
    data['isScheduledRide'] = this.isScheduledRide;
    data['bookingRideStatus'] = this.bookingRideStatus;
    data['DriverAcceptRequest'] = this.driverAcceptRequest;
    data['ridebooking_date'] = this.ridebookingDate;
    data['ridebooking_time'] = this.ridebookingTime;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['rideAccpet_date'] = this.rideAccpetDate;
    data['acceptId'] = this.acceptId;
    data['otp'] = this.otp;
    data['rideArrive_date'] = this.rideArriveDate;
    data['rideStart_date'] = this.rideStartDate;
    data['admin_fees'] = this.adminFees;
    data['driver_amount'] = this.driverAmount;
    data['rideComplet_date'] = this.rideCompletDate;
    data['tripRating'] = this.tripRating;
    data['vehicleImage'] = this.vehicleImage;
    data['profilePicUser'] = this.profilePicUser;
    data['vehiclModel'] = this.vehiclModel;
    data['vehiclNumber'] = this.vehiclNumber;
    data['vehiclColor'] = this.vehiclColor;
    data['user_rating'] = this.userRating;
    return data;
  }
}

class UserId {
  String? sId;
  String? firstName;

  UserId({this.sId, this.firstName});

  UserId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    firstName = json['firstName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['firstName'] = this.firstName;
    return data;
  }
}

class FromLocation {
  String? type;
  List<double>? coordinates;

  FromLocation({this.type, this.coordinates});

  FromLocation.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    final coords = json['coordinates'];
    if (coords is List) {
      coordinates = coords
          .whereType<num>()
          .map((e) => e.toDouble())
          .toList();
    } else {
      coordinates = <double>[];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['coordinates'] = this.coordinates;
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
    final membersList = json['members'];
    if (membersList is List) {
      members = List<dynamic>.from(membersList);
    } else {
      members = <dynamic>[];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['stop_address'] = this.stopAddress;
    data['stop_latitude'] = this.stopLatitude;
    data['stop_longitude'] = this.stopLongitude;
    data['status'] = this.status;
    data['_id'] = this.sId;
    if (this.members != null) {
      data['members'] = this.members;
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
    email = json['email']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['email'] = this.email;
    return data;
  }
}