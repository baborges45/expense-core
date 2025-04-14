import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:expense_core/core.dart';

import '../../../wrapper.dart';

void main() {
  group(
    'Progress Circular Accessibility',
    () {
      testWidgets(
        'Should verify accessibility',
        (widgetTester) async {
          final SemanticsHandle handle = widgetTester.ensureSemantics();
          await widgetTester.pumpWidget(
            const Wrapper(
              child: ExpenseProgressCircular(
                progress: 11,
                size: ExpenseProgressCircularSize.sm,
              ),
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

          handle.dispose();
        },
      );
    },
  );
  group(
    'Progress circular',
    () {
      testWidgets(
        'Should be render correctly',
        (widgetTester) async {
          final key = UniqueKey();

          await widgetTester.pumpWidget(
            Wrapper(
              child: ExpenseProgressCircular(
                key: key,
                progress: 0,
              ),
            ),
          );
          expect(find.byKey(key), findsOneWidget);
        },
      );

      testWidgets(
        'Should be render with a label',
        (widgetTester) async {
          final key = UniqueKey();
          await widgetTester.pumpWidget(
            Wrapper(
              child: ExpenseProgressCircular(
                key: key,
                progress: 10,
              ),
            ),
          );
          expect(find.text('10%'), findsOneWidget);
        },
      );

      testWidgets(
        'Should be render with size lg',
        (widgetTester) async {
          final key = UniqueKey();
          ExpenseThemeManager? tokens;

          await widgetTester.pumpWidget(
            Wrapper(
              onTokens: (t) => tokens = t,
              child: ExpenseProgressCircular(
                key: key,
                progress: 10,
                size: ExpenseProgressCircularSize.lg,
              ),
            ),
          );

          final widget = widgetTester.widget<SizedBox>(find.byType(SizedBox));
          final height = widget.height;
          expect(height, tokens?.globals.shapes.size.s6x);
        },
      );

      testWidgets(
        'Should be render with size me',
        (widgetTester) async {
          final key = UniqueKey();
          ExpenseThemeManager? tokens;

          await widgetTester.pumpWidget(
            Wrapper(
              onTokens: (t) => tokens = t,
              child: ExpenseProgressCircular(
                key: key,
                progress: 10,
                size: ExpenseProgressCircularSize.lg,
              ),
            ),
          );

          final widget = widgetTester.widget<SizedBox>(find.byType(SizedBox));
          final height = widget.height;
          expect(height, tokens?.globals.shapes.size.s6x);
        },
      );

      testWidgets(
        'Should be render with size sm',
        (widgetTester) async {
          final key = UniqueKey();
          ExpenseThemeManager? tokens;

          await widgetTester.pumpWidget(
            Wrapper(
              onTokens: (t) => tokens = t,
              child: ExpenseProgressCircular(
                key: key,
                progress: 10,
                size: ExpenseProgressCircularSize.sm,
              ),
            ),
          );

          await expectLater(
            widgetTester,
            meetsGuideline(textContrastGuideline),
          );

          final widget = widgetTester.widget<SizedBox>(find.byType(SizedBox));
          final height = widget.height;
          expect(height, tokens?.globals.shapes.size.s3x);
        },
      );
    },
  );
}
