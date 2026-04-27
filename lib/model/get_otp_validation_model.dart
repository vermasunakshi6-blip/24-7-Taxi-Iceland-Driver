class GetOtpValidation {
  int? status;
  String? phone;
  int? attemptsToday;
  int? remainingAttempts;
  String? message;

  GetOtpValidation(
      {this.status,
      this.phone,
      this.attemptsToday,
      this.remainingAttempts,
      this.message});

  GetOtpValidation.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    phone = json['phone'];
    attemptsToday = json['attemptsToday'];
    remainingAttempts = json['remainingAttempts'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =   <String, dynamic>{};
    data['status'] = status;
    data['phone'] = phone;
    data['attemptsToday'] = attemptsToday;
    data['remainingAttempts'] = remainingAttempts;
    data['message'] = message;
    return data;
  }
}