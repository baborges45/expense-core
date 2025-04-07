import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mude_core/core.dart';

import '../../../wrapper.dart';

void main() {
  group(
    'Icon Accessibility',
    () {
      testWidgets(
        'Should verify accessibility',
        (widgetTester) async {
          final SemanticsHandle handle = widgetTester.ensureSemantics();

          await widgetTester.pumpWidget(
            Wrapper(
              child: MudeIcon(icon: MudeIcons.calendarLine),
            ),
          );

          await expectLater(
            widgetTester,
            meetsGuideline(androidTapTargetGuideline),
          );

          await expectLater(
            widgetTester,
            meetsGuideline(iOSTapTargetGuideline),
          );

          await expectLater(
            widgetTester,
            meetsGuideline(labeledTapTargetGuideline),
          );

          await expectLater(
            widgetTester,
            meetsGuideline(textContrastGuideline),
          );

          handle.dispose();
        },
      );
    },
  );
  group(
    'Icon',
    () {
      testWidgets(
        'Should be render correctly',
        (widgetTester) async {
          final key = UniqueKey();

          await widgetTester.pumpWidget(
            Wrapper(
              child: MudeIcon(
                key: key,
                icon: MudeIcons.closeLine,
              ),
            ),
          );
          expect(find.byKey(key), findsOneWidget);
        },
      );

      testWidgets(
        'Should be size sm',
        (widgetTester) async {
          final key = UniqueKey();
          MudeThemeManager? tokens;
          await widgetTester.pumpWidget(
            Wrapper(
              onTokens: (t) => tokens = t,
              child: MudeIcon(
                key: key,
                icon: MudeIcons.closeLine,
                size: MudeIconSize.sm,
              ),
            ),
          );

          final widget =
              widgetTester.widget<SvgPicture>(find.byType(SvgPicture));
          final height = widget.height;
          expect(height, tokens?.globals.shapes.size.s2x);
        },
      );

      testWidgets(
        'Should be size md',
        (widgetTester) async {
          final key = UniqueKey();
          MudeThemeManager? tokens;
          await widgetTester.pumpWidget(
            Wrapper(
              onTokens: (t) => tokens = t,
              child: MudeIcon(
                key: key,
                icon: MudeIcons.closeLine,
                size: MudeIconSize.lg,
              ),
            ),
          );

          final widget =
              widgetTester.widget<SvgPicture>(find.byType(SvgPicture));
          final height = widget.height;
          expect(height, tokens?.globals.shapes.size.s2_5x);
        },
      );
    },
  );
}
