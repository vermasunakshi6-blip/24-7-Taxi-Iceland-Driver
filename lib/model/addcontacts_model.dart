class AddContactsModel {
  int? status;
  String? message;

  AddContactsModel({this.status, this.message});

  AddContactsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    return data;
  }
}