class GetNearByRides {
  int? status;
  String? message;
  List<Data>? data;

  GetNearByRides({this.status, this.message, this.data});

  GetNearByRides.fromJson(Map<String, dynamic> json) {
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
  FromLocation? fromLocation;
  FromLocation? toLocation;
  String? sId;
  UserId? userId;
  String? fromAddress;
  String? toAddress;
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
   String? rideType;
  List<CustomerData>? customerData;
  List<String>? visibleRide;
  int? isScheduledRide;
  int? packageType;
  String? packageWeight;
  int? deliveryType;
  String? recipientsName;
  String? recipientsNumber;
  int? bookingRideStatus;
  String? ridebookingDate;
  String? ridebookingTime;
  String? createdAt;
  String? updatedAt;
  int? iV;
  int? userRating;

  Data({
    this.fromLocation,
    this.toLocation,
    this.sId,
    this.userId,
    this.fromAddress,
    this.toAddress,
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
    
    this.rideType,
    this.customerData,
    this.visibleRide,
      this.isScheduledRide,
      this.packageType,
      this.packageWeight,
      this.deliveryType,
      this.recipientsName,
      this.recipientsNumber,
      this.bookingRideStatus,
    this.ridebookingDate,
    this.ridebookingTime,
    this.createdAt,
    this.updatedAt,
    this.iV,
    this.userRating,
  });

  Data.fromJson(Map<String, dynamic> json) {
    fromLocation = json['from_location'] != null
        ? FromLocation.fromJson(json['from_location'])
        : null;
    toLocation = json['to_location'] != null
        ? FromLocation.fromJson(json['to_location'])
        : null;
    sId = json['_id'];
    userId = json['userId'] != null ? UserId.fromJson(json['userId']) : null;
    fromAddress = json['from_address'];
    toAddress = json['to_address'];
    vehicleType = json['vehicleType'];
    if (json['stops'] != null) {
      stops = <Stops>[];
      json['stops'].forEach((v) {
        stops!.add(Stops.fromJson(v));
      });
    }
    splits = json['splits'];
    driverId = json['driverId'];
    price = json['price'];
    currencySymbol = json['currencySymbol'];
    status = json['status'];
    saftyNotification = json['safty_notification'];
    stopNotification = json['stop_notification'];
    tax = json['tax'];
   
    rideType = json['rideType'];
    if (json['customerData'] != null) {
      customerData = <CustomerData>[];
      json['customerData'].forEach((v) {
        customerData!.add(CustomerData.fromJson(v));
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
    ridebookingDate = json['ridebooking_date'];
    ridebookingTime = json['ridebooking_time'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    userRating = json['user_rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['from_location'] = fromLocation?.toJson();
    data['to_location'] = toLocation?.toJson();
    data['_id'] = sId;
    data['userId'] = userId?.toJson();
    data['from_address'] = fromAddress;
    data['to_address'] = toAddress;
    data['vehicleType'] = vehicleType;
    data['stops'] = stops?.map((v) => v.toJson()).toList();
    data['splits'] = splits;
    data['driverId'] = driverId;
    data['price'] = price;
    data['currencySymbol'] = currencySymbol;
    data['status'] = status;
    data['safty_notification'] = saftyNotification;
    data['stop_notification'] = stopNotification;
    data['tax'] = tax;
   
    data['rideType'] = rideType;
    if (customerData != null) {
      data['customerData'] = customerData!.map((v) => v.toJson()).toList();
    }
    data['visibleRide'] = visibleRide;
    data['isScheduledRide'] = isScheduledRide;
    data['packageType'] = packageType;
    data['packageWeight'] = packageWeight;
    data['deliveryType'] = deliveryType;
    data['recipientsName'] = recipientsName;
    data['recipientsNumber'] = recipientsNumber;
    data['bookingRideStatus'] = bookingRideStatus;
    data['ridebooking_date'] = ridebookingDate;
    data['ridebooking_time'] = ridebookingTime;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['user_rating'] = userRating;
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

class FromLocation {
  String? type;
  List<double>? coordinates;

  FromLocation({this.type, this.coordinates});

  FromLocation.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    coordinates = json['coordinates']?.cast<double>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['coordinates'] = coordinates;
    return data;
  }
}

class UserId {
  String? sId;
  String? firstName;
  String? profilePic;

  UserId({this.sId, this.firstName, this.profilePic});

  UserId.fromJson(Map<String, dynamic> json) {
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

class Stops {
  dynamic stopAddress;
  String? stopLatitude;
  String? stopLongitude;
  int? status;
  String? sId;
  List<dynamic>? members;

  Stops({
    this.stopAddress,
    this.stopLatitude,
    this.stopLongitude,
    this.status,
    this.sId,
    this.members,
  });

  Stops.fromJson(Map<String, dynamic> json) {
    stopAddress = json['stop_address'];
    stopLatitude = json['stop_latitude'];
    stopLongitude = json['stop_longitude'];
    status = json['status'];
    sId = json['_id'];
    if (json['members'] != null) {
      members = <dynamic>[];
      json['members'].forEach((v) {
        members!.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['stop_address'] = stopAddress;
    data['stop_latitude'] = stopLatitude;
    data['stop_longitude'] = stopLongitude;
    data['status'] = status;
    data['_id'] = sId;
    data['members'] = members;
    return data;
  }
}
