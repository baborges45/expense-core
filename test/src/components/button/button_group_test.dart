import 'package:expense_core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../wrapper.dart';

void main() {
  group(
    'Button group Accessibility',
    () {
      testWidgets(
        'Should verify accessibility',
        (widgetTester) async {
          var titlePrimary = 'Button Primary';
          var titleSecondary = 'Button Tertiary';
          final SemanticsHandle handle = widgetTester.ensureSemantics();

          await widgetTester.pumpWidget(
            Wrapper(
              child: ExpenseButtonGroup(
                buttonPrimary: ExpenseButton(
                  label: titlePrimary,
                  onPressed: () => debugPrint(''),
                  semanticsLabel: 'Test',
                ),
                buttonTertiary: ExpenseButtonMini(
                  label: titleSecondary,
                  onPressed: () => debugPrint(''),
                  semanticsLabel: 'Test',
                ),
                type: ExpenseButtonGrouType.group,
              ),
            ),
          );

          // await expectLater(
          //   widgetTester,
          //   meetsGuideline(androidTapTargetGuideline),
          // );

          // await expectLater(
          //   widgetTester,
          //   meetsGuideline(iOSTapTargetGuideline),
          // );

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
    'Button Group',
    () {
      testWidgets(
        'Should render button with two buttons and type group',
        (widgetTester) async {
          var titlePrimary = 'Button Primary';
          var titleSecondary = 'Button Tertiary';

          await widgetTester.pumpWidget(
            Wrapper(
              child: ExpenseButtonGroup(
                buttonPrimary: ExpenseButton(
                  label: titlePrimary,
                  onPressed: () => debugPrint(''),
                ),
                buttonTertiary: ExpenseButtonMini(
                  label: titleSecondary,
                  onPressed: () => debugPrint(''),
                ),
                type: ExpenseButtonGrouType.group,
              ),
            ),
          );

          // render button primary
          var widgetPrimary = find.text(titlePrimary);
          expect(widgetPrimary, findsOneWidget);

          // render button secondary
          var widgetSecondary = find.text(titleSecondary);
          expect(widgetSecondary, findsOneWidget);
        },
      );

      testWidgets(
        'Should render button with two buttons and type blocked',
        (widgetTester) async {
          var titlePrimary = 'Button Primary';
          var titleSecondary = 'Button Tertiary';

          await widgetTester.pumpWidget(
            Wrapper(
              child: ExpenseButtonGroup(
                buttonPrimary: ExpenseButton(
                  label: titlePrimary,
                  onPressed: () => debugPrint(''),
                ),
                buttonTertiary: ExpenseButtonMini(
                  label: titleSecondary,
                  onPressed: () => debugPrint(''),
                ),
                type: ExpenseButtonGrouType.blocked,
              ),
            ),
          );

          // render button primary
          var widgetPrimary = find.text(titlePrimary);
          expect(widgetPrimary, findsOneWidget);

          // render button secondary
          var widgetSecondary = find.text(titleSecondary);
          expect(widgetSecondary, findsOneWidget);
        },
      );
    },
  );
}
