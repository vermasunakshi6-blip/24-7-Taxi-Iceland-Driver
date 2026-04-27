import 'package:taxi_driver_24_7/apppackages.dart';
import 'package:taxi_driver_24_7/model/get_otp_validation_model.dart';
import 'package:taxi_driver_24_7/model/login_model.dart';
import 'package:taxi_driver_24_7/model/logout_model.dart';
import 'package:taxi_driver_24_7/model/send_otp_count_model.dart';
import 'package:taxi_driver_24_7/services/api_endpoints.dart';
import 'package:taxi_driver_24_7/services/api_services.dart';
import 'package:taxi_driver_24_7/model/register_model.dart';

class AuthApiCall {
  static String key = Environment.encryptionKey;

  String? deviceType;
  RegisterModel? dataModel;
  LoginModel? loginModel;
  GetOtpValidation? getOtpValidation;
  LogoutModel? logoutModel;
  SendOtpCountModel? sendOtpCountModel;
  ApiServices apiServices = ApiServices();

  Future<RegisterModel> register(
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
    deviceType = Platform.isAndroid ? '1' : (Platform.isIOS ? '2' : '2');
    Map<String, Object> params = {
      'firstName': fname,
      'lastName': lname,
      'countryCode': countryCode,
      'phone': phone,
      'email': email,
      'country': country,
      'state': state,
      'city': city,
      'regType': regType,
      'deviceType': deviceType!,
      'deviceToken': deviceToken,
      
    };
    dataModel = await apiServices.postRequest(context, params,
        ApiEndPoints.regsiter, RegisterModel.fromJson, 'Register');
    return dataModel!;
  }

  Future<LoginModel> login(
      BuildContext context, phone, regType, deviceToken, countryCode) async {
    deviceType = Platform.isAndroid ? '1' : (Platform.isIOS ? '2' : '2');
    Map<String, Object> params = {
      'phone': phone,
      'countryCode': countryCode,
      'deviceType': deviceType!,
      'deviceToken': deviceToken,
    };
    final result = await apiServices.postRequest(
        context, params, ApiEndPoints.login, LoginModel.fromJson, 'Login');
    loginModel = result;
    return loginModel ??
        LoginModel(
          status: 0,
          message: 'Login failed. Please try again.',
          data: null,
        );
  }

  Future<LogoutModel> logout(BuildContext context, userId, deviceToken) async {
    Map<String, Object> params = {
      'userId': userId,
      'deviceToken': deviceToken,
    };

    logoutModel = await apiServices.postRequest(
        context, params, ApiEndPoints.logout, LogoutModel.fromJson, 'Logout');
    return logoutModel!;
  }

  Future<GetOtpValidation> getotpValidation(
      BuildContext context, phone, countryCode) async {
    Map<String, Object> params = {
      'phone': countryCode + phone,
    };
    final result = await apiServices.postRequest(
        context,
        params,
        ApiEndPoints.getOtpAttempts,
        GetOtpValidation.fromJson,
        'Get OTP Validation');
    getOtpValidation = result;
    return getOtpValidation ??
        GetOtpValidation(
          status: 0,
          message: 'Unable to request OTP. Please try again.',
        );
  }


   Future<SendOtpCountModel> sendOtpCount(
      BuildContext context, phone, countryCode) async {
    Map<String, Object> params = {
      'phone': countryCode + phone,
    };
    final result = await apiServices.postRequest(
        context,
        params,
        ApiEndPoints.sendOtpCount,
        SendOtpCountModel.fromJson,
        'Send OTP Count');
    sendOtpCountModel = result;
    return sendOtpCountModel ??
        SendOtpCountModel(
          status: 0,
          message: 'Unable to send OTP. Please try again.',
        );
  }
}
