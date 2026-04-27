class CreateRideNewModel {
  int? status;
  String? message;
  Data? data;

  CreateRideNewModel({this.status, this.message, this.data});

  CreateRideNewModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ?  Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  FromLocation? fromLocation;
  FromLocation? toLocation;
  String? sId;
  String? userId;
  String? fromAddress;
  String? toAddress;
  String? vehicleType;
  List<Stops>? stops;
  String? driverId;
  String? price;
  String? currencySymbol;
  int? status;
  int? saftyNotification;
  int? stopNotification;
  int? tax;
 
  String? createdAt;
  String? updatedAt;
  int? iV;

  Data(
      {this.fromLocation,
      this.toLocation,
      this.sId,
      this.userId,
      this.fromAddress,
      this.toAddress,
      this.vehicleType,
      this.stops,
      this.driverId,
      this.price,
      this.currencySymbol,
      this.status,
      this.saftyNotification,
      this.stopNotification,
      this.tax,
      
      this.createdAt,
      this.updatedAt,
      this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    fromLocation = json['from_location'] != null
        ?  FromLocation.fromJson(json['from_location'])
        : null;
    toLocation = json['to_location'] != null
        ?  FromLocation.fromJson(json['to_location'])
        : null;
    sId = json['_id'];
    userId = json['userId'];
    fromAddress = json['from_address'];
    toAddress = json['to_address'];
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
    
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    if (fromLocation != null) {
      data['from_location'] = fromLocation!.toJson();
    }
    if (toLocation != null) {
      data['to_location'] = toLocation!.toJson();
    }
    data['_id'] = sId;
    data['userId'] = userId;
    data['from_address'] = fromAddress;
    data['to_address'] = toAddress;
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
        members!.add( Members.fromJson(v));
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