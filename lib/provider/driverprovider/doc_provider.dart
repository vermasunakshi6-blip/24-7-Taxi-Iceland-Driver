// ignore_for_file: use_build_context_synchronously

import 'package:taxi_driver_24_7/model/get_document_status.dart';
import 'package:taxi_driver_24_7/screen/driver/home/driver_home.dart';
import 'package:taxi_driver_24_7/screen/driver/registerdocument/newvehiclercinfo.dart';
import 'package:taxi_driver_24_7/screen/driver/registerdocument/rcinfo.dart';
import 'package:taxi_driver_24_7/screen/driver/registerdocument/thanksscreen.dart';
import 'package:taxi_driver_24_7/services/driver_apicall.dart';
import 'package:taxi_driver_24_7/utils/prefconstant.dart';
import 'package:taxi_driver_24_7/widgets/common/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DocProvider extends ChangeNotifier {
  final DriverApiCall _apiProvider = DriverApiCall();
  bool isloading = false;
  Data? docData;

  Future<void> getDocStatus(BuildContext context,String driverId, String vehicledetailId) async {
    isloading = true;
    notifyListeners();
    final response = await _apiProvider.getDocStatus(context,driverId, vehicledetailId);
       isloading = false;
      notifyListeners();
    if (response.status == 1) {
      docData = response.data;
   
    } else {
      
      throw Exception('Failed to load data');
    }
  }

// Add Profile Photo

  Future<void> addProfilePhoto(BuildContext context, String driverid,
      List<String>? path, String vehicledetailId) async {
    isloading = true;
    notifyListeners();
    final response = await _apiProvider.addProfilePhoto(
        context, driverid, path!, vehicledetailId);

    isloading = false;
    notifyListeners();

    if (response.status == 1) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
         prefs.setString(PrefConstant.profilePhotoStatus, '1'.toString());
      CSnackBar.showSnackBar(response.message.toString(), context);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DocumentThanksScreen(type: 'profile')));
    } else if (response.status == 0) {
      CSnackBar.showSnackBarError(response.message.toString(), context);
    } else {
      CSnackBar.showSnackBarError(response.message.toString(), context);
    }
  }

  // Add Driving Photo

  Future<void> addDrivingPhoto(BuildContext context, String driverid,
      List<String>? path, List<String>? path1, String vehicledetailId) async {
    isloading = true;
    notifyListeners();
    final response = await _apiProvider.addDrivingPhoto(
        context, driverid, path!, path1!, vehicledetailId);

    isloading = false;
    notifyListeners();

    if (response.status == 1) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
         prefs.setString(PrefConstant.drivingLicenceFrontStatus, '1'.toString());
      CSnackBar.showSnackBar(response.message.toString(), context);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DocumentThanksScreen(type: 'lic')));
    } else if (response.status == 0) {
      CSnackBar.showSnackBarError(response.message.toString(), context);
    } else {
      CSnackBar.showSnackBarError(response.message.toString(), context);
    }
  }

  // Add Vehicle Insu Photo

  Future<void> addVehicleInsPhoto(BuildContext context, String driverid,
      List<String>? path, bool isNewVehicel, String vehicledetailid) async {
    isloading = true;
    notifyListeners();
    final response = await _apiProvider.addVehicleInsPhoto(
        context, driverid, path!, vehicledetailid);

    isloading = false;
    notifyListeners();

    if (response.status == 1) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
         prefs.setString(PrefConstant.vehicleInsuranceStatus, '1'.toString());
      CSnackBar.showSnackBar(response.message.toString(), context);
      isNewVehicel
          ? Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => RCInfo(
                        isNewVehicel: isNewVehicel,
                      )))
          : Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DocumentThanksScreen(
                        type: 'ins',
                      )));
    } else if (response.status == 0) {
      CSnackBar.showSnackBarError(response.message.toString(), context);
    } else {
      CSnackBar.showSnackBarError(response.message.toString(), context);
    }
  }



  Future<void> newaddVehicleInsPhoto(BuildContext context, String driverid,
      List<String>? path, String vehicledetailid) async {
    isloading = true;
    notifyListeners();
    final response = await _apiProvider.addVehicleInsPhoto(
        context, driverid, path!, vehicledetailid);

    isloading = false;
    notifyListeners();

    if (response.status == 1) {
     
     
      CSnackBar.showSnackBar(response.message.toString(), context);


        Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => NewVehicleRCInfo(
                        vehicleid: vehicledetailid,
                      )));
    } else if (response.status == 0) {
      CSnackBar.showSnackBarError(response.message.toString(), context);
    } else {
      CSnackBar.showSnackBarError(response.message.toString(), context);
    }
  }


  // Add RC Photo

  Future<void> addRCPhoto(BuildContext context, String driverid,
      List<String>? path, bool isNewVehicel, String vehicledetailid) async {
    isloading = true;
    notifyListeners();
    final response = await _apiProvider.addRCPhoto(
        context, driverid, path!, vehicledetailid);

    isloading = false;
    notifyListeners();
  SharedPreferences prefs = await SharedPreferences.getInstance();
         prefs.setString(PrefConstant.registrationCertificateStatus, '1'.toString());
    if (response.status == 1) {
      CSnackBar.showSnackBar(response.message.toString(), context);
      isNewVehicel
          ? Navigator.push(context,
              MaterialPageRoute(builder: (context) => const DriverHome()))
          : Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DocumentThanksScreen(
                        type: 'rc',
                      )));
    } else if (response.status == 0) {
      CSnackBar.showSnackBarError(response.message.toString(), context);
    } else {
      CSnackBar.showSnackBarError(response.message.toString(), context);
    }
  }


    Future<void> newVehiaddRCPhoto(BuildContext context, String driverid,
      List<String>? path,  String vehicledetailid) async {
    isloading = true;
    notifyListeners();
    final response = await _apiProvider.addRCPhoto(
        context, driverid, path!, vehicledetailid);

    isloading = false;
    notifyListeners();
  SharedPreferences prefs = await SharedPreferences.getInstance();
         prefs.setString(PrefConstant.registrationCertificateStatus, '1'.toString());
    if (response.status == 1) {
      CSnackBar.showSnackBar(response.message.toString(), context);
      Navigator.push(context,
              MaterialPageRoute(builder: (context) => const DriverHome()));
    } else if (response.status == 0) {
      CSnackBar.showSnackBarError(response.message.toString(), context);
    } else {
      CSnackBar.showSnackBarError(response.message.toString(), context);
    }
  }
}
