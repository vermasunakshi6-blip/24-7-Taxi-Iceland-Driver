// Generates a slightly zoomed (center-crop) PNG for app launcher assets.
// Run from project root: dart run tool/zoom_launcher_icon.dart

import 'dart:io';

import 'package:image/image.dart';

void main() {
  const zoom = 1.14;
  final projectRoot = Directory.current.path;
  final srcPath = '$projectRoot/assets/images/logo_white_bg.png';
  final dstPath = '$projectRoot/assets/images/logo_white_bg_launcher.png';

  final im = decodeImage(File(srcPath).readAsBytesSync());
  if (im == null) {
    stderr.writeln('Failed to decode: $srcPath');
    exit(1);
  }

  final w = im.width;
  final h = im.height;
  final nw = (w * zoom).round();
  final nh = (h * zoom).round();
  final resized = copyResize(
    im,
    width: nw,
    height: nh,
    interpolation: Interpolation.linear,
  );
  final left = (nw - w) ~/ 2;
  final top = (nh - h) ~/ 2;
  final cropped = copyCrop(
    resized,
    x: left,
    y: top,
    width: w,
    height: h,
  );

  File(dstPath).writeAsBytesSync(encodePng(cropped));
  stdout.writeln('Wrote $dstPath (${cropped.width}x${cropped.height}, zoom=$zoom)');
}
