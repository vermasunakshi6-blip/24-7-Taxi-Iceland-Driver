import 'package:flutter/material.dart';
import 'package:taxi_driver_24_7/utils/appimages.dart';

/// Logo image sized relative to screen width for consistent appearance across devices.
class AppLogo extends StatelessWidget {
  /// Fraction of screen width to use (default 0.28).
  final double widthFactor;

  /// Optional max width in logical pixels.
  final double? maxWidth;

  const AppLogo({
    super.key,
    this.widthFactor = 0.28,
    this.maxWidth = 180,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final width = (screenWidth * widthFactor).clamp(100.0, maxWidth ?? 180.0);
    return Image.asset(
      AppImages.logo,
      width: width,
      fit: BoxFit.contain,
    );
  }
}
