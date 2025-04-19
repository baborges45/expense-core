import 'package:expense_core/core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Label extends StatelessWidget {
  final String label;
  final bool disabled;
  final bool hasError;

  const Label({
    super.key,
    required this.label,
    required this.disabled,
    required this.hasError,
  });

  @override
  Widget build(BuildContext context) {
    final tokens = Provider.of<ExpenseThemeManager>(context);
    final aliasTokens = tokens.alias;

    Color getTextColor() {
      if (disabled) {
        return aliasTokens.color.disabled.labelColor;
      }

      if (hasError) {
        return aliasTokens.color.negative.labelColor;
      }

      return aliasTokens.color.text.labelColor;
    }

    return Text(
      label,
      style: aliasTokens.mixin.labelMd2.apply(
        color: getTextColor(),
      ),
    );
  }
}
