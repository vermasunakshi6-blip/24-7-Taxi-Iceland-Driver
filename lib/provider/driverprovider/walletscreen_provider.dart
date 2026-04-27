import 'package:taxi_driver_24_7/model/driverridehistory_model.dart';
import 'package:taxi_driver_24_7/model/weaklygraph_model.dart';
import 'package:taxi_driver_24_7/services/driver_apicall.dart';
import 'package:taxi_driver_24_7/widgets/common/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WalletScreenProvider extends ChangeNotifier {
  final DriverApiCall apiCall = DriverApiCall();
  bool isloading = false;
  List<RideHistory> rideHistoryData = [];
  WeekData? weekData;
  String? totalWeeklyPrice;
  String selectedItem = 'BTC';
  List cryptocurrency = ['BTC', 'ETH', 'SOLANA', 'USDT', 'BNB', 'MATIC'];
  String? currencySymbol;
  double? totalPrice;
  String? formattedPrice;
  String? formattedweekPrice;
  DateTime todayDate = DateTime.now().add(const Duration(days: 3));
  DateTime weekDate = DateTime.now().subtract(const Duration(days: 3));
  DateFormat formatter = DateFormat('MMMM d');
  DateFormat formatterForApi = DateFormat('yyyy-MM-dd');
  String? weakDate;
  String? todaydate;
  String? startDate;
  String? endDate;

  void main(BuildContext context,String driverId) {
    getWalletBalance(context,driverId);
    getWalletGraph(context,driverId);
    getRideHistory(context,driverId);
  }

  Future<void> getWalletBalance(BuildContext context,
    String driverId,
  ) async {
    isloading = true;
    notifyListeners();
    final res = await apiCall.getWalletBalance(context,driverId, selectedItem);
    isloading = false;
    notifyListeners();
    if (res.status == 1) {
      currencySymbol = res.currencySymbol!;
      totalPrice = double.parse(res.totalPrice.toString());
      formattedPrice = totalPrice!.toStringAsFixed(6);
    } else {
      // ignore: use_build_context_synchronously
      CSnackBar.showSnackBar(res.message!, context);
    }
  }

  Future<void> getWalletGraph(BuildContext context,String driverId) async {
    isloading = true;
    notifyListeners();
    final res = await apiCall.getWalletGraph(context,
        driverId, selectedItem, startDate!, endDate!);
    isloading = false;
    notifyListeners();
    if (res.status == 1) {
      notifyListeners();
      weekData = res.weekData;
      totalWeeklyPrice = res.totalWeeklyPrice!.toStringAsFixed(4);
      notifyListeners();
    }
  }

  Future<void> getRideHistory(BuildContext context,String driverId) async {
    isloading = true;
    notifyListeners();
    final res = await apiCall.getRideHistory(context,
        driverId, selectedItem, startDate!, endDate!,0);
    isloading = false;
    notifyListeners();
    if (res.status == 1) {
      rideHistoryData = res.rideHistory!;
    }
  }
}
