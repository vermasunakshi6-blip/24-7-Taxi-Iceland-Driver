class WeaklyGrapDataModel {
  int? status;
  String? message;
  num? totalWeeklyPrice;
  String? currencySymbol;
  WeekData? weekData;

  WeaklyGrapDataModel(
      {this.status,
      this.message,
      this.totalWeeklyPrice,
      this.currencySymbol,
      this.weekData});

  WeaklyGrapDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    totalWeeklyPrice = json['totalWeeklyPrice'];
    currencySymbol = json['currencySymbol'];
    weekData =
        json['weekData'] != null ? WeekData.fromJson(json['weekData']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['totalWeeklyPrice'] = totalWeeklyPrice;
    data['currencySymbol'] = currencySymbol;
    if (weekData != null) {
      data['weekData'] = weekData!.toJson();
    }
    return data;
  }
}

class WeekData {
  Tue? tue;
  Tue? wed;
  Tue? fri;
  Tue? thu;
  Mon? mon;
  Mon? sat;
  Mon? sun;

  WeekData(
      {this.tue, this.wed, this.fri, this.thu, this.mon, this.sat, this.sun});

  WeekData.fromJson(Map<String, dynamic> json) {
    tue = json['Tue'] != null ? Tue.fromJson(json['Tue']) : null;
    wed = json['Wed'] != null ? Tue.fromJson(json['Wed']) : null;
    fri = json['Fri'] != null ? Tue.fromJson(json['Fri']) : null;
    thu = json['Thu'] != null ? Tue.fromJson(json['Thu']) : null;
    mon = json['Mon'] != null ? Mon.fromJson(json['Mon']) : null;
    sat = json['Sat'] != null ? Mon.fromJson(json['Sat']) : null;
    sun = json['Sun'] != null ? Mon.fromJson(json['Sun']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (tue != null) {
      data['Tue'] = tue!.toJson();
    }
    if (wed != null) {
      data['Wed'] = wed!.toJson();
    }
    if (fri != null) {
      data['Fri'] = fri!.toJson();
    }
    if (thu != null) {
      data['Thu'] = thu!.toJson();
    }
    if (mon != null) {
      data['Mon'] = mon!.toJson();
    }
    if (sat != null) {
      data['Sat'] = sat!.toJson();
    }
    if (sun != null) {
      data['Sun'] = sun!.toJson();
    }
    return data;
  }
}

class Tue {
  int? count;
  num? totalPrice;
  String? currencySymbol;
  String? date;

  Tue({this.count, this.totalPrice, this.currencySymbol, this.date});

  Tue.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    totalPrice = json['totalPrice'];
    currencySymbol = json['currencySymbol'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    data['totalPrice'] = totalPrice;
    data['currencySymbol'] = currencySymbol;
    data['date'] = date;
    return data;
  }
}

class Mon {
  int? count;
  num? totalPrice;
  String? currencySymbol;
  String? date;

  Mon({this.count, this.totalPrice, this.currencySymbol, this.date});

  Mon.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    totalPrice = json['totalPrice'];
    currencySymbol = json['currencySymbol'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    data['totalPrice'] = totalPrice;
    data['currencySymbol'] = currencySymbol;
    data['date'] = date;
    return data;
  }
}
