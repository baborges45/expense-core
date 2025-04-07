import 'package:flutter/material.dart';

class PixelRatio {
  // coverage:ignore-start
  PixelRatio._();
  // coverage:ignore-end

  static double calc(BuildContext context, double value) {
    final mediaQueryData = MediaQuery.of(context);
    final devicePixelRatio = mediaQueryData.devicePixelRatio;
    final screenWidth = mediaQueryData.size.width / devicePixelRatio;

    const double referenceWidth = 360.0;
    final double pixelRatio = screenWidth / referenceWidth;

    return value * pixelRatio;
  }
}
