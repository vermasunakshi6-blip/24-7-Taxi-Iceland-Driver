class VideoRewardsModel {
  int? status;
  String? message;
  Errors? errors;
  List<RewardsData>? data;

  VideoRewardsModel({this.status, this.message, this.data,this.errors});

  VideoRewardsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
     errors =
        json['errors'] != null ? Errors.fromJson(json['errors']) : null;
    if (json['data'] != null) {
      data = <RewardsData>[];
      json['data'].forEach((v) {
        data!.add(RewardsData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (errors != null) {
      data['errors'] = errors!.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RewardsData {
  String? watchId;
  dynamic views;
  String? timestamp;
  WatchDetails? watchDetails;

  RewardsData({this.watchId, this.views, this.timestamp, this.watchDetails});

  RewardsData.fromJson(Map<String, dynamic> json) {
    watchId = json['watchId'];
    views = json['views'];
    timestamp = json['timestamp'];
    watchDetails = json['watchDetails'] != null
        ? WatchDetails.fromJson(json['watchDetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['watchId'] = watchId;
    data['views'] = views;
    data['timestamp'] = timestamp;
    if (watchDetails != null) {
      data['watchDetails'] = watchDetails!.toJson();
    }
    return data;
  }
}

class WatchDetails {
  String? sId;
  String? title;
  String? videoUrl;
  String? contentType;
  String? thumbnailUrl;
  int? status;
  String? category;
  String? duration;
  List<Reward>? reward;
  String? createdAt;
  String? updatedAt;
  int? iV;

  WatchDetails(
      {this.sId,
      this.title,
      this.videoUrl,
      this.contentType,
      this.thumbnailUrl,
      this.status,
      this.category,
      this.duration,
      this.reward,
      this.createdAt,
      this.updatedAt,
      this.iV});

  WatchDetails.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    videoUrl = json['videoUrl'];
    contentType = json['contentType'];
    thumbnailUrl = json['thumbnailUrl'];
    status = json['status'];
    category = json['category'];
    duration = json['duration'];
    if (json['reward'] != null) {
      reward = <Reward>[];
      json['reward'].forEach((v) {
        reward!.add(Reward.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['title'] = title;
    data['videoUrl'] = videoUrl;
    data['contentType'] = contentType;
    data['thumbnailUrl'] = thumbnailUrl;
    data['status'] = status;
    data['category'] = category;
    data['duration'] = duration;
    if (reward != null) {
      data['reward'] = reward!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class Reward {
  String? currency;
  dynamic amount;
  String? sId;

  Reward({this.currency, this.amount, this.sId});

  Reward.fromJson(Map<String, dynamic> json) {
    currency = json['currency'];
    amount = json['amount'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['currency'] = currency;
    data['amount'] = amount;
    data['_id'] = sId;
    return data;
  }
}
class Errors {
  String? views;

  Errors({this.views});

  Errors.fromJson(Map<String, dynamic> json) {
    views = json['views'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['views'] = views;
    return data;
  }
}