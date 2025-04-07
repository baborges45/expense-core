import 'package:flutter_test/flutter_test.dart';
import 'package:mude_core/core.dart';
import 'package:mude_core/src/components/input_card/input_formatters/card_flags.dart';

void main() {
  group(
    'Input Card Outline',
    () {
      test(
        'Should Flag credit card is visa',
        () {
          MudeFlagData? flag = CardFlags.getCardFlag('4675 1947 1431 0510');
          expect(flag!.name, MudeFlags.visa.name);
        },
      );

      test(
        'Should Flag credit card is master card',
        () {
          MudeFlagData? flag = CardFlags.getCardFlag('5185 9228 2203 9690');
          expect(flag!.name, MudeFlags.masterCard.name);
        },
      );

      test(
        'Should Flag credit card is elo',
        () {
          MudeFlagData? flag = CardFlags.getCardFlag('6363 6876 1461 1798');
          expect(flag!.name, MudeFlags.elo.name);
        },
      );
    },
  );
}
