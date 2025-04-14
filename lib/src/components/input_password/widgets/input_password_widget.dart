import 'package:flutter/material.dart';
import 'package:expense_core/core.dart';
import 'package:provider/provider.dart';

import 'input_password_error_icon.dart';

class InputPasswordWidget extends StatelessWidget {
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
  final bool obscureText;
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

  const InputPasswordWidget({
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
    required this.obscureText,
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
  });

  @override
  Widget build(BuildContext context) {
    var aliasTokens = Provider.of<ExpenseThemeManager>(context).alias;
    var placeholderStyle = aliasTokens.mixin.placeholder.merge(
      TextStyle(color: textColor),
    );

    return Row(
      children: [
        Expanded(
          child: TextField(
            // Controls Layout
            cursorColor: textColor,
            style: placeholderStyle,
            maxLength: maxLength,
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
            focusNode: focusNode,
            obscureText: obscureText,
            readOnly: readOnly,
            autofocus: autofocus,
            autocorrect: autocorrect,
            keyboardType: keyboardType,
            onChanged: onChanged,
            onEditingComplete: onEditingComplete,
            onSubmitted: onSubmitted,
            enabled: !disabled,
            textInputAction: textInputAction,
          ),
        ),

        // Icon Error
        InputPasswordErrorIcon(
          show: hasError && !disabled,
          iconColor: iconColor,
        ),
      ],
    );
  }
}
