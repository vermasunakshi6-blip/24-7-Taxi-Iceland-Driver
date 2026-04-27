class CryptoRatesModel {
  Status? status;
  List<CryptoData>? data;

  CryptoRatesModel({this.status, this.data});

  CryptoRatesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'] != null ? Status.fromJson(json['status']) : null;
    if (json['data'] != null) {
      data = <CryptoData>[];
      json['data'].forEach((v) {
        data!.add(CryptoData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (status != null) {
      data['status'] = status!.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Status {
  Null errorMessage;

  Status({this.errorMessage});

  Status.fromJson(Map<String, dynamic> json) {
    errorMessage = json['error_message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['error_message'] = errorMessage;
    return data;
  }
}

class CryptoData {
  int? id;
  String? name;
  String? symbol;
  Quote? quote;

  CryptoData({this.id, this.name, this.symbol, this.quote});

  CryptoData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    symbol = json['symbol'];
    quote = json['quote'] != null ? Quote.fromJson(json['quote']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['symbol'] = symbol;
    if (quote != null) {
      data['quote'] = quote!.toJson();
    }
    return data;
  }
}

class Quote {
  USD? uSD;

  Quote({this.uSD});

  Quote.fromJson(Map<String, dynamic> json) {
    uSD = json['USD'] != null ? USD.fromJson(json['USD']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (uSD != null) {
      data['USD'] = uSD!.toJson();
    }
    return data;
  }
}

class USD {
  double? price;

  USD({this.price});

  USD.fromJson(Map<String, dynamic> json) {
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['price'] = price;
    return data;
  }
}
