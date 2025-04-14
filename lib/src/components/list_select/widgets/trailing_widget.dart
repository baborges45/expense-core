import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

import 'package:provider/provider.dart';

import 'package:expense_core/core.dart';

class TrailingWidget<T> extends StatelessWidget {
  final ExpenseListSelectType type;
  final ValueChanged<T?> onChanged;
  final T? value;
  final bool disabled;
  final T? groupValue;
  final String? semanticsTrailling;
  const TrailingWidget({
    super.key,
    required this.type,
    required this.onChanged,
    required this.value,
    required this.disabled,
    required this.groupValue,
    this.semanticsTrailling,
  });

  @override
  Widget build(BuildContext context) {
    var globalTokens = Provider.of<ExpenseThemeManager>(context).globals;

    onChangeValue(T? v) {
      onChanged(v);

      if (v is bool) {
        switch (type) {
          case ExpenseListSelectType.checkbox:
            String message = v ? 'Selecionado' : 'Não selecionado';
            SemanticsService.announce(message, TextDirection.ltr);
            break;
          case ExpenseListSelectType.radiobutton:
            String message = v ? 'Selecionado' : 'Não selecionado';
            SemanticsService.announce(message, TextDirection.ltr);
            break;
          case ExpenseListSelectType.switcher:
            String message = v ? 'Ativado' : 'Desativado';
            SemanticsService.announce(message, TextDirection.ltr);
            break;
        }
      }
    }

    Widget getWidgetType() {
      switch (type) {
        case ExpenseListSelectType.checkbox:
          return ExpenseCheckbox(
            value: value != null ? value as bool : null,
            onChanged: (v) => onChangeValue(v as T),
            disabled: disabled,
            semanticsLabel: semanticsTrailling,
          );
        case ExpenseListSelectType.switcher:
          return ExpenseSwitch(
            value: value != null ? value as bool : false,
            onChanged: (v) => onChangeValue(v as T),
            disabled: disabled,
            semanticsLabel: semanticsTrailling,
          );
        case ExpenseListSelectType.radiobutton:
          return ExpenseRadioButton<T>(
            value: value as T,
            groupValue: groupValue,
            onChanged: onChanged,
            disabled: disabled,
            semanticsLabel: semanticsTrailling,
          );
      }
    }

    return Row(
      children: [
        SizedBox(width: globalTokens.shapes.spacing.s2x),
        getWidgetType(),
      ],
    );
  }
}
