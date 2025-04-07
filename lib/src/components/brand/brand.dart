import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mude_core/core.dart';
import 'package:provider/provider.dart';

class MudeBrand extends StatelessWidget {
  ///A [MudeBrandType] enum indicating the type of brand to be displayed.
  ///It can be either a logo or a symbol.
  final MudeBrandType type;

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

  const MudeBrand({
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
    var globalTokens = Provider.of<MudeThemeManager>(context).globals;
    var size = globalTokens.shapes.size;

    final widthChoice = width ?? size.s4x;
    final heightChoice = height ?? size.s4x;

    if (type == MudeBrandType.logo) {
      final brand =
          inverse ? MudeBrands.logoMudeBlack : MudeBrands.logoMudeWhite;

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

    final symbol = inverse ? MudeBrands.logoMBlack : MudeBrands.logoMWhite;

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
