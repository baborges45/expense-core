import 'package:flutter/material.dart';
import 'package:expense_core/core.dart';
import 'package:provider/provider.dart';

class ExpenseBrand extends StatelessWidget {
  ///A [ExpenseBrandType] enum indicating the type of brand to be displayed.
  ///It can be either a logo or a symbol.
  final ExpenseBrandType type;

  ///(Optional) A boolean parameter that specifies whether the link should have an inverse color scheme.
  ///The default value is false.
  final bool inverse;

  ///A string value that provides a descriptive label for accessibility purposes.
  ///The default value is null
  final String? semanticsLabel;

  ///A string value that indicates additional accessibility information.
  ///The default value is null
  final String? semanticsHint;

  ///(Optional) A [double] parameter that specifies size image width.
  final double? width;

  ///(Optional) A [double] parameter that specifies size image height.
  final double? height;

  const ExpenseBrand({
    super.key,
    required this.type,
    this.inverse = false,
    this.width,
    this.height,
    this.semanticsLabel,
    this.semanticsHint,
  });

  @override
  Widget build(BuildContext context) {
    var globalTokens = Provider.of<ExpenseThemeManager>(context).globals;
    var size = globalTokens.shapes.size;

    final widthChoice = width ?? size.s4x;
    final heightChoice = height ?? size.s4x;

    if (type == ExpenseBrandType.logo) {
      final brand = inverse ? ExpenseBrands.logoExpenseBlack : ExpenseBrands.logoExpenseWhite;

      return Semantics(
        label: semanticsLabel,
        hint: semanticsHint,
        child: SvgPicture.asset(
          brand.path,
          package: brand.package,
          height: heightChoice,
        ),
      );
    }

    final symbol = inverse ? ExpenseBrands.logoMBlack : ExpenseBrands.logoMWhite;

    return Semantics(
      label: semanticsLabel,
      hint: semanticsHint,
      child: SvgPicture.asset(
        symbol.path,
        package: symbol.package,
        width: widthChoice,
        height: heightChoice,
      ),
    );
  }
}
