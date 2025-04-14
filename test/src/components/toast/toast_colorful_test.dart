import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:expense_core/core.dart';

import '../../../wrapper.dart';

void main() {
  group(
    'Toast Colorful',
    () {
      testWidgets(
        'Should render toast colorful',
        (widgetTester) async {
          const message = 'Message';

          await widgetTester.pumpWidget(
            Wrapper(
              onTap: (context) {
                return ExpenseToastColoful.show(
                  context: context,
                  message: message,
                );
              },
              child: Container(),
            ),
          );

          final button = find.byKey(const Key('wrapper-tap'));
          await widgetTester.tap(button);
          await widgetTester.pumpAndSettle();

          expect(find.byType(AnimatedPositioned), findsOneWidget);
        },
      );

      testWidgets(
        'Should toast colorful negative',
        (widgetTester) async {
          const message = 'Message';

          await widgetTester.pumpWidget(
            Wrapper(
              onTap: (context) {
                return ExpenseToastColoful.show(
                  context: context,
                  message: message,
                  type: ExpenseToastType.negative,
                );
              },
              child: Container(),
            ),
          );

          final button = find.byKey(const Key('wrapper-tap'));
          await widgetTester.tap(button);
          await widgetTester.pumpAndSettle();

          final icons = find.byType(ExpenseIcon);
          final icon = widgetTester.widget<ExpenseIcon>(icons.first);

          expect(icon.icon.name, ExpenseIcons.negativeLine.name);
        },
      );

      testWidgets(
        'Should toast colorful close',
        (widgetTester) async {
          const message = 'Message';

          await widgetTester.pumpWidget(
            Wrapper(
              onTap: (context) {
                return ExpenseToastColoful.show(
                  context: context,
                  message: message,
                  type: ExpenseToastType.negative,
                );
              },
              child: Container(),
            ),
          );

          final button = find.byKey(const Key('wrapper-tap'));
          await widgetTester.tap(button);
          await widgetTester.pumpAndSettle();

          await widgetTester.tap(find.text(message));
          await widgetTester.pumpAndSettle();

          expect(find.byType(OverlayEntry), findsNothing);
        },
      );
    },
  );

  group('Toast Colorful Accessibility', () {
    testWidgets(
      'Should verify accessibility',
      (widgetTester) async {
        final SemanticsHandle handle = widgetTester.ensureSemantics();

        await widgetTester.pumpWidget(
          Wrapper(
            onTap: (context) {
              return ExpenseToastColoful.show(
                context: context,
                message: 'Toast',
              );
            },
            child: Container(),
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

        handle.dispose();
      },
    );
  });
}
