import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:expense_core/core.dart';

import '../mixins/properties_mixin.dart';

class InputWidget extends StatelessWidget with PropertiesMixin {
  final bool isFocussed;
  final bool isFilled;

  final VoidCallback onClear;
  final bool noElements;

  final TextEditingController controller;
  final FocusNode focusNode;
  final TextInputType? keyboardType;
  final bool readOnly;
  final bool autofocus;
  final bool autocorrect;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onSubmitted;
  final bool? enabled;
  final String? placeholder;
  final TextInputAction? textInputAction;
  final String? semanticsLabel;
  final String? semanticsHint;

  const InputWidget({
    super.key,

    // Controle layout
    required this.isFocussed,
    required this.isFilled,
    this.noElements = false,

    // Input
    required this.controller,
    required this.focusNode,
    required this.onClear,
    required this.readOnly,
    required this.autofocus,
    required this.autocorrect,
    this.keyboardType,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.enabled,
    this.placeholder,
    this.textInputAction,
    this.semanticsLabel,
    this.semanticsHint,
  });

  @override
  Widget build(BuildContext context) {
    var tokens = Provider.of<ExpenseThemeManager>(context);
    var globalTokens = tokens.globals;
    var aliasTokens = tokens.alias;

    Color backgroundColor = getPlaceholderColor(isFocussed, context);

    return Row(
      children: [
        Expanded(
          child: Semantics(
            textField: true,
            enabled: enabled,
            label: semanticsLabel,
            hint: semanticsHint,
            child: TextField(
              cursorColor: backgroundColor,

              // Controls Input
              controller: controller,
              focusNode: focusNode,
              readOnly: readOnly,
              autofocus: autofocus,
              autocorrect: autocorrect,
              keyboardType: keyboardType,
              onChanged: onChanged,
              onEditingComplete: onEditingComplete,
              onSubmitted: onSubmitted,
              enabled: enabled,
              textInputAction: textInputAction,

              style: TextStyle(
                color: aliasTokens.color.active.placeholderColor,
                fontFamily: globalTokens.typographys.fontFamilyBase,
              ),
              decoration: InputDecoration(
                hintText: getPlaceholderText(
                  placeholder: placeholder ?? '',
                  isFocussed: isFocussed,
                  noPlaceholderText: noElements,
                ),
                hintStyle: TextStyle(color: backgroundColor),
                border: InputBorder.none,
              ),
            ),
          ),
        ),
        SizedBox(
          height: globalTokens.shapes.size.s8x,
          child: Center(
            child: getSuffix(
              isFocussed: isFocussed,
              isFilled: isFilled,
              controller: controller,
              onClear: onClear,
              noIconSearch: isFilled,
              context: context,
            ),
          ),
        ),
      ],
    );
  }
}
