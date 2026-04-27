 
import 'package:taxi_driver_24_7/model/vehicle_type_model.dart';
import 'package:taxi_driver_24_7/services/driver_apicall.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class VehicleTypeProvider extends ChangeNotifier {
  final DriverApiCall _apiProvider = DriverApiCall();
  bool isloading = false;

  List<Data>? vichleData;
  List<Data>? get vichleList => vichleData;

  List<VehicleTypes>? vehicletypeData;
  List<VehicleTypes>? get vehicleTypeList => vehicletypeData;

  void hideKeyBorad() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  Future<void> getVehicleData(BuildContext context,String userId) async {
    isloading = true;
    notifyListeners();

      final response = await _apiProvider.getvehicleType(context,userId);

    if (response.status == 1) {
      vichleData = response.data;
      isloading = false;
      notifyListeners();
    } else {
      throw Exception('Failed to load data');
    }
 }

 Future<void> getVehicleTypeData(BuildContext context,String userId) async {
    isloading = true;
    notifyListeners();
      final response = await _apiProvider.getvehicleTypeData(context,userId);
    if (response.status == 1) {
      vehicletypeData = response.vehicleTypes;
      isloading = false;
      notifyListeners();
    } else {
      throw Exception('Failed to load data');
    }
 }
}

