import 'package:expense_core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../wrapper.dart';

void main() {
  group(
    'Button fixed Accessibility',
    () {
      testWidgets(
        'Should verify accessibility',
        (widgetTester) async {
          final SemanticsHandle handle = widgetTester.ensureSemantics();

          await widgetTester.pumpWidget(
            Wrapper(
              child: ExpenseButtonFixed(
                button: ExpenseButton(
                  label: 'label',
                  onPressed: () => debugPrint(''),
                ),
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
    'Button Fixed',
    () {
      testWidgets(
        'Should render button with label',
        (widgetTester) async {
          const label = 'Button';

          await widgetTester.pumpWidget(
            Wrapper(
              child: ExpenseButtonFixed(
                button: ExpenseButton(
                  label: label,
                  onPressed: () => debugPrint(''),
                ),
              ),
            ),
          );

          final widget = find.text(label);
          expect(widget, findsOneWidget);
        },
      );
    },
  );
}
