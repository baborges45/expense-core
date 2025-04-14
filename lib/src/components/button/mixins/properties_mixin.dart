import 'package:flutter/material.dart';
import 'package:expense_core/core.dart';
import 'package:provider/provider.dart';

mixin PropertiesMixin {
  Color getTextColor({
    required disabled,
    required inverse,
    required negative,
    required BuildContext context,
  }) {
    var tokens = Provider.of<ExpenseThemeManager>(context);
    var aliasTokens = tokens.alias;

    if (inverse) {
      return aliasTokens.color.inverse.onLabelColor;
    }

    if (disabled) {
      return aliasTokens.color.disabled.onLabelColor;
    }

    if (negative) {
      return aliasTokens.color.negative.onLabelColor;
    }

    return aliasTokens.color.action.onLabelPrimaryColor;
  }

  Color getBackgroundColor({
    required disabled,
    required inverse,
    required negative,
    required BuildContext context,
  }) {
    var tokens = Provider.of<ExpenseThemeManager>(context);
    var aliasTokens = tokens.alias;

    if (inverse) {
      return aliasTokens.color.inverse.bgColor;
    }

    if (disabled) {
      return aliasTokens.color.disabled.bgColor;
    }

    if (negative) {
      return aliasTokens.color.negative.borderColor;
    }

    return aliasTokens.color.action.bgPrimaryColor;
  }

  double getOpacity({
    required disabled,
    required isPressed,
    required BuildContext context,
  }) {
    var tokens = Provider.of<ExpenseThemeManager>(context);
    var aliasTokens = tokens.alias;

    if (disabled) return aliasTokens.color.disabled.opacity;
    if (isPressed) return aliasTokens.color.pressed.containerOpacity;

    return 1;
  }
}
