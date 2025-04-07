import 'package:flutter/material.dart';
import 'package:mude_core/core.dart';
import 'package:provider/provider.dart';

class MudeHeading extends StatelessWidget {
  ///A string text that will be displayed in the heading.
  final String text;

  ///A MudeHeadingSize object that represents the size of the heading.
  ///The default value is [MudeHeadingSize.lg].
  final MudeHeadingSize size;

  ///(Optional) A boolean parameter that specifies whether the link should have an inverse color scheme.
  ///The default value is false.
  final bool inverse;

  ///A string value that provides a descriptive label for accessibility purposes.
  ///The default value is null
  final String? semanticsLabel;

  // The alignment of the text
  final TextAlign? textAlign;

  const MudeHeading(
    this.text, {
    super.key,
    this.size = MudeHeadingSize.lg,
    this.inverse = false,
    this.textAlign = TextAlign.left,
    this.semanticsLabel,
  });

  @override
  Widget build(BuildContext context) {
    var tokens = Provider.of<MudeThemeManager>(context);
    var globalTokens = tokens.globals;
    var aliasTokens = tokens.alias;

    double getSize(MudeHeadingSize size) {
      switch (size) {
        case MudeHeadingSize.xl:
          return globalTokens.typographys.fontSizeXl;
        case MudeHeadingSize.lg:
          return globalTokens.typographys.fontSizeLg;
        case MudeHeadingSize.md:
          return globalTokens.typographys.fontSizeMd;
        case MudeHeadingSize.sm:
          return globalTokens.typographys.fontSizeSm;
        case MudeHeadingSize.xs:
          return globalTokens.typographys.fontSizeXs;
      }
    }

    Color getTextColor() {
      return inverse
          ? aliasTokens.color.inverse.headingColor
          : aliasTokens.color.text.headingColor;
    }

    FontWeight getFontWeight() {
      return size == MudeHeadingSize.xl
          ? globalTokens.typographys.fontWeightLightItalic
          : globalTokens.typographys.fontWeightMedium;
    }

    String getFontFamily() {
      return size == MudeHeadingSize.xl
          ? globalTokens.typographys.fontFamilyBrand
          : globalTokens.typographys.fontFamilyBase;
    }

    double getlineHeight() {
      return size == MudeHeadingSize.xl
          ? globalTokens.typographys.lineHeightDefault
          : globalTokens.typographys.lineHeightSm;
    }

    return Semantics(
      label: semanticsLabel,
      header: true,
      excludeSemantics: semanticsLabel != null,
      child: Text(
        text,
        textAlign: textAlign,
        style: TextStyle(
          color: getTextColor(),
          fontFamily: getFontFamily(),
          fontWeight: getFontWeight(),
          fontSize: getSize(size),
          height: getlineHeight(),
          letterSpacing: globalTokens.typographys.letterSpacingDefault,
        ),
      ),
    );
  }
}
