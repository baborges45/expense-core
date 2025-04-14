import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:expense_core/core.dart';

import '../../../wrapper.dart';

void main() {
  group(
    'Currency',
    () {
      testWidgets(
        'Should render currency',
        (widgetTester) async {
          final key = UniqueKey();
          double price = 100.0;

          await widgetTester.pumpWidget(
            Wrapper(
              child: ExpenseCurrency(
                key: key,
                price: price,
              ),
            ),
          );

          expect(find.byKey(key), findsOneWidget);
        },
      );

      testWidgets(
        'Should currency income',
        (widgetTester) async {
          final key = UniqueKey();
          double price = 100.0;

          await widgetTester.pumpWidget(
            Wrapper(
              child: ExpenseCurrency(
                key: key,
                price: price,
                type: ExpenseCurrencyType.income,
              ),
            ),
          );

          expect(find.byKey(key), findsOneWidget);
          expect(find.byType(ExpenseIcon), findsOneWidget);
        },
      );

      testWidgets(
        'Should currency outcome',
        (widgetTester) async {
          final key = UniqueKey();
          double price = 100.0;

          await widgetTester.pumpWidget(
            Wrapper(
              child: ExpenseCurrency(
                key: key,
                price: price,
                type: ExpenseCurrencyType.outcome,
              ),
            ),
          );

          expect(find.byKey(key), findsOneWidget);
          expect(find.byType(ExpenseIcon), findsOneWidget);
        },
      );

      testWidgets(
        'Should currency size lg',
        (widgetTester) async {
          final key = UniqueKey();
          double price = 100.0;

          await widgetTester.pumpWidget(
            Wrapper(
              child: ExpenseCurrency(
                key: key,
                price: price,
                type: ExpenseCurrencyType.outcome,
                size: ExpenseCurrencySize.lg,
              ),
            ),
          );

          final icon = widgetTester.widget<ExpenseIcon>(find.byType(ExpenseIcon));
          expect(icon.size, ExpenseIconSize.lg);
        },
      );

      testWidgets(
        'Should currency sale',
        (widgetTester) async {
          final key = UniqueKey();
          double price = 100.0;
          double priceOut = 200.0;

          await widgetTester.pumpWidget(
            Wrapper(
              child: ExpenseCurrency(
                key: key,
                price: price,
                priceOut: priceOut,
                type: ExpenseCurrencyType.sale,
              ),
            ),
          );

          expect(find.byKey(key), findsOneWidget);
        },
      );
    },
  );

  group('Currency / Widget / Hide dot', () {
    testWidgets(
      'Should currency hide',
      (widgetTester) async {
        final key = UniqueKey();
        double price = 100.0;

        await widgetTester.pumpWidget(
          Wrapper(
            child: ExpenseCurrency(
              key: key,
              price: price,
              type: ExpenseCurrencyType.outcome,
              size: ExpenseCurrencySize.lg,
              hide: true,
            ),
          ),
        );

        final dots = find.byKey(const Key('currency-dot'));
        expect(dots, findsWidgets);
      },
    );
  });

  group(
    'Currency Accessibility',
    () {
      testWidgets(
        'Should verify accessibility',
        (widgetTester) async {
          final SemanticsHandle handle = widgetTester.ensureSemantics();

          await widgetTester.pumpWidget(
            const Wrapper(
              child: ExpenseCurrency(
                price: 111,
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
    },
  );
}
