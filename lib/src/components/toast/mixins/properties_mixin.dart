import 'package:expense_core/core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

mixin PropertiesMixin {
  Color getBackgroundColor({
    required BuildContext context,
    required ExpenseToastColor toastColor,
  }) {
    var tokens = Provider.of<ExpenseThemeManager>(context);
    var aliasTokens = tokens.alias;

    switch (toastColor) {
      case ExpenseToastColor.black:
        return aliasTokens.color.elements.bgColor03;

      case ExpenseToastColor.negative:
        return aliasTokens.color.negative.bgColor;

      case ExpenseToastColor.positive:
        return aliasTokens.color.positive.bgColor;
    }
  }

  Color getIconColor({
    required BuildContext context,
    required ExpenseToastColor toastColor,
  }) {
    var tokens = Provider.of<ExpenseThemeManager>(context);
    var aliasTokens = tokens.alias;

    switch (toastColor) {
      case ExpenseToastColor.black:
        return aliasTokens.color.inverse.iconColor;

      case ExpenseToastColor.negative:
        return aliasTokens.color.negative.onIconColor;

      case ExpenseToastColor.positive:
        return aliasTokens.color.positive.onIconColor;
    }
  }

  Color getFontColor({
    required BuildContext context,
    required ExpenseToastColor toastColor,
  }) {
    var tokens = Provider.of<ExpenseThemeManager>(context);
    var aliasTokens = tokens.alias;

    switch (toastColor) {
      case ExpenseToastColor.black:
        return aliasTokens.color.inverse.descriptionColor;

      case ExpenseToastColor.negative:
        return aliasTokens.color.negative.onDescriptionColor;

      case ExpenseToastColor.positive:
        return aliasTokens.color.positive.onDescriptionColor;
    }
  }
}
