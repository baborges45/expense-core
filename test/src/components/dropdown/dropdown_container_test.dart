import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:expense_core/core.dart';

import '../../../wrapper.dart';

void main() {
  group(
    'Dropdown Container',
    () {
      testWidgets(
        'Should render dropdown',
        (widgetTester) async {
          final key = UniqueKey();

          List<ExpenseDropdownItem> list = [
            const ExpenseDropdownItem('1', 'Item 01'),
            const ExpenseDropdownItem('2', 'Item 02'),
            const ExpenseDropdownItem('3', 'Item 03'),
          ];

          await widgetTester.pumpWidget(
            Wrapper(
              child: ExpenseDropDownContainer(
                key: key,
                items: list,
                onChanged: (item) => debugPrint(''),
              ),
            ),
          );

          expect(find.byKey(key), findsOneWidget);
        },
      );

      testWidgets(
        'Should dropdown tap',
        (widgetTester) async {
          final key = UniqueKey();
          ExpenseDropdownItem? itemSelected;
          List<ExpenseDropdownItem> list = [
            const ExpenseDropdownItem('1', 'Item 01'),
            const ExpenseDropdownItem('2', 'Item 02'),
            const ExpenseDropdownItem('3', 'Item 03'),
          ];

          await widgetTester.pumpWidget(
            Wrapper(
              child: ExpenseDropDownContainer(
                key: key,
                items: list,
                onChanged: (item) {
                  itemSelected = item;
                },
              ),
            ),
          );

          await widgetTester.tap(find.byKey(key));
          await widgetTester.pumpAndSettle();

          final scroll = find.byKey(const Key('dropdown.scroll-items'));

          final widgets = find.descendant(
            of: scroll,
            matching: find.byType(GestureDetector),
          );

          await widgetTester.tap(widgets.first);
          await widgetTester.pumpAndSettle();
          await widgetTester.pump(const Duration(seconds: 1));

          expect(itemSelected, isNotNull);
        },
      );

      testWidgets(
        'Should tapcancel dropdown',
        (widgetTester) async {
          final key = UniqueKey();
          List<ExpenseDropdownItem> list = [
            const ExpenseDropdownItem('1', 'Item 01'),
            const ExpenseDropdownItem('2', 'Item 02'),
            const ExpenseDropdownItem('3', 'Item 03'),
          ];

          await widgetTester.pumpWidget(
            Wrapper(
              child: ExpenseDropDownContainer(
                key: key,
                items: list,
                onChanged: (item) {},
              ),
            ),
          );

          await widgetTester.timedDrag(
            find.byKey(key),
            const Offset(500, 100),
            const Duration(milliseconds: 100),
          );
          await widgetTester.pumpAndSettle();

          expect(find.byKey(const Key('dropdown.scroll-items')), findsNothing);
        },
      );
    },
  );

  group('Dropdown Container Accessibility', () {
    testWidgets(
      'Should verify accessibility',
      (widgetTester) async {
        final SemanticsHandle handle = widgetTester.ensureSemantics();

        List<ExpenseDropdownItem> list = [
          const ExpenseDropdownItem('1', 'Item 01'),
          const ExpenseDropdownItem('2', 'Item 02'),
          const ExpenseDropdownItem('3', 'Item 03'),
        ];

        await widgetTester.pumpWidget(
          Wrapper(
            child: ExpenseDropDownContainer(
              items: list,
              onChanged: (item) => debugPrint(''),
              semanticsLabel: 'Dropdown Container',
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
