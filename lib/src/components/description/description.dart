import 'package:flutter/material.dart';
import 'package:mude_core/core.dart';
import 'package:provider/provider.dart';

class MudeDescription extends StatelessWidget {
  /// Set a text to display in the description.
  final String text;

  /// Set a alignment to showing this description, you get all options in [TextAlign]
  /// If you don't he will assume [TextAlign.left]
  final TextAlign align;

  /// Set if you want to invert the colors
  final bool inverse;

  /// Set a new color in description
  final Color? color;

  ///A string value that provides a descriptive label for accessibility purposes.
  ///The default value is null
  final String? semanticsLabel;

  const MudeDescription(
    this.text, {
    super.key,
    this.align = TextAlign.left,
    this.inverse = false,
    this.color,
    this.semanticsLabel,
  });

  @override
  Widget build(BuildContext context) {
    var tokens = Provider.of<MudeThemeManager>(context);
    var globalTokens = tokens.globals;
    var aliasTokens = tokens.alias;

    Color getColor() {
      Color colorChoice = aliasTokens.color.text.descriptionColor;

      if (color != null) {
        colorChoice = color!;
      } else if (inverse) {
        colorChoice = aliasTokens.color.inverse.descriptionColor;
      }

      return colorChoice;
    }

    return Semantics(
      label: semanticsLabel,
      child: Text(
        text,
        textAlign: align,
        style: TextStyle(
          color: getColor(),
          fontFamily: globalTokens.typographys.fontFamilyBase,
          fontWeight: globalTokens.typographys.fontWeightRegular,
          fontSize: globalTokens.typographys.fontSize2xs,
          height: globalTokens.typographys.lineHeightMd,
          letterSpacing: globalTokens.typographys.letterSpacingDefault,
        ),
      ),
    );
  }
}
