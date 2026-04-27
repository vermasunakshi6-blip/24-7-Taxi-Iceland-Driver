class DistanceTimeModel {
  int? status;
  String? message;
  List<DataLegs>? data;

  DistanceTimeModel({this.status, this.message, this.data});

  DistanceTimeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <DataLegs>[];
      json['data'].forEach((v) {
        data!.add(DataLegs.fromJson(v));
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

class DataLegs {
  String? summary;
  List<LegsData>? legs;

  DataLegs({this.summary, this.legs});

  DataLegs.fromJson(Map<String, dynamic> json) {
    summary = json['summary'];
    if (json['legs'] != null) {
      legs = <LegsData>[];
      json['legs'].forEach((v) {
        legs!.add(LegsData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['summary'] = summary;
    if (legs != null) {
      data['legs'] = legs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LegsData {
  String? title;
  
  
  Distance? distance;
  Distance? duration;
 

  LegsData(
      {
        this.title,
         
     
      this.distance,
      this.duration,
     });

  LegsData.fromJson(Map<String, dynamic> json) {
    title = json['title'];
   
    
    distance = json['distance'] != null
        ? Distance.fromJson(json['distance'])
        : null;
    duration = json['duration'] != null
        ? Distance.fromJson(json['duration'])
        : null;
    
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
  
   
    if (distance != null) {
      data['distance'] = distance!.toJson();
    }
    if (duration != null) {
      data['duration'] = duration!.toJson();
    }
    
    return data;
  }
}

class Distance {
  String? text;
  int? value;

  Distance({this.text, this.value});

  Distance.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['text'] = text;
    data['value'] = value;
    return data;
  }
}

 

 