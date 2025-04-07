import 'package:mude_core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../wrapper.dart';

void main() {
  group('Loading', () {
    testWidgets('Should be loading', (widgetTester) async {
      final key = UniqueKey();
      MudeThemeManager? tokens;

      await widgetTester.pumpWidget(
        Wrapper(
          onTokens: (t) => tokens = t,
          child: MudeLoading(key: key),
        ),
      );

      final loading1 = find.byKey(const Key('loading-1'));
      final container1 = widgetTester.widget<AnimatedContainer>(loading1);
      final decoration1 = container1.decoration as BoxDecoration;
      expect(decoration1.color, tokens!.globals.colors.green500);

      await widgetTester.pump(const Duration(milliseconds: 270));

      final loading2 = find.byKey(const Key('loading-2'));
      final container2 = widgetTester.widget<AnimatedContainer>(loading2);
      final decoration2 = container2.decoration as BoxDecoration;
      expect(decoration2.color, tokens!.globals.colors.green500);

      await widgetTester.pump(const Duration(milliseconds: 270));

      final loading3 = find.byKey(const Key('loading-0'));
      final container3 = widgetTester.widget<AnimatedContainer>(loading3);
      final decoration3 = container3.decoration as BoxDecoration;
      expect(decoration3.color, tokens!.globals.colors.green500);
    });
  });
}
