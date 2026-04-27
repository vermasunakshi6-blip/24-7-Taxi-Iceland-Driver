class WatchtoEarnModel {
  int? status;
  String? message;
  List<Data>? data;

  WatchtoEarnModel({this.status, this.message, this.data});

  WatchtoEarnModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
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

class Data {
  String? sId;
  String? title;
  String? videoUrl;
  String? contentType;
  String? thumbnailUrl;
  int? status;
  String? category;
  String? duration;
  String? description;
  List<Reward>? reward;
  String? createdAt;
  String? updatedAt;
  int? iV;
  dynamic isLike;
  String? isViewed;
  int? totallikeCount;
  int? totalLoveCount;
  int? totalHappyCount;
  int? totalShockedCount;
  int? totalSadCount;
  int? totalAngryCount;
  int? totalReactionCount;
  int? totalviewsCount;
  int? totalLikes;

  Data(
      {this.sId,
      this.title,
      this.videoUrl,
      this.contentType,
      this.thumbnailUrl,
      this.status,
      this.category,
      this.duration,
      this.description,
      this.reward,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.isLike,
      this.isViewed,
      this.totallikeCount,
      this.totalLoveCount,
      this.totalHappyCount,
      this.totalShockedCount,
      this.totalSadCount,
      this.totalAngryCount,
      this.totalReactionCount,
      this.totalviewsCount,
      this.totalLikes});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    videoUrl = json['videoUrl'];
    contentType = json['contentType'];
    thumbnailUrl = json['thumbnailUrl'];
    status = json['status'];
    category = json['category'];
    duration = json['duration'];
    description = json['description'];
    if (json['reward'] != null) {
      reward = <Reward>[];
      json['reward'].forEach((v) {
        reward!.add(Reward.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    isLike = json['is_like'];
    isViewed = json['isViewed'];
    totallikeCount = json['totallikeCount'];
    totalLoveCount = json['totalLoveCount'];
    totalHappyCount = json['totalHappyCount'];
    totalShockedCount = json['totalShockedCount'];
    totalSadCount = json['totalSadCount'];
    totalAngryCount = json['totalAngryCount'];
    totalReactionCount = json['totalReactionCount'];
    totalviewsCount = json['totalviewsCount'];
    totalLikes = json['totalLikes'];
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
    data['description'] = description;
    if (reward != null) {
      data['reward'] = reward!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['is_like'] = isLike;
    data['isViewed'] = isViewed;
    data['totallikeCount'] = totallikeCount;
    data['totalLoveCount'] = totalLoveCount;
    data['totalHappyCount'] = totalHappyCount;
    data['totalShockedCount'] = totalShockedCount;
    data['totalSadCount'] = totalSadCount;
    data['totalAngryCount'] = totalAngryCount;
    data['totalReactionCount'] = totalReactionCount;
    data['totalviewsCount'] = totalviewsCount;
    data['totalLikes'] = totalLikes;
    return data;
  }
}

class Reward {
  String? currency;
  int? amount;
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