class NearDriverModel {
  int? status;
  String? message;
  String? userId;
  int? driverCount;
  int? minEstimate;
  int? maxEstimate;

  NearDriverModel(
      {this.status,
      this.message,
      this.userId,
      this.driverCount,
      this.minEstimate,
      this.maxEstimate});

  NearDriverModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    userId = json['userId'];
    driverCount = json['driverCount'];
    minEstimate = json['minEstimate'];
    maxEstimate = json['maxEstimate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['userId'] = userId;
    data['driverCount'] = driverCount;
    data['minEstimate'] = minEstimate;
    data['maxEstimate'] = maxEstimate;
    return data;
  }
}