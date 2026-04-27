// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'package:taxi_driver_24_7/model/coinmaket_model.dart';
import 'package:taxi_driver_24_7/model/getall_banners_model.dart';
import 'package:taxi_driver_24_7/model/specific_coin_model.dart';
import 'package:taxi_driver_24_7/model/weather_model.dart';
import 'package:taxi_driver_24_7/services/customer_apicall.dart';
import 'package:taxi_driver_24_7/widgets/common/snackbar.dart';
import 'package:flutter/material.dart';

class CoinMarketProvider extends ChangeNotifier {
  final CustomerApiCall apiProvider = CustomerApiCall();
  bool isloading = false;
  bool isloadingWeather = false;
  List<DataCoin>? coinData;
  List<Data>? specificCoindata;
  List<Weather>? dailyweather;
  Main? temperature;
  List<DataCoin>? get coinDataLista => coinData;
  List<Data>? get specificCoindataList => specificCoindata;
  List<BannerData>? homebanners;
  List<BannerData>? eventBanners;

  Future<void> getCoinMarkData(BuildContext context) async {
    isloading = true;
    notifyListeners();
    final response = await apiProvider.getcoinmarketdata(context);
    if (response.status == 1) {
      isloading = false;
      coinData = response.data;
      notifyListeners();
    } else {}
  }

  void sortData(List<DataCoin> coins) {
    List<String> desiredOrder = ["BTC", "ETH", "SOL", "TRUMP", "BTRUMP"];
    coins.sort((a, b) => desiredOrder
        .indexOf(a.symbol)
        .compareTo(desiredOrder.indexOf(b.symbol)));

    for (var coin in coins) {
      log('${coin.symbol}: ${coin.name}');
    }
  }

  Future<void> getWeather(double lat, double long) async {
    isloadingWeather = true;
    notifyListeners();
    final response = await apiProvider.getWaetherApi(lat, long);
    log('lat& lon -->> $lat $long');
    isloadingWeather = false;
    notifyListeners();
    dailyweather = response.weather;
    temperature = response.main;
  }

  Future<void> getAllBanners(BuildContext context,
      String userId, String startDate, String startTime) async {
    final response =
        await apiProvider.getAllBannerType(context, userId, startDate, startTime);
    if (response == null || response.status != 1) {
      // Keep existing banners on API failure; only clear on explicit empty success
      if (response != null) {
        homebanners = [];
        eventBanners = [];
        notifyListeners();
      }
      return;
    }
    final rawBanners = response.data ?? [];
    // Approved: backend may use bannerStatus 0 (approved) or 1 (active)
    final approvedBanners = rawBanners
        .where((banner) => banner.bannerStatus == 0 || banner.bannerStatus == 1)
        .toList();
    // Driver home: support "Main Home Page" and "Driver Home Page"
    homebanners = approvedBanners
        .where((banner) =>
            banner.type == 'Main Home Page' ||
            banner.type == 'Driver Home Page' ||
            (banner.type != null && banner.type!.toLowerCase().contains('home')))
        .toList();
    eventBanners = approvedBanners
        .where((banner) => banner.type == 'Event Home Page')
        .toList();
    notifyListeners();
  }

  Future<void> getSpecificCoins(
      BuildContext context, String symbol, String type) async {
    isloading = true;
    notifyListeners();
    final response = await apiProvider.getSpecificCoins(context,symbol, type);
    if (response.status == 1) {
      isloading = false;
      specificCoindata = response.data;
      notifyListeners();
    } else {
      isloading = false;
      specificCoindata = [];
      notifyListeners();
      CSnackBar.showSnackBar('No Data Found', context);
    }
  }
}
