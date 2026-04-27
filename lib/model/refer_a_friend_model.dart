class ReferaFriendModel {
  int? status;
  String? message;
  Errors? errors;

  ReferaFriendModel({this.status, this.message, this.errors});

  ReferaFriendModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    errors =
        json['errors'] != null ? Errors.fromJson(json['errors']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (errors != null) {
      data['errors'] = errors!.toJson();
    }
    return data;
  }
}

class Errors {
  String? checkUser;

  Errors({this.checkUser});

  Errors.fromJson(Map<String, dynamic> json) {
    checkUser = json['checkUser'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['checkUser'] = checkUser;
    return data;
  }
}