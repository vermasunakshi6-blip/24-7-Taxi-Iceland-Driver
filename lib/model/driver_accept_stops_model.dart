
class DriverAcceptStopsModel {
  int? status;
  String? message;

  DriverAcceptStopsModel({this.status, this.message});

  DriverAcceptStopsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    return data;
  }
}