import 'package:expense_core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../wrapper.dart';

void main() {
  group(
    'Flag',
    () {
      testWidgets(
        'Should render flag',
        (widgetTester) async {
          final key = UniqueKey();
          const message = 'Message';

          for (var type in ExpenseFlagType.values) {
            await widgetTester.pumpWidget(
              Wrapper(
                child: ExpenseFlag(
                  key: key,
                  message: message,
                  type: type,
                ),
              ),
            );

            expect(find.text('Message', findRichText: true), findsOneWidget);
          }
        },
      );

      testWidgets(
        'Should flag showing hyperlink and tap',
        (widgetTester) async {
          final key = UniqueKey();
          const message = 'Message';
          const text = 'Link';
          bool press = false;

          await widgetTester.pumpWidget(
            Wrapper(
              child: ExpenseFlag(
                key: key,
                message: message,
                type: ExpenseFlagType.informative,
                hyperLink: ExpenseFlagHyperLink(
                  text: text,
                  onPressed: () => press = true,
                ),
              ),
            ),
          );

          expect(find.text(text), findsOneWidget);

          await widgetTester.tap(find.text(text));
          expect(press, isTrue);
        },
      );
    },
  );

  group('Flag Accessibility', () {
    testWidgets(
      'Should verify accessibility',
      (widgetTester) async {
        final SemanticsHandle handle = widgetTester.ensureSemantics();

        await widgetTester.pumpWidget(
          const Wrapper(
            child: ExpenseFlag(
              message: 'Flag',
              type: ExpenseFlagType.informative,
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
