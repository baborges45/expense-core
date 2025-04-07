import 'package:mude_core/core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

mixin PropertiesMixin {
  Color getBackgroundColor({
    required BuildContext context,
    required MudeToastColor toastColor,
  }) {
    var tokens = Provider.of<MudeThemeManager>(context);
    var aliasTokens = tokens.alias;

    switch (toastColor) {
      case MudeToastColor.black:
        return aliasTokens.color.elements.bgColor03;

      case MudeToastColor.negative:
        return aliasTokens.color.negative.bgColor;

      case MudeToastColor.positive:
        return aliasTokens.color.positive.bgColor;
    }
  }

  Color getIconColor({
    required BuildContext context,
    required MudeToastColor toastColor,
  }) {
    var tokens = Provider.of<MudeThemeManager>(context);
    var aliasTokens = tokens.alias;

    switch (toastColor) {
      case MudeToastColor.black:
        return aliasTokens.color.inverse.iconColor;

      case MudeToastColor.negative:
        return aliasTokens.color.negative.onIconColor;

      case MudeToastColor.positive:
        return aliasTokens.color.positive.onIconColor;
    }
  }

  Color getFontColor({
    required BuildContext context,
    required MudeToastColor toastColor,
  }) {
    var tokens = Provider.of<MudeThemeManager>(context);
    var aliasTokens = tokens.alias;

    switch (toastColor) {
      case MudeToastColor.black:
        return aliasTokens.color.inverse.descriptionColor;

      case MudeToastColor.negative:
        return aliasTokens.color.negative.onDescriptionColor;

      case MudeToastColor.positive:
        return aliasTokens.color.positive.onDescriptionColor;
    }
  }
}
