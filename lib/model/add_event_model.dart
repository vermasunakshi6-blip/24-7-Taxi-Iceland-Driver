class AddEventModel {
  int? status;
  String? message;
  Errors? errors;
  Data? data;

  AddEventModel({this.status, this.message, this.data});

  AddEventModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    errors =
        data['errors'] != null ? Errors.fromJson(data['errors']) : null;
    return data;
  }
}

class Data {
  String? userId;
  String? userName;
  String? eventName;
  String? eventDate;
  String? eventTime;
  String? eventType;
  String? email;
  String? countryCode;
  String? phone;
  String? address1;
  String? address2;
  String? state;
  String? city;
  int? status;
  String? eventPic;
  String? sId;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Data(
      {this.userId,
      this.userName,
      this.eventName,
      this.eventDate,
      this.eventTime,
      this.eventType,
      this.email,
      this.countryCode,
      this.phone,
      this.address1,
      this.address2,
      this.state,
      this.city,
      this.status,
      this.eventPic,
      this.sId,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    userName = json['userName'];
    eventName = json['eventName'];
    eventDate = json['eventDate'];
    eventTime = json['eventTime'];
    eventType = json['eventType'];
    email = json['email'];
    countryCode = json['countryCode'];
    phone = json['phone'];
    address1 = json['address1'];
    address2 = json['address2'];
    state = json['state'];
    city = json['city'];
    status = json['status'];
    eventPic = json['eventPic'];
    sId = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['userName'] = userName;
    data['eventName'] = eventName;
    data['eventDate'] = eventDate;
    data['eventTime'] = eventTime;
    data['eventType'] = eventType;
    data['email'] = email;
    data['countryCode'] = countryCode;
    data['phone'] = phone;
    data['address1'] = address1;
    data['address2'] = address2;
    data['state'] = state;
    data['city'] = city;
    data['status'] = status;
    data['eventPic'] = eventPic;
    data['_id'] = sId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
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