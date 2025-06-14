import 'package:expense_core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../wrapper.dart';

void main() {
  group(
    'Badge',
    () {
      testWidgets(
        'Should be render correctly',
        (widgetTester) async {
          final key = UniqueKey();

          await widgetTester.pumpWidget(
            Wrapper(
              child: ExpenseBadge(
                key: key,
              ),
            ),
          );
          expect(find.byKey(key), findsOneWidget);
        },
      );

      testWidgets(
        'Should be large',
        (widgetTester) async {
          final key = UniqueKey();

          await widgetTester.pumpWidget(
            Wrapper(
              child: ExpenseBadge(
                key: key,
                size: ExpenseBadgeSize.lg,
              ),
            ),
          );
          final widget = widgetTester.widget<ExpenseBadge>(find.byKey(key));
          expect(widget.size, ExpenseBadgeSize.lg);
        },
      );

      testWidgets(
        'Should be small',
        (widgetTester) async {
          final key = UniqueKey();
          await widgetTester.pumpWidget(
            Wrapper(
              child: ExpenseBadge(
                key: key,
                size: ExpenseBadgeSize.sm,
              ),
            ),
          );

          final widget = widgetTester.widget<ExpenseBadge>(find.byKey(key));
          expect(widget.size, ExpenseBadgeSize.sm);
        },
      );
    },
  );

  group('Badge Accessibility', () {
    testWidgets(
      'Should verify accessibility',
      (widgetTester) async {
        final SemanticsHandle handle = widgetTester.ensureSemantics();

        await widgetTester.pumpWidget(
          const Wrapper(
            child: ExpenseBadge(
              semanticsLabel: 'Badge',
              semanticsHint: 'Badge',
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
