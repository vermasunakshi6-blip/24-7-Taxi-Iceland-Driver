import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_colors.dart';

abstract final class AppSystemUi {
  static const SystemUiOverlayStyle driverDefault = SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.light,
  );

  static const SystemUiOverlayStyle chat = SystemUiOverlayStyle(
    statusBarColor: AppColors.primaryBlueStart,
    statusBarIconBrightness: Brightness.light,
    statusBarBrightness: Brightness.dark,
  );
}
