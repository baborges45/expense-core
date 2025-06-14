import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:expense_core/core.dart';
import 'package:provider/provider.dart';

import '../input_formatters/text_cellphone.dart';
import '../input_formatters/text_cep.dart';
import '../input_formatters/text_cnpj.dart';
import '../input_formatters/text_cpf.dart';
import 'input_error_icon.dart';

class InputWidget extends StatelessWidget {
  // Layout Control
  final Color textColor;
  final Color? iconColor;
  final bool disabled;
  final bool hasError;

  // Input Control
  final TextEditingController controller;
  final FocusNode focusNode;
  final TextInputType? keyboardType;
  final bool readOnly;
  final bool autofocus;
  final bool autocorrect;
  final int? maxLength;

  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onSubmitted;
  final String? placeholder;
  final TextInputAction? textInputAction;
  final Widget? label;
  final TextStyle? labelStyle;
  final ExpenseInputTextType type;

  const InputWidget({
    super.key,
    required this.textColor,
    required this.placeholder,
    required this.disabled,
    required this.hasError,
    this.iconColor,

    // Input
    required this.controller,
    required this.focusNode,
    required this.readOnly,
    required this.autofocus,
    required this.autocorrect,
    this.maxLength,
    this.keyboardType,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.textInputAction,
    this.label,
    this.labelStyle,
    this.type = ExpenseInputTextType.text,
  });

  @override
  Widget build(BuildContext context) {
    var aliasTokens = Provider.of<ExpenseThemeManager>(context).alias;
    var placeholderStyle = aliasTokens.mixin.placeholder.merge(
      TextStyle(color: textColor),
    );

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

    final List<TextInputFormatter>? inputFormatters = inputFormatterMap[type] ?? inputFormatterMap[ExpenseInputTextType.text];

    getKeyboardType() {
      if (keyboardType != null) return keyboardType;

      return type == ExpenseInputTextType.text ? TextInputType.text : TextInputType.number;
    }

    return Row(
      children: [
        Expanded(
          child: TextField(
            //
            // Controls Layout
            cursorColor: textColor,
            style: placeholderStyle,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: placeholder,
              hintStyle: placeholderStyle,
              label: label,
              labelStyle: labelStyle,
              contentPadding: const EdgeInsets.only(top: 4, bottom: 4),
            ),

            // Controls Input
            controller: controller,
            inputFormatters: inputFormatters,
            focusNode: focusNode,
            readOnly: readOnly,
            autofocus: autofocus,
            autocorrect: autocorrect,
            keyboardType: getKeyboardType(),
            onChanged: onChanged,
            onEditingComplete: onEditingComplete,
            onSubmitted: onSubmitted,
            enabled: !disabled,
            textInputAction: textInputAction,
            maxLength: maxLength,
          ),
        ),

        // Icon Error
        ExcludeSemantics(
          child: InputErrorIcon(
            show: hasError && !disabled,
            iconColor: iconColor,
          ),
        ),
      ],
    );
  }
}
