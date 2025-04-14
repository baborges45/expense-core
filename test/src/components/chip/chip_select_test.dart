import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:expense_core/core.dart';

import '../../../wrapper.dart';

void main() {
  group(
    'Chip Select',
    () {
      testWidgets(
        'Should be render correctly',
        (widgetTester) async {
          final key = UniqueKey();

          await widgetTester.pumpWidget(
            Wrapper(
              child: ExpenseChipSelect(
                key: key,
                label: '',
                onPressed: (newValue) => {},
                isSelected: false,
              ),
            ),
          );
          expect(find.byKey(key), findsOneWidget);
        },
      );

      testWidgets(
        'Should be selected after press',
        (widgetTester) async {
          final key = UniqueKey();
          bool value = false;

          await widgetTester.pumpWidget(
            Wrapper(
              child: ExpenseChipSelect(
                key: key,
                label: '',
                onPressed: (newValue) => {
                  value = newValue,
                },
                isSelected: value,
              ),
            ),
          );
          await widgetTester.tap(find.byKey(key));
          expect(value, true);
        },
      );

      testWidgets(
        'Should have an icon',
        (widgetTester) async {
          final key = UniqueKey();

          await widgetTester.pumpWidget(
            Wrapper(
              child: ExpenseChipSelect(
                key: key,
                label: '',
                onPressed: (newValue) => {},
                icon: ExpenseIcons.backLine,
              ),
            ),
          );
          expect(find.byType(ExpenseIcon), findsOneWidget);
        },
      );

      testWidgets(
        'Should have an icon selected and inverse',
        (widgetTester) async {
          final key = UniqueKey();
          ExpenseThemeManager? tokens;

          await widgetTester.pumpWidget(
            Wrapper(
              onTokens: (t) => tokens = t,
              child: ExpenseChipSelect(
                key: key,
                label: '',
                isSelected: true,
                inverse: true,
                onPressed: (newValue) => {},
                icon: ExpenseIcons.backLine,
              ),
            ),
          );

          final icon = widgetTester.widget<ExpenseIcon>(
            find.byType(ExpenseIcon),
          );

          expect(icon.color, tokens!.alias.color.inverse.onIconColor);
        },
      );

      testWidgets(
        'Should have an icon selected',
        (widgetTester) async {
          final key = UniqueKey();
          ExpenseThemeManager? tokens;

          await widgetTester.pumpWidget(
            Wrapper(
              onTokens: (t) => tokens = t,
              child: ExpenseChipSelect(
                key: key,
                label: '',
                isSelected: true,
                onPressed: (newValue) => {},
                icon: ExpenseIcons.backLine,
              ),
            ),
          );

          final icon = widgetTester.widget<ExpenseIcon>(
            find.byType(ExpenseIcon),
          );

          expect(icon.color, tokens!.alias.color.selected.onIconColor);
        },
      );

      testWidgets(
        'Should have an icon inverse',
        (widgetTester) async {
          final key = UniqueKey();
          ExpenseThemeManager? tokens;

          await widgetTester.pumpWidget(
            Wrapper(
              onTokens: (t) => tokens = t,
              child: ExpenseChipSelect(
                key: key,
                label: '',
                inverse: true,
                onPressed: (newValue) => {},
                icon: ExpenseIcons.backLine,
              ),
            ),
          );

          final icon = widgetTester.widget<ExpenseIcon>(
            find.byType(ExpenseIcon),
          );

          expect(icon.color, tokens!.alias.color.inverse.iconColor);
        },
      );

      testWidgets(
        'Should be pressed',
        (widgetTester) async {
          final key = UniqueKey();
          ExpenseThemeManager? tokens;

          await widgetTester.pumpWidget(
            Wrapper(
              onTokens: (t) => tokens = t,
              child: ExpenseChipSelect(
                key: key,
                label: '',
                onPressed: (newValue) => {},
              ),
            ),
          );

          final widget = find.byKey(const Key('chip.background'));

          await widgetTester.press(widget);
          await widgetTester.pumpAndSettle();

          final container = widgetTester.widget<Container>(widget);
          final decoration = container.decoration as BoxDecoration;
          expect(decoration.color, tokens!.alias.mixin.pressedOutline);
        },
      );

      testWidgets(
        'Should be showing border',
        (widgetTester) async {
          final key = UniqueKey();
          ExpenseThemeManager? tokens;

          await widgetTester.pumpWidget(
            Wrapper(
              onTokens: (t) => tokens = t,
              child: ExpenseChipSelect(
                key: key,
                label: '',
                onPressed: (newValue) => {},
              ),
            ),
          );

          final widget = find.byKey(const Key('chip.background'));

          await widgetTester.press(widget);
          await widgetTester.pumpAndSettle();

          final container = widgetTester.widget<Container>(widget);
          final decoration = container.decoration as BoxDecoration;
          final border = decoration.border as Border;

          expect(border.bottom.color, tokens!.alias.color.elements.borderColor);
        },
      );
    },
  );

  group('Chip Select Accessibility', () {
    testWidgets(
      'Should verify accessibility',
      (widgetTester) async {
        final SemanticsHandle handle = widgetTester.ensureSemantics();

        await widgetTester.pumpWidget(
          Wrapper(
            child: ExpenseChipSelect(
              label: '',
              onPressed: (newValue) => {},
              isSelected: false,
              semanticsLabel: 'Chip Select',
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
