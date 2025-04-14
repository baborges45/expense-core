import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:expense_core/core.dart';

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
              child: ExpenseIcon(icon: ExpenseIcons.calendarLine),
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
              child: ExpenseIcon(
                key: key,
                icon: ExpenseIcons.closeLine,
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
          ExpenseThemeManager? tokens;
          await widgetTester.pumpWidget(
            Wrapper(
              onTokens: (t) => tokens = t,
              child: ExpenseIcon(
                key: key,
                icon: ExpenseIcons.closeLine,
                size: ExpenseIconSize.sm,
              ),
            ),
          );

          final widget = widgetTester.widget<SvgPicture>(find.byType(SvgPicture));
          final height = widget.height;
          expect(height, tokens?.globals.shapes.size.s2x);
        },
      );

      testWidgets(
        'Should be size md',
        (widgetTester) async {
          final key = UniqueKey();
          ExpenseThemeManager? tokens;
          await widgetTester.pumpWidget(
            Wrapper(
              onTokens: (t) => tokens = t,
              child: ExpenseIcon(
                key: key,
                icon: ExpenseIcons.closeLine,
                size: ExpenseIconSize.lg,
              ),
            ),
          );

          final widget = widgetTester.widget<SvgPicture>(find.byType(SvgPicture));
          final height = widget.height;
          expect(height, tokens?.globals.shapes.size.s2_5x);
        },
      );
    },
  );
}
