import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:expense_core/core.dart';

import '../../../wrapper.dart';

void main() {
  group(
    'Bottom Bar Float',
    () {
      testWidgets(
        'Should render bottom bar float',
        (widgetTester) async {
          final key = UniqueKey();
          List<ExpenseBottomBarFloatItem> list = [
            ExpenseBottomBarFloatItem(
              label: 'Item 01',
              icon: ExpenseIcons.placeholderLine,
            ),
            ExpenseBottomBarFloatItem(
              label: 'Item 02',
              icon: ExpenseIcons.placeholderLine,
            ),
            ExpenseBottomBarFloatItem(
              label: 'Item 03',
              icon: ExpenseIcons.placeholderLine,
            ),
          ];

          await widgetTester.pumpWidget(
            Wrapper(
              child: ExpenseBottomBarFloat(
                key: key,
                items: list,
                onChanged: (index) => debugPrint('$index'),
                currentIndex: 0,
              ),
            ),
          );

          expect(find.byKey(key), findsOneWidget);
        },
      );

      testWidgets(
        'Should change item selected',
        (widgetTester) async {
          final key = UniqueKey();
          int itemSelected = 0;
          List<ExpenseBottomBarFloatItem> list = [
            ExpenseBottomBarFloatItem(
              label: 'Item 01',
              icon: ExpenseIcons.placeholderLine,
            ),
            ExpenseBottomBarFloatItem(
              label: 'Item 02',
              icon: ExpenseIcons.placeholderLine,
            ),
            ExpenseBottomBarFloatItem(
              label: 'Item 03',
              icon: ExpenseIcons.placeholderLine,
            ),
          ];

          await widgetTester.pumpWidget(
            Wrapper(
              child: ExpenseBottomBarFloat(
                key: key,
                currentIndex: itemSelected,
                onChanged: (index) => itemSelected = index,
                items: list,
              ),
            ),
          );

          await widgetTester.tap(find.text('Item 03'));
          expect(itemSelected, 2);
        },
      );
    },
  );

  group('Bottom Bar Float Accessibility', () {
    testWidgets(
      'Should verify accessibility',
      (widgetTester) async {
        final SemanticsHandle handle = widgetTester.ensureSemantics();

        await widgetTester.pumpWidget(
          Wrapper(
            child: ExpenseBottomBarFloat(
              currentIndex: 0,
              onChanged: (index) => debugPrint('$index'),
              items: [
                ExpenseBottomBarFloatItem(
                  label: 'Item 01',
                  icon: ExpenseIcons.placeholderLine,
                  semanticsLabel: 'Item 01',
                ),
              ],
            ),
          ),
        );

        // Checks that tappable nodes have a minimum size of 48 by 48 pixels
        // for Android.
        await expectLater(
          widgetTester,
          meetsGuideline(androidTapTargetGuideline),
        );

        // // Checks that tappable nodes have a minimum size of 44 by 44 pixels
        // // for iOS.
        await expectLater(
          widgetTester,
          meetsGuideline(iOSTapTargetGuideline),
        );

        // // Checks that touch targets with a tap or long press action are labeled.
        await expectLater(
          widgetTester,
          meetsGuideline(labeledTapTargetGuideline),
        );

        // // Checks whether semantic nodes meet the minimum text contrast levels.
        // // The recommended text contrast is 3:1 for larger text
        // // (18 point and above regular).
        await expectLater(
          widgetTester,
          meetsGuideline(textContrastGuideline),
        );

        handle.dispose();
      },
    );
  });
}
