import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:expense_core/core.dart';

import '../../../wrapper.dart';

void main() {
  group(
    'Alert',
    () {
      testWidgets(
        'Should render alert',
        (widgetTester) async {
          final key = UniqueKey();
          const message = 'Message';

          await widgetTester.pumpWidget(
            Wrapper(
              child: ExpenseAlert(
                key: key,
                message: message,
              ),
            ),
          );

          expect(find.byKey(key), findsOneWidget);
          expect(find.text(message), findsOneWidget);
        },
      );

      testWidgets(
        'Should alert not opened',
        (widgetTester) async {
          final key = UniqueKey();
          const message = 'Message';

          await widgetTester.pumpWidget(
            Wrapper(
              child: ExpenseAlert(
                key: key,
                message: message,
                open: false,
              ),
            ),
          );

          final widget = widgetTester.widget<AnimatedContainer>(
            find.byType(AnimatedContainer),
          );

          final constraints = widget.constraints as BoxConstraints;
          expect(constraints.maxHeight, 0);
        },
      );

      testWidgets(
        'Should alert closed',
        (widgetTester) async {
          final key = UniqueKey();
          const message = 'Message';
          bool press = false;

          await widgetTester.pumpWidget(
            Wrapper(
              child: ExpenseAlert(
                key: key,
                message: message,
                onClose: () => press = true,
              ),
            ),
          );

          await widgetTester.pumpAndSettle();
          await widgetTester.tap(find.byType(GestureDetector));
          await widgetTester.pumpAndSettle();

          expect(press, isTrue);
        },
      );

      testWidgets(
        'Should alert showing hyperlink',
        (widgetTester) async {
          final key = UniqueKey();
          const message = 'Message';
          const textHyperlink = 'Hyperlink';

          await widgetTester.pumpWidget(
            Wrapper(
              child: ExpenseAlert(
                key: key,
                message: message,
                hyperlink: AlertHyperLink(
                  text: textHyperlink,
                  onPressed: () => debugPrint(''),
                ),
              ),
            ),
          );

          await widgetTester.pumpAndSettle();

          expect(find.text(textHyperlink), findsOneWidget);
        },
      );

      testWidgets(
        'Should alert showing icons',
        (widgetTester) async {
          final key = UniqueKey();
          const message = 'Message';

          for (var type in ExpenseAlertType.values) {
            await widgetTester.pumpWidget(
              Wrapper(
                child: ExpenseAlert(
                  key: key,
                  message: message,
                  type: type,
                ),
              ),
            );

            await widgetTester.pumpAndSettle();
            final icons = find.byType(ExpenseIcon);
            final icon = widgetTester.widget<ExpenseIcon>(icons.first);

            switch (type) {
              case ExpenseAlertType.positive:
                expect(icon.icon.name, ExpenseIcons.positiveLine.name);
                break;
              case ExpenseAlertType.negative:
                expect(icon.icon.name, ExpenseIcons.negativeLine.name);
                break;
              case ExpenseAlertType.informative:
                expect(icon.icon.name, ExpenseIcons.informationLine.name);
                break;
              case ExpenseAlertType.warning:
                expect(icon.icon.name, ExpenseIcons.warningLine.name);
                break;
              case ExpenseAlertType.promote:
                expect(icon.icon.name, ExpenseIcons.promoteLine.name);
                break;
              default:
                expect(icon.icon.name, ExpenseIcons.positiveLine.name);
                break;
            }
          }
        },
      );
    },
  );

  group('Alert Accessibility', () {
    testWidgets(
      'Should verify accessibility',
      (widgetTester) async {
        final SemanticsHandle handle = widgetTester.ensureSemantics();

        await widgetTester.pumpWidget(
          const Wrapper(
            child: ExpenseAlert(
              message: 'Message',
              semanticsLabel: 'Alert',
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
