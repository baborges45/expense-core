import 'package:mude_core/core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

mixin PropertiesMixin {
  TextStyle getTextStyle({
    required MudeChipType type,
    required bool isSelected,
    required BuildContext context,
    required bool inverse,
  }) {
    final tokens = Provider.of<MudeThemeManager>(context).alias;
    final inverseColor = tokens.color.inverse;

    final labelColor =
        inverse ? inverseColor.labelColor : tokens.color.text.labelColor;

    final onLabelColor = inverse
        ? inverseColor.onLabelColor
        : tokens.color.selected.onLabelColor;

    final textStyle = tokens.mixin.labelMd2.merge(
      TextStyle(color: isSelected ? onLabelColor : labelColor),
    );

    if (type == MudeChipType.select && inverse && isSelected) {
      return textStyle.copyWith(color: onLabelColor);
    }

    if (type == MudeChipType.filter && inverse) {
      return textStyle.copyWith(color: onLabelColor);
    }

    if (type == MudeChipType.filter && !inverse) {
      return textStyle.copyWith(color: onLabelColor);
    }

    return textStyle;
  }
}
