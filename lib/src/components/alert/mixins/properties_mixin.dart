import 'package:expense_core/core.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

mixin PropertiesMixin {
  Color getBackgroundColor({
    required BuildContext context,
    required ExpenseAlertType alertColor,
  }) {
    var tokens = Provider.of<ExpenseThemeManager>(context);
    var aliasTokens = tokens.alias;

    switch (alertColor) {
      case ExpenseAlertType.positive:
        return aliasTokens.color.positive.bgColor;

      case ExpenseAlertType.negative:
        return aliasTokens.color.negative.bgColor;

      case ExpenseAlertType.informative:
        return aliasTokens.color.informative.bgColor;

      case ExpenseAlertType.warning:
        return aliasTokens.color.warning.bgColor;

      case ExpenseAlertType.promote:
        return aliasTokens.color.promote.bgColor;
    }
  }

  Color getIconColor({
    required BuildContext context,
    required ExpenseAlertType alertColor,
  }) {
    var tokens = Provider.of<ExpenseThemeManager>(context);
    var aliasTokens = tokens.alias;

    switch (alertColor) {
      case ExpenseAlertType.positive:
        return aliasTokens.color.positive.onIconColor;

      case ExpenseAlertType.negative:
        return aliasTokens.color.negative.onIconColor;

      case ExpenseAlertType.informative:
        return aliasTokens.color.informative.onIconColor;

      case ExpenseAlertType.warning:
        return aliasTokens.color.warning.onIconColor;

      case ExpenseAlertType.promote:
        return aliasTokens.color.promote.onIconColor;
    }
  }

  Color getFontColor({
    required BuildContext context,
    required ExpenseAlertType alertColor,
  }) {
    var tokens = Provider.of<ExpenseThemeManager>(context);
    var aliasTokens = tokens.alias;

    switch (alertColor) {
      case ExpenseAlertType.positive:
        return aliasTokens.color.positive.onDescriptionColor;

      case ExpenseAlertType.negative:
        return aliasTokens.color.negative.onDescriptionColor;

      case ExpenseAlertType.informative:
        return aliasTokens.color.informative.onDescriptionColor;

      case ExpenseAlertType.warning:
        return aliasTokens.color.warning.onDescriptionColor;

      case ExpenseAlertType.promote:
        return aliasTokens.color.promote.onDescriptionColor;
    }
  }
}
