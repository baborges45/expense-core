import 'package:flutter/material.dart';
import 'package:expense_core/core.dart';
import 'package:provider/provider.dart';

class ExpenseHeading extends StatelessWidget {
  ///A string text that will be displayed in the heading.
  final String text;

  ///A ExpenseHeadingSize object that represents the size of the heading.
  ///The default value is [ExpenseHeadingSize.lg].
  final ExpenseHeadingSize size;

  ///(Optional) A boolean parameter that specifies whether the link should have an inverse color scheme.
  ///The default value is false.
  final bool inverse;

  ///A string value that provides a descriptive label for accessibility purposes.
  ///The default value is null
  final String? semanticsLabel;

  // The alignment of the text
  final TextAlign? textAlign;

  const ExpenseHeading(
    this.text, {
    super.key,
    this.size = ExpenseHeadingSize.lg,
    this.inverse = false,
    this.textAlign = TextAlign.left,
    this.semanticsLabel,
  });

  @override
  Widget build(BuildContext context) {
    var tokens = Provider.of<ExpenseThemeManager>(context);
    var globalTokens = tokens.globals;
    var aliasTokens = tokens.alias;

    double getSize(ExpenseHeadingSize size) {
      switch (size) {
        case ExpenseHeadingSize.xl:
          return globalTokens.typographys.fontSizeXl;
        case ExpenseHeadingSize.lg:
          return globalTokens.typographys.fontSizeLg;
        case ExpenseHeadingSize.md:
          return globalTokens.typographys.fontSizeMd;
        case ExpenseHeadingSize.sm:
          return globalTokens.typographys.fontSizeSm;
        case ExpenseHeadingSize.xs:
          return globalTokens.typographys.fontSizeXs;
      }
    }

    Color getTextColor() {
      return inverse ? aliasTokens.color.inverse.headingColor : aliasTokens.color.text.headingColor;
    }

    FontWeight getFontWeight() {
      return size == ExpenseHeadingSize.xl ? globalTokens.typographys.fontWeightLightItalic : globalTokens.typographys.fontWeightMedium;
    }

    String getFontFamily() {
      return size == ExpenseHeadingSize.xl ? globalTokens.typographys.fontFamilyBrand : globalTokens.typographys.fontFamilyBase;
    }

    double getlineHeight() {
      return size == ExpenseHeadingSize.xl ? globalTokens.typographys.lineHeightDefault : globalTokens.typographys.lineHeightSm;
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
