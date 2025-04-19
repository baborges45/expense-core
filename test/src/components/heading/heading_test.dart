import 'package:expense_core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../wrapper.dart';

void main() {
  group(
    'Heading',
    () {
      testWidgets(
        'Should render heading',
        (widgetTester) async {
          final key = UniqueKey();
          const text = 'Heading';

          await widgetTester.pumpWidget(
            Wrapper(
              child: ExpenseHeading(
                key: key,
                text,
              ),
            ),
          );

          expect(find.byKey(key), findsOneWidget);
        },
      );

      testWidgets(
        'Should heading sizes',
        (widgetTester) async {
          final key = UniqueKey();
          ExpenseThemeManager? tokens;
          const text = 'Heading';

          for (var size in ExpenseHeadingSize.values) {
            await widgetTester.pumpWidget(
              Wrapper(
                onTokens: (t) => tokens = t,
                child: ExpenseHeading(
                  key: key,
                  text,
                  size: size,
                ),
              ),
            );

            final widget = widgetTester.widget<Text>(find.byType(Text));
            final style = widget.style as TextStyle;

            switch (size) {
              case ExpenseHeadingSize.xl:
                expect(style.fontSize, tokens!.globals.typographys.fontSizeXl);
                break;
              case ExpenseHeadingSize.lg:
                expect(style.fontSize, tokens!.globals.typographys.fontSizeLg);
                break;
              case ExpenseHeadingSize.md:
                expect(style.fontSize, tokens!.globals.typographys.fontSizeMd);
                break;
              case ExpenseHeadingSize.sm:
                expect(style.fontSize, tokens!.globals.typographys.fontSizeSm);
                break;
              case ExpenseHeadingSize.xs:
                expect(style.fontSize, tokens!.globals.typographys.fontSizeXs);
                break;
            }
          }
        },
      );

      testWidgets(
        'Should heading inverse',
        (widgetTester) async {
          final key = UniqueKey();
          ExpenseThemeManager? tokens;
          const text = 'Heading';

          await widgetTester.pumpWidget(
            Wrapper(
              onTokens: (t) => tokens = t,
              child: ExpenseHeading(
                key: key,
                text,
                inverse: true,
              ),
            ),
          );

          final widget = widgetTester.widget<Text>(find.byType(Text));
          final style = widget.style as TextStyle;

          expect(style.color, tokens!.alias.color.inverse.headingColor);
        },
      );
    },
  );
}
