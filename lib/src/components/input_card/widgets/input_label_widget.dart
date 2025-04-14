import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:expense_core/core.dart';

class InputLabelWidget extends StatelessWidget {
  final String text;
  final bool disabled;
  final bool hasError;

  const InputLabelWidget({
    super.key,
    required this.text,
    required this.disabled,
    required this.hasError,
  });

  @override
  Widget build(BuildContext context) {
    var tokens = Provider.of<ExpenseThemeManager>(context);
    var globalTokens = tokens.globals;
    var aliasTokens = tokens.alias;

    Color getTextColor() {
      if (disabled) {
        return aliasTokens.color.disabled.labelColor;
      }

      return hasError ? aliasTokens.color.negative.labelColor : aliasTokens.color.text.labelColor;
    }

    return Column(
      children: [
        Text(
          text,
          style: aliasTokens.mixin.labelMd2.merge(
            TextStyle(color: getTextColor()),
          ),
        ),
        SizedBox(height: globalTokens.shapes.spacing.s1x),
      ],
    );
  }
}
