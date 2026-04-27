import 'package:taxi_driver_24_7/model/getvehicleinfo_model.dart';
import 'package:taxi_driver_24_7/services/driver_apicall.dart';
import 'package:taxi_driver_24_7/widgets/common/snackbar.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';
 
class GetVehicleInfoProvider extends ChangeNotifier {
  final DriverApiCall apiCall = DriverApiCall();
  bool isloading = false;
  List<Uint8List> imageDataList = [];
  List<Data> getVehicleData = [];

  List<Uint8List> get imageDataLista => imageDataList;

  Future<void> getVehicleInfo(
      String driverId, String vehicleId, BuildContext context) async {
    isloading = true;
    notifyListeners();
    final res = await apiCall.getVehicleInfo(context,driverId, vehicleId);
    isloading = false;
    notifyListeners();
    if (res.status == 1) {
      getVehicleData = res.data!;
    } else {
      // ignore: use_build_context_synchronously
      CSnackBar.showSnackBarError(res.message.toString(), context);
    }
  }
}
