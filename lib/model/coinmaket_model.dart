class CoinMarketModel {
  int? status;
  String? message;
  List<DataCoin>? data;

  CoinMarketModel({this.status, this.message, this.data});

  CoinMarketModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <DataCoin>[];
      json['data'].forEach((v) {
        data!.add(DataCoin.fromJson(v));
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

class DataCoin {
 dynamic sId;
  dynamic id;
dynamic name;
 dynamic symbol;
 dynamic slug;
  QuoteCoin? quote;
 dynamic status;
  dynamic createdAt;
  dynamic updatedAt;
dynamic iV;

  DataCoin(
      {this.sId,
      this.id,
      this.name,
      this.symbol,
      this.slug,
      this.quote,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.iV});

  DataCoin.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    id = json['id'];
    name = json['name'];
    symbol = json['symbol'];
    slug = json['slug'];
    quote = json['quote'] != null ?  QuoteCoin.fromJson(json['quote']) : null;
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['_id'] = sId;
    data['id'] = id;
    data['name'] = name;
    data['symbol'] = symbol;
    data['slug'] = slug;
    if (quote != null) {
      data['quote'] = quote!.toJson();
    }
    data['status'] = status;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class QuoteCoin {
  USDCoin? uSD;

  QuoteCoin({this.uSD});

  QuoteCoin.fromJson(Map<String, dynamic> json) {
    uSD = json['USD'] != null ?  USDCoin.fromJson(json['USD']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    if (uSD != null) {
      data['USD'] = uSD!.toJson();
    }
    return data;
  }
}

class USDCoin {
  dynamic price;
  dynamic volume24h;
  dynamic volumeChange24h;
  dynamic percentChange1h;
  dynamic percentChange24h;
  dynamic percentChange7d;
  dynamic percentChange30d;
  dynamic percentChange60d;
  dynamic percentChange90d;
  dynamic marketCap;
  dynamic marketCapDominance;
  dynamic fullyDilutedMarketCap;
 
  String? lastUpdated;

  USDCoin(
      {this.price,
      this.volume24h,
      this.volumeChange24h,
      this.percentChange1h,
      this.percentChange24h,
      this.percentChange7d,
      this.percentChange30d,
      this.percentChange60d,
      this.percentChange90d,
      this.marketCap,
      this.marketCapDominance,
      this.fullyDilutedMarketCap,
      
      this.lastUpdated});

  USDCoin.fromJson(Map<String, dynamic> json) {
    price = json['price'];
    volume24h = json['volume_24h'];
    volumeChange24h = json['volume_change_24h'];
    percentChange1h = json['percent_change_1h'];
    percentChange24h = json['percent_change_24h'];
    percentChange7d = json['percent_change_7d'];
    percentChange30d = json['percent_change_30d'];
    percentChange60d = json['percent_change_60d'];
    percentChange90d = json['percent_change_90d'];
    marketCap = json['market_cap'];
    marketCapDominance = json['market_cap_dominance'];
    fullyDilutedMarketCap = json['fully_diluted_market_cap'];
   
    lastUpdated = json['last_updated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['price'] = price;
    data['volume_24h'] = volume24h;
    data['volume_change_24h'] = volumeChange24h;
    data['percent_change_1h'] = percentChange1h;
    data['percent_change_24h'] = percentChange24h;
    data['percent_change_7d'] = percentChange7d;
    data['percent_change_30d'] = percentChange30d;
    data['percent_change_60d'] = percentChange60d;
    data['percent_change_90d'] = percentChange90d;
    data['market_cap'] = marketCap;
    data['market_cap_dominance'] = marketCapDominance;
    data['fully_diluted_market_cap'] = fullyDilutedMarketCap;
    
    data['last_updated'] = lastUpdated;
    return data;
  }
}