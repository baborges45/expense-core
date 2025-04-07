import 'package:mude_core/core.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

mixin PropertiesMixin {
  Color getBackgroundColor({
    required BuildContext context,
    required MudeAlertType alertColor,
  }) {
    var tokens = Provider.of<MudeThemeManager>(context);
    var aliasTokens = tokens.alias;

    switch (alertColor) {
      case MudeAlertType.positive:
        return aliasTokens.color.positive.bgColor;

      case MudeAlertType.negative:
        return aliasTokens.color.negative.bgColor;

      case MudeAlertType.informative:
        return aliasTokens.color.informative.bgColor;

      case MudeAlertType.warning:
        return aliasTokens.color.warning.bgColor;

      case MudeAlertType.promote:
        return aliasTokens.color.promote.bgColor;
    }
  }

  Color getIconColor({
    required BuildContext context,
    required MudeAlertType alertColor,
  }) {
    var tokens = Provider.of<MudeThemeManager>(context);
    var aliasTokens = tokens.alias;

    switch (alertColor) {
      case MudeAlertType.positive:
        return aliasTokens.color.positive.onIconColor;

      case MudeAlertType.negative:
        return aliasTokens.color.negative.onIconColor;

      case MudeAlertType.informative:
        return aliasTokens.color.informative.onIconColor;

      case MudeAlertType.warning:
        return aliasTokens.color.warning.onIconColor;

      case MudeAlertType.promote:
        return aliasTokens.color.promote.onIconColor;
    }
  }

  Color getFontColor({
    required BuildContext context,
    required MudeAlertType alertColor,
  }) {
    var tokens = Provider.of<MudeThemeManager>(context);
    var aliasTokens = tokens.alias;

    switch (alertColor) {
      case MudeAlertType.positive:
        return aliasTokens.color.positive.onDescriptionColor;

      case MudeAlertType.negative:
        return aliasTokens.color.negative.onDescriptionColor;

      case MudeAlertType.informative:
        return aliasTokens.color.informative.onDescriptionColor;

      case MudeAlertType.warning:
        return aliasTokens.color.warning.onDescriptionColor;

      case MudeAlertType.promote:
        return aliasTokens.color.promote.onDescriptionColor;
    }
  }
}
