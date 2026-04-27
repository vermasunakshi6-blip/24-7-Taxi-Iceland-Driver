class AddParcelModel {
  int? status;
  String? message;
  Errors? errors;
  Data? data;

  AddParcelModel({this.status, this.message, this.data});

  AddParcelModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    errors =
        json['errors'] != null ? Errors.fromJson(json['errors']) : null;
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
     if (errors != null) {
      data['errors'] = errors!.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
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
  List<dynamic>? declinedDrivers;
  List<CustomerData>? customerData;
  List<String>? visibleRide;
  int? isScheduledRide;
  int? packageType;
  String? packageWeight;
  int? deliveryType;
  String? recipientsName;
  String? recipientsNumber;
  int? bookingRideStatus;
  String? sId;
  List<dynamic>? splits;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Data(
      {this.userId,
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
      this.visibleRide,
      this.isScheduledRide,
      this.packageType,
      this.packageWeight,
      this.deliveryType,
      this.recipientsName,
      this.recipientsNumber,
      this.bookingRideStatus,
      this.sId,
      this.splits,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Data.fromJson(Map<String, dynamic> json) {
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
    visibleRide = json['visibleRide'].cast<String>();
    isScheduledRide = json['isScheduledRide'];
    packageType = json['packageType'];
    packageWeight = json['packageWeight'];
    deliveryType = json['deliveryType'];
    recipientsName = json['recipientsName'];
    recipientsNumber = json['recipientsNumber'];
    bookingRideStatus = json['bookingRideStatus'];
    sId = json['_id'];
    splits = json['splits'];
    
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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
    if (declinedDrivers != null) {
      data['declinedDrivers'] =
          declinedDrivers!.map((v) => v.toJson()).toList();
    }
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
    data['_id'] = sId;
    if (splits != null) {
      data['splits'] = splits!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
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
    members = json['members'];
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
class Errors {
  String? views;

  Errors({this.views});

  Errors.fromJson(Map<String, dynamic> json) {
    views = json['views'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['views'] = views;
    return data;
  }
}