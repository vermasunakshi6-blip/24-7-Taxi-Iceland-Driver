// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:taxi_driver_24_7/model/all_rewards_model.dart';
import 'package:taxi_driver_24_7/model/coinmaket_model.dart';
import 'package:taxi_driver_24_7/model/get_total_rewards_model.dart';
import 'package:taxi_driver_24_7/services/customer_apicall.dart';
import 'package:taxi_driver_24_7/widgets/common/progress_dialog.dart';
import 'package:taxi_driver_24_7/widgets/common/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taxi_driver_24_7/model/watch_to_earn_model.dart';

class WatchtoEarnprovider extends ChangeNotifier {
  String isLiked = '';
  SharedPreferences? prefs;
  String? userId;
  List<Data> watchToEarnData = [];
  List<Data> watchToEarnShortsData = [];
  List<Data> watchToEarnDetailData = [];
  List<Data> watchToEarnShortsDetailData = [];
  List<Data> filteredData = [];
  List<Data> filterdShorts = [];
  List<RewardsData> allRewardsList = [];
  List<RewardsData> filteredRewards = [];
  String selectedcategory = 'All';
  String? selectedValue;
  List<DataCoin>? cryptocurrency;
  bool isfilterApplied = false;
  TotalData? totalRewards;

  bool isloading = false;

  void selectCategory(dynamic category) {
    if (selectedcategory != category) {
      selectedcategory = category;
      filterVideos(selectedcategory);
      notifyListeners();
    } else {
      selectedcategory;
    }
  }

  Future<void> getAllWatchtoEarn(
    BuildContext context,
    String userId,
  ) async {
    isloading = true;
    notifyListeners();
    final response = await CustomerApiCall().getAllWatchtoEarn(context,
      userId,
    );
    isloading=false;
    notifyListeners();
    if (response.status == 1) {
      watchToEarnData = response.data!
          .where((data) =>
              (data.contentType!.toLowerCase() == 'video'.toLowerCase() &&
                  data.isViewed == '0'))
          .toList();
          watchToEarnShortsData = response.data!.where((data)=>(data.contentType!.toLowerCase()=='short'.toLowerCase()&&data.isViewed=='0')).toList();
      notifyListeners();
    } else {
      isloading=false;
      watchToEarnData= [];
      watchToEarnShortsData= [];
      notifyListeners();
      CSnackBar.showSnackBarError('Something Went Wrong!No data Available.'.toString(), context);
    }
  }

  Future<void> likeWatchtoEarn(
      BuildContext context, String userId, String watchId, String isLike) async {
    ProgressDialog.show(context);
    notifyListeners();
    final likeresponse =
        await CustomerApiCall().likeWatchtoEarn(context,userId, watchId, isLike);
    ProgressDialog.hide(context);
    notifyListeners();
    if (likeresponse.status == 1) {
      isLiked = likeresponse.data!.isLike.toString();
      notifyListeners();
    } else {
      isLiked= '0';
      notifyListeners();
    }
  }

  Future<void> viewWatchtoEarn(
      BuildContext context, String userId, String watchId) async {
    ProgressDialog.show(context);
    notifyListeners();
    await CustomerApiCall().viewWatchtoEarn(context,userId, watchId);
    ProgressDialog.hide(context);
    notifyListeners();
  }

  Future<void> getWatchtoEarnDetail(
      BuildContext context, String userId, String watchId) async {
    isloading=true;
    notifyListeners();
    final response =
        await CustomerApiCall().getWatchtoEarnDetail(context,userId, watchId);
    isloading=false;
    notifyListeners();
    if (response.status == 1) {
      watchToEarnDetailData =
          response.data!.where((data) => (data.status == 0)).toList();
      notifyListeners();
    } else {
      isloading=false;
      notifyListeners();
      CSnackBar.showSnackBarError(response.message.toString(), context);
    }
  }

  void filterVideos(String input) {
    filteredData.clear();
    isfilterApplied = true;
    notifyListeners();
    if (input.toLowerCase() == 'all') {
      isfilterApplied = false;
    } else {
      filteredData = watchToEarnData
          .where((type) =>
              type.category!.toLowerCase().contains(input.toLowerCase()))
          .toList();
          filterdShorts = watchToEarnShortsData
          .where((type) =>
              type.category!.toLowerCase().contains(input.toLowerCase()))
          .toList();
      log('filtered data -->>' + filteredData.toString());
    }
    notifyListeners();
  }

  Future<void> getRecentRewards(
    BuildContext context,
    String userId,
  ) async {
    isloading=true;
    notifyListeners();
    final response = await CustomerApiCall().getRecentRewards(context,
      userId,
    );
    isloading=false;
    notifyListeners();
    if (response.status == 1) {
      allRewardsList = response.data!.toList();
      notifyListeners();
    } else {
      isloading=false;
      notifyListeners();
      CSnackBar.showSnackBarError(response.errors!.views.toString(), context);
    }
  }

  void filterRewards() {
    filteredRewards.clear();
    isfilterApplied = true;
    notifyListeners();
    filteredRewards = allRewardsList
        .where((reward) =>
            reward.watchDetails!.reward!.first.currency!.toLowerCase() ==
            selectedValue!.toLowerCase())
        .toList();
    notifyListeners();
  }

  Future<void> getCoinMarkData( BuildContext context) async {
    isloading= true;
    notifyListeners();
    final response = await CustomerApiCall().getcoinmarketdata(context);
    if (response.status == 1) {
      isloading= false;
    notifyListeners();
      cryptocurrency = response.data;
      selectedValue = response.data!.first.symbol;
      notifyListeners();
    } else {
      isloading= false;
    notifyListeners();
    }
  }

  void setSelectedCoin(String newValue) {
    selectedValue = newValue;
    notifyListeners();
  }

  Future<void> getTotalRewards(
    BuildContext context,
    String userId,
  ) async {
    isloading = true;
    notifyListeners();
    final response =
        await CustomerApiCall().getTotalRewards(context,userId, selectedValue!);
    isloading = false;

    notifyListeners();
    if (response.status == 1) {
      totalRewards = response.data!;
      notifyListeners();
    } else {
      CSnackBar.showSnackBarError(response.errors!.views.toString(), context);
    }
  }
}
