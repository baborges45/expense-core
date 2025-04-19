import 'package:expense_core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../wrapper.dart';

void main() {
  group(
    'Card Container',
    () {
      testWidgets(
        'Should render card ',
        (widgetTester) async {
          final key = UniqueKey();

          await widgetTester.pumpWidget(
            Wrapper(
              child: ExpenseCardContainer(
                key: key,
              ),
            ),
          );

          expect(find.byKey(key), findsOneWidget);
        },
      );

      testWidgets(
        'Should card tap',
        (widgetTester) async {
          final key = UniqueKey();
          bool press = false;

          await widgetTester.pumpWidget(
            Wrapper(
              child: ExpenseCardContainer(
                key: key,
                onPressed: () => press = true,
              ),
            ),
          );

          await widgetTester.tap(find.byKey(key));
          expect(press, isTrue);
        },
      );

      testWidgets(
        'Should card with child',
        (widgetTester) async {
          final key = UniqueKey();

          const text = 'Text Child';

          await widgetTester.pumpWidget(
            Wrapper(
              child: ExpenseCardContainer(
                key: key,
                onPressed: () => debugPrint(''),
                child: const Text(text),
              ),
            ),
          );

          expect(find.text(text), findsOneWidget);
        },
      );
    },
  );

  group('Card Container Accessibility', () {
    testWidgets(
      'Should verify accessibility',
      (widgetTester) async {
        final SemanticsHandle handle = widgetTester.ensureSemantics();

        await widgetTester.pumpWidget(
          const Wrapper(
            child: ExpenseCardContainer(
              semanticsLabel: 'Card Container',
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
