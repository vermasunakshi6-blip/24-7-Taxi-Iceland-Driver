class DistanceModel {
  List<Routes>? routes;

  DistanceModel({this.routes});

  DistanceModel.fromJson(Map<String, dynamic> json) {
    if (json['routes'] != null) {
      routes = <Routes>[];
      json['routes'].forEach((v) {
        routes!.add( Routes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    if (routes != null) {
      data['routes'] = routes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Routes {
  List<Legs>? legs;

  Routes({this.legs});

  Routes.fromJson(Map<String, dynamic> json) {
    if (json['legs'] != null) {
      legs = <Legs>[];
      json['legs'].forEach((v) {
        legs!.add( Legs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    if (legs != null) {
      data['legs'] = legs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Legs {
  Distance? distance;
  Distance? duration;

  Legs({this.distance, this.duration});

  Legs.fromJson(Map<String, dynamic> json) {
    distance = json['distance'] != null
        ?  Distance.fromJson(json['distance'])
        : null;
    duration = json['duration'] != null
        ?  Distance.fromJson(json['duration'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
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
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['text'] = text;
    data['value'] = value;
    return data;
  }
}