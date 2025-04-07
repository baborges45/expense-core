import 'package:mude_core/src/utils/pixel_ratio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../wrapper.dart';

void main() {
  testWidgets(
    'Should verify accessibility',
    (widgetTester) async {
      BuildContext? context;
      double value = 120;

      await widgetTester.pumpWidget(
        Wrapper(
          onContext: (c) => context = c,
          child: const Icon(Icons.abc),
        ),
      );

      final mediaQueryData = MediaQuery.of(context!);
      final devicePixelRatio = mediaQueryData.devicePixelRatio;
      final screenWidth = mediaQueryData.size.width / devicePixelRatio;
      final double pixelRatio = screenWidth / 360;

      final calc = PixelRatio.calc(context!, value);

      expect(calc, value * pixelRatio);
    },
  );
}
