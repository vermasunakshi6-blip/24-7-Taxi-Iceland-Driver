class RiderCancelRide {
  int? status;
  String? message;

  RiderCancelRide({this.status, this.message});

  RiderCancelRide.fromJson(Map<String, dynamic> json) {
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
