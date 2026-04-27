// ignore_for_file: use_build_context_synchronously


import 'package:flutter_contacts/flutter_contacts.dart';

import 'package:taxi_driver_24_7/screen/driver/home/driver_home_new.dart';

import '../../apppackages.dart';

class RegisterProvider extends ChangeNotifier {
  final AuthApiCall _apiProvider = AuthApiCall();
  bool isLoading = false;
  bool isChecked = false;
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
   
 
 
 
  String userTypes = '';
  bool isCountryCode = false;
  String? receivedID;
  bool? otpFieldVisibility;
  String? phoneNumberWithCode;
  String? phoneNumber;
  List<dynamic> contacts = [];
  bool get value => isChecked;

  String? mycountryValuea = 'India';
  String? mystateValue = '';
  String? mycityValue = '';
  String countryCode = '+91';

  String get countryValue => mycountryValuea ?? "";
  String get stateValue => mystateValue ?? "";
  String get cityValue => mycityValue ?? "";

  FirebaseAuth auth = FirebaseAuth.instance;

  void setValue(bool newValue) {
    isChecked = newValue;
    notifyListeners();
  }

  void setCountryValue(String newValue) async{
    mycountryValuea = newValue;
    await readJson();
    notifyListeners();
  }

  void setStateValue(String? newValue) {
    mystateValue = newValue;
    notifyListeners();
  }

  void setCityValue(String? newValue) {
    mycityValue = newValue;
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
  }

  Future<void> requestContactPermissions(BuildContext context) async {
    PermissionStatus status = await Permission.contacts.request();
    if (status.isGranted) {
      loadContacts();
    } else if (status.isDenied) {
      CSnackBar.showSnackBarError(
          "Please allow contacts for process your register request", context);
    } else if (status.isPermanentlyDenied) {}
  }

  Future<void> loadContacts() async {
    Iterable<Contact> contactsFromDevice = await FlutterContacts.getContacts();
    for (var items in contactsFromDevice.toList()) {
      contacts
          .add({"name": items.displayName, "phone": items.phones!.isNotEmpty ? items.phones!.first.number : ""});
    }
   }


  void validation(BuildContext context, String userType) {
    userTypes = userType;
    if (firstNameController.text.isEmpty ||
        lastNameController.text.isEmpty ||
        emailController.text.isEmpty ||
        countryValue.isEmpty ||
        stateValue.isEmpty ||
        cityValue.isEmpty ||
        phoneNumberController.text.isEmpty) {
      CSnackBar.showSnackBarError("Please fill all the fields", context);
    } 
    else if (!emailController.text.contains("@") ) {
      CSnackBar.showSnackBarError("Please enter valid email", context);
    } else if (!isChecked) {
      CSnackBar.showSnackBarError(
          "Please check the terms and conditions", context);
    } else {
      firebaseAuthForVerifyPhoneNumber(
          context, phoneNumberController.text, countryCode, 'register');
    }
  }
  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('assets/json/countrycodes.json');
    final data = await json.decode(response);

    for (var item in data) {
      if (item['name'] == countryValue) {
        countryCode = item['dial_code'];
        isCountryCode = true;
      }
    }
  }

  Future<void> firebaseAuthForVerifyPhoneNumber(BuildContext context,
      String phoneNumber, String countryCode, String s) async {
    ProgressDialog.show(context);
    phoneNumberWithCode = countryCode + phoneNumber;
    phoneNumber = phoneNumber;
    auth.verifyPhoneNumber(
      phoneNumber: phoneNumberWithCode,
      verificationCompleted: (PhoneAuthCredential credential) async {
        ProgressDialog.hide(context);
        await auth.signInWithCredential(credential).then((value) =>
            CSnackBar.showSnackBar("Register Successfully", context));
      },
      verificationFailed: (FirebaseAuthException e) {
        ProgressDialog.hide(context);
        _handleAuthError(e, context);
      },
      codeSent: (String verificationId, int? resendToken) {
        ProgressDialog.hide(context);
        CSnackBar.showSnackBar('OTP Sent Successfully', context);
        receivedID = verificationId;
        otpFieldVisibility = true;
          Navigator.push(
              context, MaterialPageRoute(builder: (context) =>  OTPScreen(verificationid: 
              verificationId,countryCode: countryCode,phoneNumber: phoneNumber,)));
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        ProgressDialog.hide(context);
      },
    );
  }

  // for otp verify
  Future<void> firebaseAuthForVerifyOtpCode(
    BuildContext context,
    String otp,
    String verificationId,
    String token,
    
  ) async {
    ProgressDialog.show(context);
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otp,
      );

      await auth.signInWithCredential(credential).then((value) {
        ProgressDialog.hide(context);
        register(
          context,
          firstNameController.text,
          lastNameController.text,
          countryCode,
          phoneNumberController.text,
          emailController.text,
          countryValue,
          stateValue,
          cityValue,
          userTypes,
          token,
          
        );
      });
    } on FirebaseAuthException catch (e) {
      ProgressDialog.hide(context);
      _handleAuthError(e, context);
    }
  }

  Future<void> register(
    BuildContext context,
    String fname,
    String lname,
    String countryCode,
    String phone,
    String email,
    String country,
    String state,
    String city,
    String regType,
    String deviceToken,
    
  ) async {
    isLoading = true;
    notifyListeners();
    final response = await _apiProvider.register(context,fname, lname, countryCode,
        phone, email, country, state, city, regType, deviceToken);
    isLoading = false;
    notifyListeners();
    if (response.status == 1) {
             
      CSnackBar.showSnackBar(response.message.toString(), context);
      SharedPreferences? prefs = await SharedPreferences.getInstance();
      prefs.setString(PrefConstant.userid, response.data!.sId!);
      prefs.setString(PrefConstant.userType, response.data!.regType!);
      prefs.setString(PrefConstant.currentType, response.data!.currentType!);
  prefs.setString(PrefConstant.userNumber, response.data!.phone!);
      prefs.setString(PrefConstant.vehicleDetailStatus,
          response.data!.vehicleDetailStatus.toString());
 prefs.setString(PrefConstant.userName, response.data!.firstName!+response.data!.lastName!);
 prefs.setString(PrefConstant.userEmail, response.data!.email!);
      prefs.setString(PrefConstant.profilePhotoStatus,
          response.data!.profilePhotoStatus.toString());
 prefs.remove(PrefConstant.refcode);
      prefs.setString(PrefConstant.drivingLicenceFrontStatus,
          response.data!.drivingLicenceFrontStatus.toString());

      prefs.setString(PrefConstant.vehicleInsuranceStatus,
          response.data!.profilePhotoStatus.toString());

      prefs.setString(PrefConstant.registrationCertificateStatus,
          response.data!.registrationCertificateStatus.toString());

      prefs.setString(PrefConstant.backgroundverification,
          response.data!.backgroundVerification.toString());

      prefs.setString(
          PrefConstant.firstName, response.data!.firstName.toString());

      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const DriverHomeNew()));
    } else if (response.status == 0) {
      CSnackBar.showSnackBarError(response.message.toString(), context);
    } else {}
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
            'Something went wrong. Please try again. May be Internet Issue', context);
        return 'Something went wrong. Please try again. May be Internet Issue';
    }
  }
  
 
   void requestContactsPermission(BuildContext context) async {


   var status = await Permission.contacts.status;
    if (!status.isGranted) {
      status = await Permission.contacts.request();
    }

    if (status.isGranted) {
     
       Navigator.pushReplacement(context,
               MaterialPageRoute(builder: (context) =>  const ContactSync()));
    } else {
        
       Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) =>  const DriverHomeNew()));
    }
 }
}
