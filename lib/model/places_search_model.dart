class PlacesSearchModel {
  int? status;
  String? message;
  List<Data>? data;

  PlacesSearchModel({this.status, this.message, this.data});

  PlacesSearchModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(  Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =   <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? formattedAddress;
  SearchLocation? location;

  Data({this.formattedAddress, this.location});

  Data.fromJson(Map<String, dynamic> json) {
    formattedAddress = json['formatted_address'];
    location = json['location'] != null
        ?  SearchLocation.fromJson(json['location'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['formatted_address'] = formattedAddress;
    if (location != null) {
      data['location'] = location!.toJson();
    }
    return data;
  }
}

class SearchLocation {
  double? lat;
  double? lng;

  SearchLocation({this.lat, this.lng});

  SearchLocation.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['lat'] = lat;
    data['lng'] = lng;
    return data;
  }
}