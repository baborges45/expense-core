// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:provider/provider.dart';

import 'package:mude_core/core.dart';

class MudeCreditCard extends StatelessWidget {
  /// (Optional) A MudeFlags object that provides a flag to the widge,
  /// you get all options in [MudeFlags].
  /// If flag in is null it will not be shown.
  final MudeFlagData? flag;

  ///(Optional) A boolean parameter that specifies whether the link should have an inverse color scheme.
  ///The default value is false.
  final bool inverse;

  ///A string value that provides a descriptive label for accessibility purposes.
  ///The default value is null
  final String? semanticsLabel;

  ///A string value that indicates additional accessibility information.
  ///The default value is null
  final String? semanticsHint;

  const MudeCreditCard({
    super.key,
    this.flag,
    this.inverse = false,
    this.semanticsLabel,
    this.semanticsHint,
  });

  @override
  Widget build(BuildContext context) {
    var tokens = Provider.of<MudeThemeManager>(context);
    var globalTokens = tokens.globals;
    var aliasTokens = tokens.alias;
    var spacing = globalTokens.shapes.spacing;
    var size = globalTokens.shapes.size;

    Widget getDot() {
      if (flag != null) {
        return const SizedBox.shrink();
      }

      return Positioned(
        top: spacing.half,
        left: spacing.half,
        child: Container(
          width: globalTokens.shapes.size.s1x,
          height: globalTokens.shapes.size.half,
          decoration: BoxDecoration(
            color: aliasTokens.color.elements.bgColor01,
            borderRadius: BorderRadius.circular(
              globalTokens.shapes.border.radiusCircular,
            ),
          ),
        ),
      );
    }

    Widget getFlag() {
      if (flag == null) return const SizedBox.shrink();

      return SvgPicture.asset(
        flag!.path,
        package: flag!.package,
        width: flag!.width,
        height: flag!.height,
      );
    }

    return Semantics(
      label: semanticsLabel,
      hint: semanticsHint,
      excludeSemantics: true,
      child: Stack(
        children: [
          Container(
            width: size.s5x,
            height: size.s3x,
            decoration: BoxDecoration(
              color: aliasTokens.color.elements.bgColor03,
              borderRadius: BorderRadius.circular(
                globalTokens.shapes.border.radiusXs,
              ),
            ),
            child: Center(
              child: getFlag(),
            ),
          ),
          getDot(),
        ],
      ),
    );
  }
}
