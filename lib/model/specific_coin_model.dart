class SpecificCoinModel {
  int? status;
  String? message;
  List<Data>? data;

  SpecificCoinModel({this.status, this.message, this.data});

  SpecificCoinModel.fromJson(Map<String, dynamic> json) {
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
  String? date;
  double? open;
  double? high;
  double? low;
  double? close;
  double? volume;
  Quote? quote;
  String? sId;

  Data(
      {this.date,
      this.open,
      this.high,
      this.low,
      this.close,
      this.volume,
      this.quote,
      this.sId});

  Data.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    open = json['open'];
    high = json['high'];
    low = json['low'];
    close = json['close'];
    volume = json['volume'];
    quote = json['quote'] != null ? Quote.fromJson(json['quote']) : null;
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['open'] = open;
    data['high'] = high;
    data['low'] = low;
    data['close'] = close;
    data['volume'] = volume;
    if (quote != null) {
      data['quote'] = quote!.toJson();
    }
    data['_id'] = sId;
    return data;
  }
}

class Quote {
  double? price;
  double? volume24h;
  double? volumeChange24h;
  double? percentChange1h;
  double? percentChange24h;
  double? percentChange7d;
  double? percentChange30d;
  double? percentChange60d;
  double? percentChange90d;
  double? marketCap;
  double? marketCapDominance;
  double? fullyDilutedMarketCap;
  dynamic tvl;
  String? lastUpdated;

  Quote(
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
      this.tvl,
      this.lastUpdated});

  Quote.fromJson(Map<String, dynamic> json) {
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
    tvl = json['tvl'];
    lastUpdated = json['last_updated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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
    data['tvl'] = tvl;
    data['last_updated'] = lastUpdated;
    return data;
  }
}