// ignore_for_file: use_build_context_synchronously
import 'dart:convert';
import 'dart:developer';
import 'package:aescryptojs/aescryptojs.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:taxi_driver_24_7/environment.dart';
import 'package:taxi_driver_24_7/services/api_endpoints.dart';
import 'package:taxi_driver_24_7/services/connectivity_controller.dart';
import 'package:taxi_driver_24_7/services/hmacs.dart';
import 'package:taxi_driver_24_7/widgets/common/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  static String key = Environment.encryptionKey;
  Future<T?> postRequest<T>(
      BuildContext context,
      Map<String, Object> params,
      String apiEndpoint,
      T Function(Map<String, dynamic>)? fromJson,
      String responseName) async {
    var result = await Connectivity().checkConnectivity();
    if (ConnectivityController().isInternetConnected(result)) {
      try {
        Uri url = Uri.parse(ApiEndPoints.apiBaseUrl + apiEndpoint);
        final enc = encryptAESCryptoJS(jsonEncode(params), key);
        final signature = Hmacs.hmacSignature(jsonEncode(params), key);
        var headers = {
          'HMAC': signature,
          'Content-Type': 'application/x-www-form-urlencoded'
        };
        log("$responseName hmac & enc: $signature && $enc && $params ");

        var response =
            await http.post(url, headers: headers, body: {'data': enc});
        log("$responseName response : " + response.body);
        if (response.statusCode == 200) {
          final dec = decryptAESCryptoJS(json.decode(response.body), key);
          log("$responseName response : $dec");
          if (fromJson != null) {
            return fromJson(jsonDecode(dec));
          } else {
            return null;
          }
        } else {
          log("$responseName error: ${response.statusCode} ");
          return null;
        }
      } on Exception catch (e) {
        debugPrint('Exception found! -> $e');
        return null;
      }
    } else {
      CSnackBar.showSnackBarError('Internet is not connected', context);
      return null;
    }
  }

  Future<T?> singleImageRequest<T>(
      BuildContext context,
      Map<String, Object> params,
      String apiEndpoint,
      T Function(Map<String, dynamic>) fromJson,
      String responseName,
      String image,
      String imagekey) async {
    var result = await Connectivity().checkConnectivity();
    if (ConnectivityController().isInternetConnected(result)) {
      try {
        final enc = encryptAESCryptoJS(jsonEncode(params), key);
        Uri url = Uri.parse(ApiEndPoints.apiBaseUrl + apiEndpoint);
        final signature = Hmacs.hmacSignature(jsonEncode(params), key);
        var headers = {
          'HMAC': signature,
          'Content-Type': 'multipart/form-data'
        };
        log("$responseName response: $headers");
        log("$responseName response: $enc");
        var request = http.MultipartRequest('POST', url);
        image == ''
            ? request.fields[imagekey] = ''
            : request.files
                .add(await http.MultipartFile.fromPath(imagekey, image));
        request.fields.addAll({'data': enc});
        request.headers.addAll(headers);
        http.StreamedResponse response = await request.send();
        if (response.statusCode == 200) {
          final response1 = await http.Response.fromStream(response);
          final dec = decryptAESCryptoJS(json.decode(response1.body), key);
          log("$responseName response: $dec");
          return fromJson(jsonDecode(dec));
        } else {
          log("$responseName error: ${response.statusCode}");
          return null;
        }
      } on Exception catch (e) {
        debugPrint('Exception Occured! -> $e');
        return null;
      }
    } else {
      CSnackBar.showSnackBarError('Internet is not connected', context);
      return null;
    }
  }

  Future<T?> multipleImagesRequest<T>(
    BuildContext context,
    Map<String, dynamic> params,
    String apiEndpoint,
    T Function(Map<String, dynamic>) fromJson,
    String responseName,
    List<String> images,
    String imagekey,
  ) async {
    var result = await Connectivity().checkConnectivity();
    if (ConnectivityController().isInternetConnected(result)) {
      try {
        final enc = encryptAESCryptoJS(jsonEncode(params), key);
        Uri url = Uri.parse(ApiEndPoints.apiBaseUrl + apiEndpoint);
        final signature = Hmacs.hmacSignature(jsonEncode(params), key);
        var headers = {
          'HMAC': signature,
          'Content-Type': 'multipart/form-data'
        };
        var request = http.MultipartRequest('POST', url);
        for (int i = 0; i < images.length; i++) {
          request.files.add(await http.MultipartFile.fromPath(
              imagekey, images[i].toString()));
        }
        request.fields.addAll({'data': enc});
        request.headers.addAll(headers);
        http.StreamedResponse response = await request.send();
        if (response.statusCode == 200) {
          final response1 = await http.Response.fromStream(response);
          final dec = decryptAESCryptoJS(json.decode(response1.body), key);
          log("$responseName Response: $dec");
          return fromJson(jsonDecode(dec));
        } else {
          return null;
        }
      } on Exception catch (e) {
        debugPrint('Exception Occured! -> $e');
        return null;
      }
    } else {
      CSnackBar.showSnackBarError('Internet is not connected', context);
      return null;
    }
  }

  Future<T?> twoImagesRequest<T>(
    BuildContext context,
    Map<String, dynamic> params,
    String apiEndpoint,
    T Function(Map<String, dynamic>) fromJson,
    String responseName,
    String imagekey,
    String imagekey1,
    String image,
    String image1,
  ) async {
    var result = await Connectivity().checkConnectivity();
    if (ConnectivityController().isInternetConnected(result)) {
      try {
        final enc = encryptAESCryptoJS(jsonEncode(params), key);

        Uri url = Uri.parse(ApiEndPoints.apiBaseUrl + apiEndpoint);
        final signature = Hmacs.hmacSignature(jsonEncode(params), key);
        var headers = {
          'HMAC': signature,
          'Content-Type': 'multipart/form-data'
        };

        var request = http.MultipartRequest('POST', url);
        request.files.add(await http.MultipartFile.fromPath(imagekey, image));
        request.files.add(await http.MultipartFile.fromPath(imagekey1, image1));
        request.fields.addAll({'data': enc});
        request.headers.addAll(headers);
        http.StreamedResponse response = await request.send();
        if (response.statusCode == 200) {
          final response1 = await http.Response.fromStream(response);
          final dec = decryptAESCryptoJS(json.decode(response1.body), key);
          log("$responseName  Response: $dec");
          return fromJson(jsonDecode(dec));
        } else {
          return null;
        }
      } on Exception catch (e) {
        debugPrint('Exception occurred! -> $e');
        return null;
      }
    } else {
      CSnackBar.showSnackBarError('Internet is not connected', context);
      return null;
    }
  }

  Future<T?> getRequest<T>(BuildContext context, String apiEndpoint,
      T Function(Map<String, dynamic>) fromJson, String responseName) async {
    var result = await Connectivity().checkConnectivity();
    if (ConnectivityController().isInternetConnected(result)) {
      try {
        Uri url = Uri.parse(ApiEndPoints.apiBaseUrl + apiEndpoint);
        var res = await http.get(
          url,
        );
        if (res.statusCode == 200) {
          return fromJson(jsonDecode(res.body));
        } else {
          return null;
        }
      } on Exception catch (e) {
        debugPrint('Exception Occured -> $e');
        return null;
      }
    } else {
      CSnackBar.showSnackBarError('Internet is not connected', context);
      return null;
    }
  }

  Future<T?> multipartWithoutImageRequest<T>(
    BuildContext context,
    Map<String, Object> params,
    String apiEndpoint,
    T Function(Map<String, dynamic>) fromJson,
    String responseName,
  ) async {
    var result = await Connectivity().checkConnectivity();
    if (ConnectivityController().isInternetConnected(result)) {
      try {
        final enc = encryptAESCryptoJS(jsonEncode(params), key);
        Uri url = Uri.parse(ApiEndPoints.apiBaseUrl + apiEndpoint);
        final signature = Hmacs.hmacSignature(jsonEncode(params), key);
        var headers = {
          'HMAC': signature,
          'Content-Type': 'multipart/form-data'
        };

        var request = http.MultipartRequest('POST', url);
        request.fields.addAll({'data': enc});
        request.headers.addAll(headers);
        http.StreamedResponse response = await request.send();
        if (response.statusCode == 200) {
          final response1 = await http.Response.fromStream(response);
          final dec = decryptAESCryptoJS(json.decode(response1.body), key);
          log("$responseName response: $dec");
          return fromJson(jsonDecode(dec));
        } else {
          log("$responseName error: ${response.statusCode}");
          return null;
        }
      } on Exception catch (e) {
        debugPrint('Exception Occured! -> $e');
        return null;
      }
    } else {
      CSnackBar.showSnackBarError('Internet is not connected', context);
      return null;
    }
  }

    Future<T?> getRequestWithHmac<T>(
      BuildContext context,
      Map<dynamic, dynamic> params,
      String apiEndpoint,
      T Function(Map<String, dynamic>)? fromJson,
      String responseName) async {
    var result = await Connectivity().checkConnectivity();
    if (ConnectivityController().isInternetConnected(result)) {
      try {
        Uri url = Uri.parse(ApiEndPoints.apiBaseUrl + apiEndpoint);
        final enc = encryptAESCryptoJS(jsonEncode(params), key);
        final signature = Hmacs.hmacSignature(jsonEncode(params), key);
        var headers = {
          'HMAC': signature,
          'Content-Type': 'application/x-www-form-urlencoded'
        };
        log("$responseName hmac & enc: $signature && $enc && $params ");

        var response =
            await http.get(url, headers: headers,);
        if (response.statusCode == 200) {
          final dec = decryptAESCryptoJS(json.decode(response.body), key);
          log("$responseName response : $dec");
          if (fromJson != null) {
            return fromJson(jsonDecode(dec));
          } else {
            return null;
          }
        } else {
          log("$responseName error: ${response.statusCode} ");
          return null;
        }
      } on Exception catch (e) {
        debugPrint('Exception found! -> $e');
        return null;
      }
    } else {
      CSnackBar.showSnackBarError('Internet is not connected', context);
      return null;
    }
  }
}
