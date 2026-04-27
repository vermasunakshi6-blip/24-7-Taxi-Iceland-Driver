class MyTripsDetails {
  int? status;
  String? message;
  List<MyTripsData>? data;
  int? totalRideCount;
 
  MyTripsDetails({this.status, this.message, this.data});
  MyTripsDetails.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <MyTripsData>[];
      json['data'].forEach((v) {
        data!.add(MyTripsData.fromJson(v));
      });
    }
    totalRideCount = json['totalRideCount'];
  }
 
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['totalRideCount'] = totalRideCount;
    return data;
  }
}
class MyTripsData {
  String? sId;
  String? userId;
  String? fromAddress;
  String? toAddress;
  FromLocation? fromLocation;
  FromLocation? toLocation;
  String? vehicleType;
  List<Stops>? stops;
  DriverId? driverId;
  String? price;
  String? currencySymbol;
  int? status;
  int? saftyNotification;
  int? stopNotification;
  int? tax;
  List<dynamic>? declinedDrivers;
  List<CustomerData>? customerData;
 
  int? isScheduledRide;
  int? packageType;
  String? packageWeight;
  int? deliveryType;
  String? recipientsName;
  String? recipientsNumber;
  int? bookingRideStatus;
  List<dynamic>? splits;





  String? rideArriveDate;
  String? rideStartDate;
  String? adminFees;
  String? driverAmount;
  String? rideCompletDate;
  String? vehiclModel;
  String? vehiclNumber;
  String? vehiclColor;
  String? vehicleImage;
  dynamic tripRating;
  String? comment;
  String? userFeedback;
  int? averageRating;
  String? rideType;
  String? ridebookingDate;
  String? ridebookingTime;

  MyTripsData(
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
      this.customerData,
     
      this.isScheduledRide,
      this.packageType,
      this.packageWeight,
      this.deliveryType,
      this.recipientsName,
      this.recipientsNumber,
      this.bookingRideStatus,
      this.splits,
     
      this.rideArriveDate,
      this.rideStartDate,
      this.adminFees,
      this.driverAmount,
      this.rideCompletDate,
      this.vehiclModel,
      this.vehiclNumber,
      this.vehiclColor,
      this.vehicleImage,
      this.tripRating,
      this.comment,
      this.userFeedback,
      this.averageRating,
      this.rideType,
      this.ridebookingDate,
      this.ridebookingTime});

  MyTripsData.fromJson(Map<String, dynamic> json) {
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
    driverId = json['driverId'] != null
        ? DriverId.fromJson(json['driverId'])
        : null;
    price = json['price'];
    currencySymbol = json['currencySymbol'];
    status = json['status'];
    saftyNotification = json['safty_notification'];
    stopNotification = json['stop_notification'];
    tax = json['tax'];
      declinedDrivers = json['declinedDrivers'];
    if (json['customerData'] != null) {
      customerData = <CustomerData>[];
      json['customerData'].forEach((v) {
        customerData!.add(CustomerData.fromJson(v));
      });
    }
    isScheduledRide = json['isScheduledRide'];
    packageType = json['packageType'];
    packageWeight = json['packageWeight'];
    deliveryType = json['deliveryType'];
    recipientsName = json['recipientsName'];
    recipientsNumber = json['recipientsNumber'];
    bookingRideStatus = json['bookingRideStatus'];
      splits = json['splits'];
    
    rideArriveDate = json['rideArrive_date'];
    rideStartDate = json['rideStart_date'];
    adminFees = json['admin_fees'];
    driverAmount = json['driver_amount'];
    rideCompletDate = json['rideComplet_date'];
    vehiclModel = json['vehiclModel'];
    vehiclNumber = json['vehiclNumber'];
    vehiclColor = json['vehiclColor'];
    vehicleImage = json['vehicleImage'];
    tripRating = json['tripRating'];
    comment = json['comment'];
    userFeedback = json['userFeedback'].toString();
    averageRating = json['averageRating'];
    rideType = json['rideType'];
    ridebookingDate = json['ridebooking_date'];
    ridebookingTime = json['ridebooking_time'];
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
    if (driverId != null) {
      data['driverId'] = driverId!.toJson();
    }
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
    if (customerData != null) {
      data['customerData'] = customerData!.map((v) => v.toJson()).toList();
    }
 
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
  
    data['rideArrive_date'] = rideArriveDate;
    data['rideStart_date'] = rideStartDate;
    data['admin_fees'] = adminFees;
    data['driver_amount'] = driverAmount;
    data['rideComplet_date'] = rideCompletDate;
    data['vehiclModel'] = vehiclModel;
    data['vehiclNumber'] = vehiclNumber;
    data['vehiclColor'] = vehiclColor;
    data['vehicleImage'] = vehicleImage;
    data['tripRating'] = tripRating;
    data['comment'] = comment;
    data['userFeedback'] = userFeedback;
    data['averageRating'] = averageRating;
    data['rideType'] = rideType;
    data['ridebooking_date'] = ridebookingDate;
    data['ridebooking_time'] = ridebookingTime;
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
  String? stopLatitude;
  String? stopLongitude;
  int? status;
  String? sId;
  String? stopAddress;

  Stops(
      {this.stopLatitude,
      this.stopLongitude,
      this.status,
      this.sId,
      this.stopAddress});

  Stops.fromJson(Map<String, dynamic> json) {
    stopLatitude = json['stop_latitude'];
    stopLongitude = json['stop_longitude'];
    status = json['status'];
    sId = json['_id'];
    stopAddress = json['stop_address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['stop_latitude'] = stopLatitude;
    data['stop_longitude'] = stopLongitude;
    data['status'] = status;
    data['_id'] = sId;
    data['stop_address'] = stopAddress;
    return data;
  }
}

class DriverId {
  String? sId;
  String? firstName;
  String? profilePic;

  DriverId({this.sId, this.firstName, this.profilePic});

  DriverId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    firstName = json['firstName'];
    profilePic = json['profilePic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['firstName'] = firstName;
    data['profilePic'] = profilePic;
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
