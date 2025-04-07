import 'package:mude_core/core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

mixin PropertiesMixin {
  double getOpacity(bool disabled, bool isPressed, BuildContext context) {
    var tokens = Provider.of<MudeThemeManager>(context);
    var aliasTokens = tokens.alias;

    if (disabled) {
      return aliasTokens.color.disabled.opacity;
    }

    return isPressed ? aliasTokens.color.pressed.containerOpacity : 1;
  }
}
