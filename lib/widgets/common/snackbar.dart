import 'package:taxi_driver_24_7/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CSnackBar{
 static void showSnackBar(String message, BuildContext context){
    ScaffoldMessenger.of(context).showSnackBar(
     SnackBar(content: Text(message),
     backgroundColor: AppColors.blackColor,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.only(
          bottom: 100,
          right: 20,
          left: 20,
        ),
        duration: const Duration(seconds: 2),
     ),
    );
  }


   static void showSnackBarError(String message, BuildContext context){
    ScaffoldMessenger.of(context).showSnackBar(
     SnackBar(content: Text(message),
     backgroundColor: AppColors.redColor,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.only(
          bottom: 100,
          right: 20,
          left: 20,
        ),
     ),
    );
  }
}