// ignore_for_file: use_build_context_synchronously
 
import 'dart:developer';
import 'package:taxi_driver_24_7/screen/authscreen/contact_sync.dart';
import 'package:taxi_driver_24_7/screen/authscreen/otpscreen.dart';
import 'package:taxi_driver_24_7/screen/authscreen/splash_screen.dart';
import 'package:taxi_driver_24_7/screen/driver/home/driver_home_new.dart';
import 'package:taxi_driver_24_7/services/auth_apicall.dart';
import 'package:taxi_driver_24_7/utils/prefconstant.dart';
import 'package:taxi_driver_24_7/widgets/common/progress_dialog.dart';
import 'package:taxi_driver_24_7/widgets/common/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
 
class LoginProvider extends ChangeNotifier {
  bool? otpFieldVisibility;
  bool isLoading = false;
  final AuthApiCall _apiCall = AuthApiCall();
  final TextEditingController phoneNumberc = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  String? countryCode = '';
  String phoneNumberWithCode = '';
  String phoneNumber = '';
  String? receivedID;
  bool isFieldNotEmpty = false;
  int toadyattempts=0;
  String userTypes = "";
  int? _resendToken;
  void listener() {
    phoneNumberc.addListener(() {
      isFieldNotEmpty = phoneNumberc.text.isNotEmpty;
    });
  }
 
  void setCountryCode(String code) {
    countryCode = code;
    notifyListeners();
  }
 
  void validation(
    BuildContext context,
    String userType,  
  ) {
    userTypes = userType;
    if ((countryCode ?? '').isEmpty || phoneNumberc.text.isEmpty) {
      CSnackBar.showSnackBarError('Please enter mobile number first!', context);
    } else {
       getotpValidation(context, phoneNumberc.text, countryCode ?? '');
       

     
    }
  }
 
  Future<void> resendvalidation(BuildContext context, String phoneNumberc,
      String countryCode, String userType) async {
    if (countryCode.isEmpty || phoneNumberc.isEmpty) {
      CSnackBar.showSnackBarError('Please enter mobile number first!', context);
    } else {
        
       

           getotpValidation(context, phoneNumberc, countryCode);
    }
  }
 
  Future<void> firebaseAuthForVerifyPhoneNumber(BuildContext context,
      String phoneNumber, String countryCode, String s) async {
    ProgressDialog.show(context);
    phoneNumberWithCode = '$countryCode $phoneNumber';
 
    phoneNumber = phoneNumber;
 
    auth.verifyPhoneNumber(
        phoneNumber: phoneNumberWithCode,
        verificationCompleted: (PhoneAuthCredential credential) async {
          ProgressDialog.hide(context);
          await auth.signInWithCredential(credential).then((value) =>
              CSnackBar.showSnackBar("Logged In Successfully", context));
        },
        verificationFailed: (FirebaseAuthException e) {
          ProgressDialog.hide(context);
          _handleAuthError(e, context);
          log('my auth exception============>>>>>>>>>>>$e');
          log('my auth exception============>>>>>>>>>>>${e.code}');
        },
        codeSent: (String verificationId, int? resendToken) {
          log('codesent-->$resendToken');
         
          _resendToken = resendToken;
          ProgressDialog.hide(context);
          CSnackBar.showSnackBar('OTP Sent Successfully', context);
          receivedID = verificationId;
          otpFieldVisibility = true;
          if (s == 'login') {
           
             sendotpcount(context, phoneNumber, countryCode,verificationId);
          
          } else {}
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          log('timeout-->');
          // Do not pop routes on timeout; user may already be on OTP/Home screen.
          // Just keep the latest verificationId so they can retry verification safely.
          receivedID = verificationId;
          log('timeout-->updated verificationId');
          notifyListeners();
        },
        forceResendingToken: _resendToken);
  }
 
  Future<void> firebaseAuthForVerifyOtpCode(
      BuildContext context, String otp, String? token) async {
    if (receivedID == null || receivedID!.isEmpty) {
      CSnackBar.showSnackBarError(
        'Verification session expired. Please request a new OTP.',
        context,
      );
      return;
    }
    ProgressDialog.show(context);
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: receivedID!,
        smsCode: otp,
      );
      await auth.signInWithCredential(credential).then((value) {
        ProgressDialog.hide(context);
        login(context, phoneNumberc.text, userTypes, token ?? '', countryCode ?? '');
      });
    } on FirebaseAuthException catch (e) {
      ProgressDialog.hide(context);
      _handleAuthError(e, context);
    }
  }
 
  Future<void> logout(BuildContext context, userId, deviceToken) async {
    ProgressDialog.show(context);
    isLoading = true;
    notifyListeners();
    final response = await _apiCall.logout(context, userId, deviceToken);
    isLoading = false;
    notifyListeners();
    if (response.status == 1) {
      ProgressDialog.hide(context);
      CSnackBar.showSnackBar(response.message.toString(), context);
      Navigator.of(context).pop();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.clear();
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const SplashScreen()));
    } else {
      ProgressDialog.hide(context);
      CSnackBar.showSnackBarError(response.message.toString(), context);
    }
  }
 
  Future<void> login(
      BuildContext context, phone, regType, deviceToken, countryCode) async {
    ProgressDialog.show(context);
    isLoading = true;
    notifyListeners();
    final response =
        await _apiCall.login(context, phone, regType, deviceToken, countryCode);
    isLoading = false;
    notifyListeners();
    if (response.status == 1 && response.data != null) {
      ProgressDialog.hide(context);
      phoneNumberc.clear();
      CSnackBar.showSnackBar(response.message.toString(), context);
      SharedPreferences? prefs = await SharedPreferences.getInstance();
      final data = response.data!;
      prefs.setString(PrefConstant.userid, data.sId ?? '');
      prefs.setString(PrefConstant.userType, data.regType ?? '');
      prefs.setString(PrefConstant.currentType, data.currentType ?? '');
      prefs.setString(PrefConstant.vehicleDetailStatus,
          data.vehicleDetailStatus.toString());
      prefs.setString(
          PrefConstant.firstName, data.firstName.toString());
 
      prefs.setString(PrefConstant.profilePhotoStatus,
          data.profilePhotoStatus.toString());
      prefs.setString(PrefConstant.drivingLicenceFrontStatus,
          data.drivingLicenceFrontStatus.toString());
      prefs.setString(PrefConstant.vehicleInsuranceStatus,
          data.vehicleInsuranceStatus.toString());
      prefs.setString(PrefConstant.registrationCertificateStatus,
          data.registrationCertificateStatus.toString());
      prefs.setString(PrefConstant.backgroundverification,
          data.backgroundVerification.toString());
 
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const DriverHomeNew()));
    } else if (response.status == 0) {
      ProgressDialog.hide(context);
      CSnackBar.showSnackBarError(response.message.toString(), context);
    } else {
      ProgressDialog.hide(context);
      CSnackBar.showSnackBarError(response.message.toString(), context);
    }
  }
 
  @override
  void dispose() {
    phoneNumberc.dispose();
    super.dispose();
  }
 
  String _handleAuthError(FirebaseAuthException error, BuildContext context) {
    switch (error.code) {
      case 'invalid-phone-number':
        CSnackBar.showSnackBarError(
            'The provided phone number is not valid.', context);
        return 'The provided phone number is not valid.';
      case 'quota-exceeded':
        CSnackBar.showSnackBarError(
            'The SMS quota for the project has been exceeded.', context);
        return 'The SMS quota for the project has been exceeded.';
      case 'network-request-failed':
        CSnackBar.showSnackBarError(
            'Network error. Please try again later.', context);
        return 'Network error. Please try again later.';
      case 'too-many-requests':
        CSnackBar.showSnackBarError(
            'Too many requests. Please try again later.', context);
        return 'Too many requests. Please try again later.';
      case 'session-expired':
        CSnackBar.showSnackBarError(
            'The SMS code has expired. Please resend the verification code.',
            context);
        return 'The SMS code has expired. Please resend the verification code.';
      case 'invalid-verification-code':
        CSnackBar.showSnackBarError(
            'The verification code is not valid.', context);
        return 'The verification code is not valid.';
      default:
        CSnackBar.showSnackBarError(
            'Something went wrong. Please try again. May be internet issue',
            context);
        return 'Something went wrong. Please try again. May be internet issue';
    }
  }
 
  void requestContactsPermission(BuildContext context) async {
    var status = await Permission.contacts.status;
    if (!status.isGranted) {
      status = await Permission.contacts.request();
    }
 
    if (status.isGranted) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const ContactSync()));
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const DriverHomeNew()));
    }
  }


   
  Future<void> getotpValidation(
      BuildContext context, phone,countryCode) async {
    ProgressDialog.show(context);
    isLoading = true;
    notifyListeners();
    final response =
        await _apiCall.getotpValidation(context, phone, countryCode);
    isLoading = false;
    notifyListeners();
    if (response.status == 1) {
      ProgressDialog.hide(context);
     
          if(response.attemptsToday != null){
            toadyattempts = response.attemptsToday!;
            if(toadyattempts>=10){
               CSnackBar.showSnackBarError('You have exceeded the maximum number of OTP requests for today. Please try again tomorrow.', context);
            }
            else {
                  firebaseAuthForVerifyPhoneNumber(
          context, phone, countryCode ?? '', 'login');
            }
          }
      //  if((response.attemptsToday ?? 0) > 3){
      //     CSnackBar.showSnackBarError('You have exceeded the maximum number of OTP requests for today. Please try again tomorrow.', context);
          
      //   }
      //   else {
      //    firebaseAuthForVerifyPhoneNumber(
      //     context, phone, countryCode!, 'login');
      //   }
      
    } else if (response.status == 0) {
      ProgressDialog.hide(context);
      CSnackBar.showSnackBarError(response.message.toString(), context);
    } else {
      ProgressDialog.hide(context);
      CSnackBar.showSnackBarError(response.message.toString(), context);
    }
  }



  Future<void> sendotpcount(
      BuildContext context, phone,countryCode, String verificationId) async {
    
    
    notifyListeners();
    final response =
        await _apiCall.sendOtpCount(context, phone, countryCode);
    
    notifyListeners();
    if (response.status == 1) {
      
     
  Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => OTPScreen(
                          countryCode: countryCode,
                          phoneNumber: phone,
                          
                          verificationid: verificationId,
                        )));
       
      
    } else if (response.status == 0) {
     
     
    } else {
      
    
    }
  }

}
 
 