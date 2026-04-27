// // ignore_for_file: use_build_context_synchronously
// import '../apppackages.dart';

// class Loginprovider {
//   bool? otpFieldVisibility;
//   bool isLoading = false;
//   final AuthApiCall _apiCall = AuthApiCall();
//   FirebaseAuth auth = FirebaseAuth.instance;
//   String countryCode='';

//   Future<void> validation(
//       BuildContext context,TextEditingController phoneNumberc, String countryCode, String userType) async {
//     if (countryCode.isEmpty || phoneNumberc.text.isEmpty) {
//       CSnackBar.showSnackBarError('Please enter mobile number first!', context);
//     } 
//     else {
//       await firebaseAuthForVerifyPhoneNumber(
//           context, phoneNumberc.text, countryCode.toString(), 'login');
//     }
//   }
//      Future<void> resendvalidation(
//       BuildContext context,String phoneNumberc, String countryCode, String userType) async {
//     if (countryCode.isEmpty || phoneNumberc.isEmpty) {
//       CSnackBar.showSnackBarError('Please enter mobile number first!', context);
//     } 
//     else {
//       await firebaseAuthForVerifyPhoneNumber(
//           context, phoneNumberc, countryCode.toString(), 'login');
//     }
//   }

//   Future<void> firebaseAuthForVerifyPhoneNumber(BuildContext context,
//       String phoneNumber, String countrycode, String s) async {
//     ProgressDialog.show(context);
//     countryCode = countrycode;
//     final String phoneNumberWithCode = '$countryCode $phoneNumber';
//     auth.verifyPhoneNumber(
//       phoneNumber: phoneNumberWithCode,
//       verificationCompleted: (PhoneAuthCredential credential) async {
//         ProgressDialog.hide(context);
//         await auth.signInWithCredential(credential).then((value) =>
//             CSnackBar.showSnackBar("Logged In Successfully", context));
//       },
//       verificationFailed: (FirebaseAuthException e) {
//         ProgressDialog.hide(context);
//         _handleAuthError(e, context);
//       },
//       codeSent: (String verificationId, int? resendToken) {
//         ProgressDialog.hide(context);
//         CSnackBar.showSnackBar('OTP Sent Successfully', context);
//         otpFieldVisibility = true;
//         if (s == 'login') {
//           Navigator.pushReplacement(
//               context, MaterialPageRoute(builder: (context) => OTPScreen(verificationid: verificationId,countryCode: countrycode,phoneNumber: phoneNumber,referCode: '',)));
//         } else {}
//       },
//       codeAutoRetrievalTimeout: (String verificationId) {
//         ProgressDialog.hide(context);
//       },
//     );
//   }

//   Future<void> firebaseAuthForVerifyOtpCode(
//       BuildContext context, String otp, String token,String verificationid,String countrycode,String phoneno,String userType) async {
//     ProgressDialog.show(context);
//     try {
//       PhoneAuthCredential credential = PhoneAuthProvider.credential(
//         verificationId: verificationid,
//         smsCode: otp,
//       );
//       await auth.signInWithCredential(credential).then((value) {
//         ProgressDialog.hide(context);
//         login(context, phoneno, userType, token, countrycode);
//       });
//     } on FirebaseAuthException catch (e) {
//       ProgressDialog.hide(context);
//       _handleAuthError(e, context);
//     }
//   }

//   Future<void> logout(BuildContext context, userId, deviceToken) async {
//     ProgressDialog.show(context);
//     final response = await _apiCall.logout(userId, deviceToken);
//     if (response.status == 1) {
//       ProgressDialog.hide(context);
//       CSnackBar.showSnackBar(response.message.toString(), context);
//       Navigator.of(context).pop();
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       prefs.clear();
//       Navigator.pushReplacement(context,
//           MaterialPageRoute(builder: (context) => const SplashScreen()));
//     } else {
//       ProgressDialog.hide(context);
//       CSnackBar.showSnackBarError(response.message.toString(), context);
//     }
//   }

//   Future<void> login(
//       BuildContext context, phone, regType, deviceToken, countryCode) async {
//     ProgressDialog.show(context);
//     final response =
//         await _apiCall.login(phone, regType, deviceToken, countryCode);
//     if (response.status == 1) {
//       ProgressDialog.hide(context);
//       CSnackBar.showSnackBar(response.message.toString(), context);
//       SharedPreferences? prefs = await SharedPreferences.getInstance();
//       prefs.setString(PrefConstant.userid, response.data!.sId!);
//       prefs.setString(PrefConstant.userType, response.data!.regType!);
//        prefs.setString(PrefConstant.userName, response.data!.firstName!+response.data!.lastName!);
//        prefs.setString(PrefConstant.userEmail, response.data!.email!);
//       prefs.setString(PrefConstant.currentType, response.data!.currentType!);
//       prefs.setString(PrefConstant.vehicleDetailStatus,
//           response.data!.vehicleDetailStatus.toString());
//             prefs.setString(PrefConstant.userNumber, response.data!.phone!);
//       prefs.setString(
//           PrefConstant.firstName, response.data!.firstName.toString());

//       prefs.setString(PrefConstant.profilePhotoStatus,
//           response.data!.profilePhotoStatus.toString());
//       prefs.setString(PrefConstant.drivingLicenceFrontStatus,
//           response.data!.drivingLicenceFrontStatus.toString());
//       prefs.setString(PrefConstant.vehicleInsuranceStatus,
//           response.data!.vehicleInsuranceStatus.toString());
//       prefs.setString(PrefConstant.registrationCertificateStatus,
//           response.data!.registrationCertificateStatus.toString());
//       prefs.setString(PrefConstant.backgroundverification,
//           response.data!.backgroundVerification.toString());


//       response.data?.currentType == AppStrings.customer
//           ? 
//           requestContactsPermission(context)
//           :  Navigator.pushReplacement(context,
//                   MaterialPageRoute(builder: (context) => const DriverHomeNew()));
//     } else if (response.status == 0) {
//       ProgressDialog.hide(context);
//       CSnackBar.showSnackBarError(response.message.toString(), context);
//     } else {
//       ProgressDialog.hide(context);
//       CSnackBar.showSnackBarError(response.message.toString(), context);
//     }
//   }

//   String _handleAuthError(FirebaseAuthException error, BuildContext context) {
//     switch (error.code) {
//       case 'invalid-phone-number':
//         CSnackBar.showSnackBarError(
//             'The provided phone number is not valid.', context);
//         return 'The provided phone number is not valid.';
//       case 'quota-exceeded':
//         CSnackBar.showSnackBarError(
//             'The SMS quota for the project has been exceeded.', context);
//         return 'The SMS quota for the project has been exceeded.';
//       case 'network-request-failed':
//         CSnackBar.showSnackBarError(
//             'Network error. Please try again later.', context);
//         return 'Network error. Please try again later.';
//       case 'too-many-requests':
//         CSnackBar.showSnackBarError(
//             'Too many requests. Please try again later.', context);
//         return 'Too many requests. Please try again later.';
//       case 'session-expired':
//         CSnackBar.showSnackBarError(
//             'The SMS code has expired. Please resend the verification code.',
//             context);
//         return 'The SMS code has expired. Please resend the verification code.';
//       case 'invalid-verification-code':
//         CSnackBar.showSnackBarError(
//             'The verification code is not valid.', context);
//         return 'The verification code is not valid.';
//       default:
//         CSnackBar.showSnackBarError(
//             'Something went wrong. Please try again. May be internet issue', context);
//         return 'Something went wrong. Please try again. May be internet issue';
//     }
//   }
//  void requestContactsPermission(BuildContext context) async {


//    var status = await Permission.contacts.status;
//     if (!status.isGranted) {
//       status = await Permission.contacts.request();
//     }

//     if (status.isGranted) {
     
//        Navigator.pushReplacement(context,
//                MaterialPageRoute(builder: (context) =>  const ContactSync()));
//     } else {
       
//        Navigator.pushReplacement(context,
//                 MaterialPageRoute(builder: (context) =>  const HomeScreen()));
//     }
//  }
  
 
// }