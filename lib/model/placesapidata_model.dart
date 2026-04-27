class PlacesApiModel {
  List<Results>? results;

  PlacesApiModel({this.results});

  PlacesApiModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Results {
  String? formattedAddress;
  Geometry? geometry;

  Results({this.formattedAddress, this.geometry});

  Results.fromJson(Map<String, dynamic> json) {
    formattedAddress = json['formatted_address'];
    geometry =
        json['geometry'] != null ? Geometry.fromJson(json['geometry']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['formatted_address'] = formattedAddress;
    if (geometry != null) {
      data['geometry'] = geometry!.toJson();
    }
    return data;
  }
}

class Geometry {
  Location? location;

  Geometry({this.location});

  Geometry.fromJson(Map<String, dynamic> json) {
    location =
        json['location'] != null ? Location.fromJson(json['location']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (location != null) {
      data['location'] = location!.toJson();
    }
    return data;
  }
}

class Location {
  double? lat;
  double? lng;

  Location({this.lat, this.lng});

  Location.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lat'] = lat;
    data['lng'] = lng;
    return data;
  }
}
