import 'package:flutter_test/flutter_test.dart';
import 'package:expense_core/core.dart';
import 'package:expense_core/src/components/input_card/input_formatters/card_flags.dart';

void main() {
  group(
    'Input Card Outline',
    () {
      test(
        'Should Flag credit card is visa',
        () {
          ExpenseFlagData? flag = CardFlags.getCardFlag('4675 1947 1431 0510');
          expect(flag!.name, ExpenseFlags.visa.name);
        },
      );

      test(
        'Should Flag credit card is master card',
        () {
          ExpenseFlagData? flag = CardFlags.getCardFlag('5185 9228 2203 9690');
          expect(flag!.name, ExpenseFlags.masterCard.name);
        },
      );

      test(
        'Should Flag credit card is elo',
        () {
          ExpenseFlagData? flag = CardFlags.getCardFlag('6363 6876 1461 1798');
          expect(flag!.name, ExpenseFlags.elo.name);
        },
      );
    },
  );
}
