class GetReferredFriendsModel {
  int? status;
  String? message;
  List<ReferData>? data;

  GetReferredFriendsModel({this.status, this.message, this.data});

  GetReferredFriendsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ReferData>[];
      json['data'].forEach((v) {
        data!.add(ReferData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ReferData {
  String? fullName;
  String? profilePic;

  ReferData({this.fullName, this.profilePic});

  ReferData.fromJson(Map<String, dynamic> json) {
    fullName = json['fullName'];
    profilePic = json['profilePic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fullName'] = fullName;
    data['profilePic'] = profilePic;
    return data;
  }
}