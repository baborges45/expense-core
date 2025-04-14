import 'package:expense_core/core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

mixin PropertiesMixin {
  TextStyle getTextStyle({
    required ExpenseChipType type,
    required bool isSelected,
    required BuildContext context,
    required bool inverse,
  }) {
    final tokens = Provider.of<ExpenseThemeManager>(context).alias;
    final inverseColor = tokens.color.inverse;

    final labelColor = inverse ? inverseColor.labelColor : tokens.color.text.labelColor;

    final onLabelColor = inverse ? inverseColor.onLabelColor : tokens.color.selected.onLabelColor;

    final textStyle = tokens.mixin.labelMd2.merge(
      TextStyle(color: isSelected ? onLabelColor : labelColor),
    );

    if (type == ExpenseChipType.select && inverse && isSelected) {
      return textStyle.copyWith(color: onLabelColor);
    }

    if (type == ExpenseChipType.filter && inverse) {
      return textStyle.copyWith(color: onLabelColor);
    }

    if (type == ExpenseChipType.filter && !inverse) {
      return textStyle.copyWith(color: onLabelColor);
    }

    return textStyle;
  }
}
