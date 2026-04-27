class GetContactModel {
  int? status;
  String? message;
  List<ContactData>? data;

  GetContactModel({this.status, this.message, this.data});

  GetContactModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ContactData>[];
      json['data'].forEach((v) {
        data!.add( ContactData.fromJson(v));
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

class ContactData {
  String? sId;
  String? name;
  String? phone;
  String? createdAt;

  ContactData({this.sId, this.name, this.phone, this.createdAt});

  ContactData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    phone = json['phone'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['phone'] = phone;
    data['createdAt'] = createdAt;
    return data;
  }
}