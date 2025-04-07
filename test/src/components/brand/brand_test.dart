import 'package:mude_core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../wrapper.dart';

void main() {
  group(
    'Brand',
    () {
      testWidgets(
        'Should render brand logo',
        (widgetTester) async {
          final key = UniqueKey();
          MudeThemeManager? tokens;

          await widgetTester.pumpWidget(
            Wrapper(
              onTokens: (t) => tokens = t,
              child: MudeBrand(
                key: key,
                type: MudeBrandType.logo,
              ),
            ),
          );

          expect(find.byKey(key), findsOneWidget);

          final svg = find.byType(SvgPicture);
          final widget = widgetTester.widget<SvgPicture>(svg);

          expect(widget.height, tokens!.globals.shapes.size.s5x);
        },
      );

      testWidgets(
        'Should render brand symbol',
        (widgetTester) async {
          final key = UniqueKey();
          MudeThemeManager? tokens;

          await widgetTester.pumpWidget(
            Wrapper(
              onTokens: (t) => tokens = t,
              child: MudeBrand(
                key: key,
                type: MudeBrandType.symbol,
              ),
            ),
          );

          expect(find.byKey(key), findsOneWidget);

          final svg = find.byType(SvgPicture);
          final widget = widgetTester.widget<SvgPicture>(svg);

          expect(widget.height, tokens!.globals.shapes.size.s5x);
          expect(widget.width, tokens!.globals.shapes.size.s5x);
        },
      );
    },
  );

  group('Brand Accessibility', () {
    testWidgets(
      'Should verify accessibility',
      (widgetTester) async {
        final SemanticsHandle handle = widgetTester.ensureSemantics();

        await widgetTester.pumpWidget(
          const Wrapper(
            child: MudeBrand(
              type: MudeBrandType.logo,
              semanticsLabel: 'logo',
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
