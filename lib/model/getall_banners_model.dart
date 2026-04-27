class GetAllBannersModel {
  int? status;
  List<BannerData>? data;

  GetAllBannersModel({this.status, this.data});

  GetAllBannersModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <BannerData>[];
      json['data'].forEach((v) {
        data!.add(BannerData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BannerData {
  String? sId;
  String? bannerName;
  String? bannerPic;
  int? status;
  String? startDate;
  String? endDate;
  String? startTime;
  String? endTime;
  String? createdAt;
  String? updatedAt;
  int? iV;
  int? bannerStatus;
  String? type;

  BannerData(
      {this.sId,
      this.bannerName,
      this.bannerPic,
      this.status,
      this.startDate,
      this.endDate,
      this.startTime,
      this.endTime,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.bannerStatus,
      this.type});

  BannerData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    bannerName = json['bannerName'];
    bannerPic = json['bannerPic'];
    status = json['status'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    bannerStatus = json['bannerStatus'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['bannerName'] = bannerName;
    data['bannerPic'] = bannerPic;
    data['status'] = status;
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    data['startTime'] = startTime;
    data['endTime'] = endTime;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['bannerStatus'] = bannerStatus;
    data['type'] = type;
    return data;
  }
}