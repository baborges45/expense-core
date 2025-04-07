import 'package:mude_core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../wrapper.dart';

void main() {
  group(
    'NavControl Dot',
    () {
      testWidgets(
        'Should render nav control',
        (widgetTester) async {
          int itemSelected = 0;
          MudeThemeManager? tokens;

          await widgetTester.pumpWidget(
            Wrapper(
              onTokens: (t) => tokens = t,
              child: MudeNavControlDot(
                length: 5,
                indexSelected: itemSelected,
              ),
            ),
          );

          final widget = find.byType(AnimatedContainer);
          final navcontrol = widgetTester.widget<AnimatedContainer>(
            widget.first,
          );

          final constraints = navcontrol.constraints as BoxConstraints;
          expect(constraints.maxWidth, tokens!.globals.shapes.size.s1x);
        },
      );

      testWidgets(
        'Should render nav control inverse',
        (widgetTester) async {
          int itemSelected = 0;
          MudeThemeManager? tokens;

          await widgetTester.pumpWidget(
            Wrapper(
              onTokens: (t) => tokens = t,
              child: MudeNavControlDot(
                length: 5,
                inverse: true,
                indexSelected: itemSelected,
              ),
            ),
          );

          final widget = find.byType(AnimatedContainer);
          final navcontrol = widgetTester.widget<AnimatedContainer>(
            widget.first,
          );

          final boxdecoration = navcontrol.decoration as BoxDecoration;
          expect(boxdecoration.color, tokens!.alias.color.inverse.iconColor);
        },
      );
    },
  );

  group('NavControl Dot Accessibility', () {
    testWidgets(
      'Should verify accessibility',
      (widgetTester) async {
        final SemanticsHandle handle = widgetTester.ensureSemantics();
        int itemSelected = 0;

        await widgetTester.pumpWidget(
          Wrapper(
            child: MudeNavControlDot(
              length: 5,
              indexSelected: itemSelected,
              semanticsLabel: 'NavControl Dot',
            ),
          ),
        );

        // Checks that tappable nodes have a minimum size of 48 by 48 pixels
        // for Android.
        await expectLater(
          widgetTester,
          meetsGuideline(androidTapTargetGuideline),
        );

        // Checks that tappable nodes have a minimum size of 44 by 44 pixels
        // for iOS.
        await expectLater(
          widgetTester,
          meetsGuideline(iOSTapTargetGuideline),
        );

        // Checks that touch targets with a tap or long press action are labeled.
        await expectLater(
          widgetTester,
          meetsGuideline(labeledTapTargetGuideline),
        );

        // Checks whether semantic nodes meet the minimum text contrast levels.
        // The recommended text contrast is 3:1 for larger text
        // (18 point and above regular).
        await expectLater(
          widgetTester,
          meetsGuideline(textContrastGuideline),
        );

        handle.dispose();
      },
    );
  });
}
