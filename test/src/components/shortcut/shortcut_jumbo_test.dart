import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:expense_core/core.dart';

import '../../../wrapper.dart';

void main() {
  group(
    'Shortcut',
    () {
      testWidgets(
        'Should render shortcut with icon',
        (widgetTester) async {
          const text = 'Text';

          await widgetTester.pumpWidget(
            Wrapper(
              child: ExpenseShortcutJumbo(
                label: text,
                description: text,
                icon: ExpenseIcons.placeholderLine,
                onPressed: () => debugPrint(''),
              ),
            ),
          );

          expect(find.byType(ExpenseIcon), findsOneWidget);
        },
      );

      testWidgets(
        'Should shortcut tap',
        (widgetTester) async {
          final key = UniqueKey();
          const text = 'Text';
          bool press = false;

          await widgetTester.pumpWidget(
            Wrapper(
              child: ExpenseShortcutJumbo(
                key: key,
                label: text,
                description: text,
                icon: ExpenseIcons.placeholderLine,
                onPressed: () => press = true,
              ),
            ),
          );

          await widgetTester.tap(find.byKey(key));

          expect(press, isTrue);
        },
      );

      testWidgets(
        'Should shortcut type icon disabled',
        (widgetTester) async {
          final key = UniqueKey();
          const text = 'Text';

          ExpenseThemeManager? tokens;

          await widgetTester.pumpWidget(
            Wrapper(
              onTokens: (t) => tokens = t,
              child: ExpenseShortcutJumbo(
                key: key,
                label: text,
                description: text,
                icon: ExpenseIcons.placeholderLine,
                disabled: true,
                onPressed: () => debugPrint(''),
              ),
            ),
          );

          final icon = widgetTester.widget<ExpenseIcon>(find.byType(ExpenseIcon));
          expect(icon.color, tokens!.alias.color.disabled.onIconColor);
        },
      );
    },
  );

  group('Shortcut Accessibility', () {
    testWidgets(
      'Should verify accessibility',
      (widgetTester) async {
        final SemanticsHandle handle = widgetTester.ensureSemantics();
        const text = 'Text';

        await widgetTester.pumpWidget(
          Wrapper(
            child: ExpenseShortcutJumbo(
              label: text,
              description: text,
              icon: ExpenseIcons.placeholderLine,
              onPressed: () => debugPrint(''),
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
