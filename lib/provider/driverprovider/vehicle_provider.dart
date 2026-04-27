// ignore_for_file: use_build_context_synchronously

import 'package:taxi_driver_24_7/screen/driver/home/driver_home.dart';
 import 'package:taxi_driver_24_7/screen/driver/registerdocument/add_doc.dart';
import 'package:taxi_driver_24_7/screen/driver/registerdocument/newvehicleadddoc.dart';
import 'package:taxi_driver_24_7/screen/driver/registerdocument/vehicleinsurinfo.dart';
import 'package:taxi_driver_24_7/services/driver_apicall.dart';
import 'package:taxi_driver_24_7/utils/prefconstant.dart';
import 'package:taxi_driver_24_7/widgets/common/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VehicleProvider extends ChangeNotifier {
  final DriverApiCall _apiProvider = DriverApiCall();
  bool isloading = false;

  final TextEditingController vehiclemakeController = TextEditingController();
  final TextEditingController vehicleModelController = TextEditingController();
  final TextEditingController registrationNumberController =
      TextEditingController();
  final TextEditingController vehicleColorController = TextEditingController();

  void hideKeyBorad() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  void validation(
      BuildContext context,
      String driverid,
      vehicleId,
      vehiclename,
      String? vehicleYearValue,
      List<String> imageFiles,
      bool isNewVehicel) async {
    if (vehicleId == '' ||
        vehiclename == '' ||
        vehiclemakeController.text.isEmpty ||
        vehicleModelController.text.isEmpty ||
        vehicleYearValue == '' || vehicleYearValue==null||
        registrationNumberController.text.isEmpty ||
        vehicleColorController.text.isEmpty ||
        imageFiles.isEmpty) {
      CSnackBar.showSnackBarError("Please fill all the fields", context);
    } else {
      addVehicle(context, driverid, vehicleId, vehiclename, vehicleYearValue,
          imageFiles, isNewVehicel);
          vehiclemakeController.clear();
      vehicleModelController.clear();
      registrationNumberController.clear();
      vehicleColorController.clear();
    }
  }

   void newVehvalidation(
      BuildContext context,
      String driverid,
      vehicleId,
      vehiclename,
      String? vehicleYearValue,
      List<String> imageFiles,
      bool isNewVehicel) async {
    if (vehicleId == '' ||
        vehiclename == '' ||
        vehiclemakeController.text.isEmpty ||
        vehicleModelController.text.isEmpty ||
        vehicleYearValue == '' ||vehicleYearValue == null||
        registrationNumberController.text.isEmpty ||
        vehicleColorController.text.isEmpty ||
        imageFiles.isEmpty) {
      CSnackBar.showSnackBarError("Please fill all the fields", context);
    } else {
      addNewVehicle(context, driverid, vehicleId, vehiclename, vehicleYearValue,
          imageFiles, isNewVehicel);
          vehiclemakeController.clear();
      vehicleModelController.clear();
      registrationNumberController.clear();
      vehicleColorController.clear();
    }
  }
 Future<void> addNewVehicle(
      BuildContext context,
      String driverid,
      vehicleId,
      vehiclename,
      String? vehicleYearValue,
      List<String> imageFiles,
      bool isNewVehicel) async {
    isloading = true;
    notifyListeners();
    final response = await _apiProvider.addVehicle(
        context,
        driverid,
        vehicleId,
        vehiclename,
        vehiclemakeController.text,
        vehicleModelController.text,
        vehicleYearValue,
        registrationNumberController.text,
        vehicleColorController.text,
        imageFiles);

    isloading = false;
    notifyListeners();

    if (response.status == 1) {
      CSnackBar.showSnackBar(response.message.toString(), context);
     Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) =>   NewVehicleAddDoc(vehicleid: response.data!.vehicleId,vehicleInsuranceStatus: 0,registrationCertificateStatus: 0,)));
    } else if (response.status == 0) {
      CSnackBar.showSnackBarError(response.message.toString(), context);
        Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => const DriverHome()));
    } else {
      CSnackBar.showSnackBarError(response.message.toString(), context);
        Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => const DriverHome()));
    }
  }
  
  @override
  void dispose() {
    super.dispose();
    vehiclemakeController.dispose();
    vehicleModelController.dispose();
    registrationNumberController.dispose();
    vehicleColorController.dispose();
  }

  Future<void> addVehicle(
      BuildContext context,
      String driverid,
      vehicleId,
      vehiclename,
      String? vehicleYearValue,
      List<String> imageFiles,
      bool isNewVehicel) async {
    isloading = true;
    notifyListeners();
    final response = await _apiProvider.addVehicle(
        context,
        driverid,
        vehicleId,
        vehiclename,
        vehiclemakeController.text,
        vehicleModelController.text,
        vehicleYearValue,
        registrationNumberController.text,
        vehicleColorController.text,
        imageFiles);

    isloading = false;
    notifyListeners();

    if (response.status == 1) {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      prefs.setString(PrefConstant.vehicleId, response.data!.sId!);

      prefs.setString(PrefConstant.vehicleDetailStatus, '1'.toString());

      prefs.setString(PrefConstant.profilePhotoStatus, '0'.toString());

      prefs.setString(PrefConstant.drivingLicenceFrontStatus, '0'.toString());

      prefs.setString(PrefConstant.vehicleInsuranceStatus, '0'.toString());

 

      prefs.setString(
          PrefConstant.registrationCertificateStatus, '0'.toString());

      CSnackBar.showSnackBar(response.message.toString(), context);
      isNewVehicel
          ? Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => VehicleInsurInfo(
                        isNewVehicel: isNewVehicel,
                      )))
          : Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => const AddDoc()));
    } else if (response.status == 0) {
      CSnackBar.showSnackBarError(response.message.toString(), context);
    } else {
      CSnackBar.showSnackBarError(response.message.toString(), context);
    }
  }
}
