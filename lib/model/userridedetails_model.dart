class UserRideDetails {


   
  int status;
  String message;
  Data data;

  UserRideDetails({
    required this.status,
    required this.message,
    required this.data,
  });

  factory UserRideDetails.fromJson(Map<String, dynamic> json) {
    return UserRideDetails(
      status: json['status'],
      message: json['message'],
      data: Data.fromJson(json['data']),
    );
  }
}

class Data {
  Locations fromLocation;
  Locations toLocation;
  String id;
  UserInfo userId;
  String fromAddress;
  String toAddress;
  String vehicleType;
  List<Stop> stops;
  List<dynamic> splits;
  String driverId;
  String price;
  String currencySymbol;
  int status;
  int safetyNotification;
  int stopNotification;
  int tax;
  String createdAt;
  String updatedAt;
  int v;
  String acceptId;
  String otp;
  int userRating;

  Data({
    required this.fromLocation,
    required this.toLocation,
    required this.id,
    required this.userId,
    required this.fromAddress,
    required this.toAddress,
    required this.vehicleType,
    required this.stops,
    required this.splits,
    required this.driverId,
    required this.price,
    required this.currencySymbol,
    required this.status,
    required this.safetyNotification,
    required this.stopNotification,
    required this.tax,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.acceptId,
    required this.otp,
    required this.userRating,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      fromLocation: Locations.fromJson(json['from_location']),
      toLocation: Locations.fromJson(json['to_location']),
      id: json['_id'],
      userId: UserInfo.fromJson(json['userId']),
      fromAddress: json['from_address'],
      toAddress: json['to_address'],
      vehicleType: json['vehicleType'],
      stops: List<Stop>.from(json['stops'].map((x) => Stop.fromJson(x))),
      splits: json['splits'],
      driverId: json['driverId'],
      price: json['price'],
      currencySymbol: json['currencySymbol'],
      status: json['status'],
      safetyNotification: json['safty_notification'],
      stopNotification: json['stop_notification'],
      tax: json['tax'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      v: json['__v'],
      acceptId: json['acceptId'],
      otp: json['otp'],
      userRating: json['userRating'],
    );
  }
}

class Locations {
  String type;
  List<double> coordinates;

  Locations({
    required this.type,
    required this.coordinates,
  });

  factory Locations.fromJson(Map<String, dynamic> json) {
    return Locations(
      type: json['type'],
      coordinates: List<double>.from(json['coordinates'].map((x) => x.toDouble())),
    );
  }
}

class UserInfo {
  String id;
  String firstName;
  String lastName;

  UserInfo({
    required this.id,
    required this.firstName,
    required this.lastName,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      id: json['_id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
    );
  }
}

class Stop {
  String stopAddress;
  String stopLatitude;
  String stopLongitude;
  int status;
  String id;
  List<dynamic> members;

  Stop({
    required this.stopAddress,
    required this.stopLatitude,
    required this.stopLongitude,
    required this.status,
    required this.id,
    required this.members,
  });

  factory Stop.fromJson(Map<String, dynamic> json) {
    return Stop(
      stopAddress: json['stop_address'],
      stopLatitude: json['stop_latitude'],
      stopLongitude: json['stop_longitude'],
      status: json['status'],
      id: json['_id'],
      members: json['members'],
    );
  }
}
