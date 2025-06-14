import 'package:expense_core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../wrapper.dart';

void main() {
  group(
    'Description',
    () {
      testWidgets(
        'Should render description',
        (widgetTester) async {
          const text = 'Description';

          await widgetTester.pumpWidget(
            const Wrapper(
              child: ExpenseDescription(text),
            ),
          );

          expect(find.text(text), findsOneWidget);
        },
      );

      testWidgets(
        'Should description another color',
        (widgetTester) async {
          const text = 'Description';

          await widgetTester.pumpWidget(
            const Wrapper(
              child: ExpenseDescription(
                text,
                color: Colors.red,
              ),
            ),
          );

          final widget = widgetTester.widget<Text>(find.text(text));
          final style = widget.style as TextStyle;

          expect(style.color, Colors.red);
        },
      );

      testWidgets(
        'Should description text align center',
        (widgetTester) async {
          const text = 'Description';

          await widgetTester.pumpWidget(
            const Wrapper(
              child: ExpenseDescription(
                text,
                align: TextAlign.center,
              ),
            ),
          );

          final widget = widgetTester.widget<Text>(find.text(text));

          expect(widget.textAlign, TextAlign.center);
        },
      );

      testWidgets(
        'Should description inverse',
        (widgetTester) async {
          const text = 'Description';
          ExpenseThemeManager? tokens;

          await widgetTester.pumpWidget(
            Wrapper(
              onTokens: (t) => tokens = t,
              child: const ExpenseDescription(
                text,
                inverse: true,
              ),
            ),
          );

          final widget = widgetTester.widget<Text>(find.text(text));
          final style = widget.style as TextStyle;

          expect(style.color, tokens!.alias.color.inverse.descriptionColor);
        },
      );
    },
  );
}
