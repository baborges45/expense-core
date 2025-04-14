import 'package:expense_core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../wrapper.dart';

void main() {
  group(
    'Paragraph',
    () {
      testWidgets(
        'Should render paragraph',
        (widgetTester) async {
          final key = UniqueKey();
          const text = 'Paragraph';

          await widgetTester.pumpWidget(
            Wrapper(
              child: ExpenseParagraph(
                key: key,
                text,
              ),
            ),
          );

          expect(find.byKey(key), findsOneWidget);
        },
      );

      testWidgets(
        'Should  paragraph size sm',
        (widgetTester) async {
          final key = UniqueKey();
          ExpenseThemeManager? tokens;

          const text = 'Paragraph';

          await widgetTester.pumpWidget(
            Wrapper(
              onTokens: (t) => tokens = t,
              child: ExpenseParagraph(
                key: key,
                text,
                size: ExpenseParagraphSize.sm,
              ),
            ),
          );

          final widget = widgetTester.widget<Text>(find.byType(Text));
          final style = widget.style as TextStyle;

          expect(style.fontSize, tokens!.globals.typographys.fontSize2xs);
        },
      );

      testWidgets(
        'Should  paragraph inverse',
        (widgetTester) async {
          final key = UniqueKey();
          ExpenseThemeManager? tokens;

          const text = 'Paragraph';

          await widgetTester.pumpWidget(
            Wrapper(
              onTokens: (t) => tokens = t,
              child: ExpenseParagraph(
                key: key,
                text,
                size: ExpenseParagraphSize.sm,
                inverse: true,
              ),
            ),
          );

          final widget = widgetTester.widget<Text>(find.byType(Text));
          final style = widget.style as TextStyle;

          expect(style.color, tokens!.alias.color.inverse.paragraphColor);
        },
      );
    },
  );

  group('Paragraph Accessibility', () {
    testWidgets(
      'Should verify accessibility',
      (widgetTester) async {
        final SemanticsHandle handle = widgetTester.ensureSemantics();

        await widgetTester.pumpWidget(
          const Wrapper(
            child: ExpenseParagraph(
              'Paragraph',
              semanticsHint: 'Paragraph',
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
