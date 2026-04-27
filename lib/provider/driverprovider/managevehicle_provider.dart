// ignore_for_file: use_build_context_synchronously

import 'dart:typed_data';

import 'package:taxi_driver_24_7/model/getvehiclelis_model.dart';
import 'package:taxi_driver_24_7/services/driver_apicall.dart';
import 'package:taxi_driver_24_7/widgets/common/snackbar.dart';
import 'package:flutter/material.dart';

class ManageVehicleProvider extends ChangeNotifier {
  List<Uint8List> imageDataList = [];
  final DriverApiCall apiCall = DriverApiCall();
  bool isloading = false;
  List<Data>? getvehicleDetailData;
  Future<void> getVehicleListData(String driverId, BuildContext context) async {
    isloading = true;
    notifyListeners();
    final res = await apiCall.getVehicleListApi(context,driverId);
    isloading = false;
    notifyListeners();
    if (res.status == 1) {
      getvehicleDetailData = res.data!;
    } else {
      CSnackBar.showSnackBarError(res.message.toString(), context);
    }
  }

  Future<void> setDefaultVehicle(
      String driverId, String vehicleId, BuildContext context) async {
    isloading = true;
    notifyListeners();
    final res = await apiCall.setDefaultVehicle(context,driverId, vehicleId);
    isloading = false;
    notifyListeners();
    if (res.status == 1) {
      getVehicleListData(driverId, context);
      CSnackBar.showSnackBar(res.message.toString(), context);
      Navigator.pop(context);
    } else {
      CSnackBar.showSnackBarError(res.message.toString(), context);
    }
  }

  Future<void> deleteVehicle(
      String driverId, String vehicleId, BuildContext context) async {
    isloading = true;
    notifyListeners();
    final res = await apiCall.deleteVehicle(context,driverId, vehicleId);
    isloading = false;
    notifyListeners();
    if (res.status == 1) {
      getVehicleListData(driverId, context);
      CSnackBar.showSnackBar(res.message.toString(), context);
      Navigator.pop(context);
    } else {
      CSnackBar.showSnackBarError(res.message.toString(), context);
    }
  }
}
