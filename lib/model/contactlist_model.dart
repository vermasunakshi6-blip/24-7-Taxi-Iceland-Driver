
class ContactListModel {
  int? status;
  String? message;
  DataContacts? data;

  ContactListModel({this.status, this.message, this.data});

  ContactListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ?  DataContacts.fromJson(json['data']) : null;
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

class DataContacts {
  List<Registered>? registered;
  List<Unregistered>? unregistered;

  DataContacts({this.registered, this.unregistered});

  DataContacts.fromJson(Map<String, dynamic> json) {
    if (json['registered'] != null) {
      registered = <Registered>[];
      json['registered'].forEach((v) {
        registered!.add( Registered.fromJson(v));
      });
    }
    if (json['unregistered'] != null) {
      unregistered = <Unregistered>[];
      json['unregistered'].forEach((v) {
        unregistered!.add( Unregistered.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    if (registered != null) {
      data['registered'] = registered!.map((v) => v.toJson()).toList();
    }
    if (unregistered != null) {
      data['unregistered'] = unregistered!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Registered {
  String? name;
  String? phone;
  String? type;
  String? profilePic;
  String? email;
  String? id;

  Registered({this.name, this.phone, this.type, this.profilePic});

  Registered.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    type = json['Type'];
    profilePic = json['profilePic'];
    email = json['email'];
    id = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['name'] = name;
    data['phone'] = phone;
    data['Type'] = type;
    data['profilePic'] = profilePic;
    data['email'] = email;
    data['_id'] = id;
    
    return data;
  }
}

class Unregistered {
  String? name;
  String? phone;
  String? profilePic;
  int? isInvite;

  Unregistered({this.name, this.phone, this.profilePic, this.isInvite});

  Unregistered.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    profilePic = json['profilePic'];
    isInvite = json['isInvite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['phone'] = phone;
    data['profilePic'] = profilePic;
    data['isInvite'] = isInvite;
    return data;
  }
}