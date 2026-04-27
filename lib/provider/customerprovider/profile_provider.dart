// ignore_for_file: use_build_context_synchronously

import 'dart:typed_data';

import 'package:taxi_driver_24_7/model/customer_profile_model.dart';
import 'package:taxi_driver_24_7/screen/authscreen/splash_screen.dart';
 import 'package:taxi_driver_24_7/screen/shared/account_screens/profile.dart';
import 'package:taxi_driver_24_7/utils/prefconstant.dart';
import 'package:taxi_driver_24_7/widgets/common/progress_dialog.dart';
import 'package:taxi_driver_24_7/widgets/common/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../services/customer_apicall.dart';

class ProfileProvider extends ChangeNotifier {
  final CustomerApiCall apiProvider = CustomerApiCall();
  bool isloading = false;
  String? otpValue;
  List<Uint8List> imageDataList = [];
  Data? profileDetails;
  bool isVerfify = false;

  Data? get profileDetailss => profileDetails;

  void setOtpValue(String newValue) {
    otpValue = newValue;
    notifyListeners();
  }

  void setValue(bool newValue) {
    isVerfify = newValue;
    notifyListeners();
  }

  Future<void> getProfile(String? userId, BuildContext context) async {
    isloading = true;
    notifyListeners();
    final response = await apiProvider.getCustomerProfile(context,userId!);
    isloading = false;
    notifyListeners();
    if (response.status == 1) {
      profileDetails = response.data;
       SharedPreferences? prefs = await SharedPreferences.getInstance();
      prefs.setString(PrefConstant.userName, response.data!.firstName!+response.data!.lastName!);
      prefs.setString(PrefConstant.userNumber, response.data!.phone!);
         prefs.setString(PrefConstant.backgroundverification,
          response.data!.vehicleDetailStatus.toString());
    } else {
      CSnackBar.showSnackBarError(response.message.toString(), context);
    }
  }

  Future<void> editProfile(String? userId, String fname, String lname,
      BuildContext context, List<String> path) async {
        ProgressDialog.show(context);
    notifyListeners();

    final response =
        await apiProvider.editProfile(userId!, fname, lname, context, path);

    notifyListeners();
    if (response.status == 1) {
       ProgressDialog.hide(context);
      CSnackBar.showSnackBar(response.message.toString(), context);
      imageDataList.clear();
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const Profile()));
    } else {
       ProgressDialog.hide(context);
      CSnackBar.showSnackBarError(response.message.toString(), context);
    }
  }


   Future<void> editProfileWithoutImage(String? userId, String fname, String lname,
      BuildContext context,) async {
        ProgressDialog.show(context);
    notifyListeners();

    final response =
        await apiProvider.editProfileWithoutImage(userId!, fname, lname, context);

    notifyListeners();
    if (response.status == 1) {
       ProgressDialog.hide(context);
      CSnackBar.showSnackBar(response.message.toString(), context);
      imageDataList.clear();
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const Profile()));
    } else {
       ProgressDialog.hide(context);
      CSnackBar.showSnackBarError(response.message.toString(), context);
    }
  }

  Future<void> resetEmail(String oldEmail, String newEmail, String otp,
      BuildContext context) async {
    final res = await apiProvider.resetEmailId(context,oldEmail, newEmail, otp);
    if (res.status == 1) {
    
      if (res.message.toString().contains("Email updated successfully!")) {
        CSnackBar.showSnackBar(res.message.toString(), context);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const Profile()));
      }
      else {
          CSnackBar.showSnackBar(res.message.toString(), context);
      }
    }
    else {
        CSnackBar.showSnackBar('Invalid OTP! Resend Again', context);
    }
  }
    Future<void> deleteAccount(
    String userid,
    String reason,
    BuildContext context,
  ) async {
    ProgressDialog.show(context);
    final res = await apiProvider.deleteAccount(context,userid, reason);
    if (res.status == 1) {
      ProgressDialog.hide(context);
      CSnackBar.showSnackBar(res.message.toString(), context);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.clear();
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const SplashScreen()));
    } else {
      ProgressDialog.hide(context);
      CSnackBar.showSnackBarError(res.message.toString(), context);
    }
  }


}
