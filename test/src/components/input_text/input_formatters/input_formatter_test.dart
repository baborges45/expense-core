import 'package:mude_core/src/components/input_text/input_formatters/text_cellphone.dart';
import 'package:mude_core/src/components/input_text/input_formatters/text_cep.dart';
import 'package:mude_core/src/components/input_text/input_formatters/text_cnpj.dart';
import 'package:mude_core/src/components/input_text/input_formatters/text_cpf.dart';
import 'package:mude_core/src/components/input_text/types/type.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../wrapper.dart';

void main() {
  final Map<MudeInputTextType, List<TextInputFormatter>> inputFormatterMap = {
    MudeInputTextType.cellphone: [
      FilteringTextInputFormatter.digitsOnly,
      CellphoneInputFormatter(),
    ],
    MudeInputTextType.cep: [
      FilteringTextInputFormatter.digitsOnly,
      CEPInputFormatter(),
    ],
    MudeInputTextType.cnpj: [
      FilteringTextInputFormatter.digitsOnly,
      CNPJInputFormatter(),
    ],
    MudeInputTextType.cpf: [
      FilteringTextInputFormatter.digitsOnly,
      CPFInputFormatter(),
    ],
    MudeInputTextType.text: [],
  };

  group(
    'Input Formatter',
    () {
      testWidgets(
        'Should be able to render a input formatter for cellphone',
        (widgetTester) async {
          await widgetTester.pumpWidget(
            Wrapper(
              child: TextField(
                inputFormatters: inputFormatterMap[MudeInputTextType.cellphone],
              ),
            ),
          );
          await widgetTester.enterText(
            find.byType(TextField),
            '11999999999a',
          );

          await widgetTester.pumpAndSettle();
          expect(find.text('(11) 99999-9999'), findsOneWidget);
        },
      );

      testWidgets(
        'Should be able to render a input formatter for cpf',
        (widgetTester) async {
          await widgetTester.pumpWidget(
            Wrapper(
              child: TextField(
                inputFormatters: inputFormatterMap[MudeInputTextType.cpf],
              ),
            ),
          );
          await widgetTester.enterText(
            find.byType(TextField),
            '12864211955a',
          );

          await widgetTester.pumpAndSettle();
          expect(find.text('128.642.119-55'), findsOneWidget);
        },
      );

      testWidgets(
        'Should be able to render a input formatter for cep',
        (widgetTester) async {
          await widgetTester.pumpWidget(
            Wrapper(
              child: TextField(
                inputFormatters: inputFormatterMap[MudeInputTextType.cep],
              ),
            ),
          );
          await widgetTester.enterText(
            find.byType(TextField),
            '88058750',
          );

          await widgetTester.pumpAndSettle();
          expect(find.text('88.058-750'), findsOneWidget);
        },
      );

      testWidgets(
        'Should be able to render a input formatter for cep',
        (widgetTester) async {
          await widgetTester.pumpWidget(
            Wrapper(
              child: TextField(
                inputFormatters: inputFormatterMap[MudeInputTextType.cnpj],
              ),
            ),
          );
          await widgetTester.enterText(
            find.byType(TextField),
            '99999999999999',
          );

          await widgetTester.pumpAndSettle();
          expect(find.text('99.999.999/9999-99'), findsOneWidget);
        },
      );
    },
  );
}
