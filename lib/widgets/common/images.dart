import 'package:flutter/material.dart';

class Images extends StatelessWidget {
  final double? width;
  final String path;

  const Images({
    super.key,
    required this.width,
    required this.path,
  });

  @override
  Widget build(BuildContext context) {
    return Image(
        width: width,
        image: AssetImage(path));
  }
}
