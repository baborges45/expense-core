import 'package:expense_core/src/components/input_text/input_formatters/text_cellphone.dart';
import 'package:expense_core/src/components/input_text/input_formatters/text_cep.dart';
import 'package:expense_core/src/components/input_text/input_formatters/text_cnpj.dart';
import 'package:expense_core/src/components/input_text/input_formatters/text_cpf.dart';
import 'package:expense_core/src/components/input_text/types/type.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../wrapper.dart';

void main() {
  final Map<ExpenseInputTextType, List<TextInputFormatter>> inputFormatterMap = {
    ExpenseInputTextType.cellphone: [
      FilteringTextInputFormatter.digitsOnly,
      CellphoneInputFormatter(),
    ],
    ExpenseInputTextType.cep: [
      FilteringTextInputFormatter.digitsOnly,
      CEPInputFormatter(),
    ],
    ExpenseInputTextType.cnpj: [
      FilteringTextInputFormatter.digitsOnly,
      CNPJInputFormatter(),
    ],
    ExpenseInputTextType.cpf: [
      FilteringTextInputFormatter.digitsOnly,
      CPFInputFormatter(),
    ],
    ExpenseInputTextType.text: [],
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
                inputFormatters: inputFormatterMap[ExpenseInputTextType.cellphone],
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
                inputFormatters: inputFormatterMap[ExpenseInputTextType.cpf],
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
                inputFormatters: inputFormatterMap[ExpenseInputTextType.cep],
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
                inputFormatters: inputFormatterMap[ExpenseInputTextType.cnpj],
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
