import 'package:flutter/material.dart';
import 'package:expense_core/core.dart';
import 'package:provider/provider.dart';

part 'widgets/_heading_icon.dart';

class ExpenseHeading extends StatelessWidget {
  ///A string text that will be displayed in the heading.
  final String text;

  ///A ExpenseHeadingSize object that represents the size of the heading.
  ///The default value is [ExpenseHeadingSize.lg].
  final ExpenseHeadingSize size;

  ///(Optional) A boolean parameter that specifies whether the link should have an inverse color scheme.
  ///The default value is false.
  final bool inverse;

  /// A [ExpenseHeadingType] enum that represents the type of the heading.
  ///It can be [ExpenseHeadingType.food], [ExpenseHeadingType.transport], [ExpenseHeadingType.health], [ExpenseHeadingType.entertainment], [ExpenseHeadingType.other].
  ///The default value is [ExpenseHeadingType.other].
  ///This parameter is not used in the current implementation but can be used in the future for styling purposes.
  ///The default value is [ExpenseHeadingType.other].
  final ExpenseHeadingType? type;

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
    this.type,
    this.semanticsLabel,
  });

  @override
  Widget build(BuildContext context) {
    var tokens = Provider.of<ExpenseThemeManager>(context);
    var globalTokens = tokens.globals;
    var aliasTokens = tokens.alias;
    var sizing = globalTokens.shapes.size;

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
        case ExpenseHeadingSize.xxs:
          return globalTokens.typographys.fontSize2xs;
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

    Widget getIcon() {
      final textColor = getTextColor();

      switch (type) {
        case ExpenseHeadingType.food:
          return _ExpenseHeadingIcon(
            category: text,
            iconSize: ExpenseIconSize.lg,
            icon: ExpenseIcons.gastronomy,
            iconColor: textColor,
          );
        case ExpenseHeadingType.transport:
          return _ExpenseHeadingIcon(
            category: text,
            iconSize: ExpenseIconSize.lg,
            icon: ExpenseIcons.walk,
            iconColor: textColor,
          );
        case ExpenseHeadingType.shopping:
          return _ExpenseHeadingIcon(
            category: text,
            iconSize: ExpenseIconSize.lg,
            icon: ExpenseIcons.premium,
            iconColor: textColor,
          );
        case ExpenseHeadingType.education:
          return _ExpenseHeadingIcon(
            category: text,
            iconSize: ExpenseIconSize.lg,
            icon: ExpenseIcons.groups,
            iconColor: textColor,
          );
        case ExpenseHeadingType.finance:
          return _ExpenseHeadingIcon(
            category: text,
            iconSize: ExpenseIconSize.lg,
            icon: ExpenseIcons.reward,
            iconColor: textColor,
          );
        case ExpenseHeadingType.home:
          return _ExpenseHeadingIcon(
            category: text,
            iconSize: ExpenseIconSize.lg,
            icon: ExpenseIcons.hideLine,
            iconColor: textColor,
          );
        case ExpenseHeadingType.gifts:
          return _ExpenseHeadingIcon(
            category: text,
            iconSize: ExpenseIconSize.lg,
            icon: ExpenseIcons.promotionCode,
            iconColor: textColor,
          );
        case ExpenseHeadingType.health:
          return _ExpenseHeadingIcon(
            category: text,
            iconSize: ExpenseIconSize.lg,
            icon: ExpenseIcons.exercise,
            iconColor: textColor,
          );
        case ExpenseHeadingType.entertainment:
          return _ExpenseHeadingIcon(
            category: text,
            iconSize: ExpenseIconSize.lg,
            icon: ExpenseIcons.language,
            iconColor: textColor,
          );
        case ExpenseHeadingType.other:
          return _ExpenseHeadingIcon(
            category: text,
            iconSize: ExpenseIconSize.lg,
            icon: ExpenseIcons.community,
            iconColor: textColor,
          );
        case ExpenseHeadingType.work:
          return _ExpenseHeadingIcon(
            category: text,
            iconSize: ExpenseIconSize.lg,
            icon: ExpenseIcons.businessLine,
            iconColor: textColor,
          );
        default:
          return _ExpenseHeadingIcon(
            category: text,
            iconSize: ExpenseIconSize.lg,
            icon: ExpenseIcons.community,
            iconColor: textColor,
          );
      }
    }

    return Semantics(
      label: semanticsLabel,
      header: true,
      excludeSemantics: semanticsLabel != null,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          type != null ? getIcon() : const SizedBox(width: 0, height: 0),
          SizedBox(width: sizing.s1x),
          Text(
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
        ],
      ),
    );
  }
}
