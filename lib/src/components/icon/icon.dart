// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mude_core/core.dart';
import 'package:provider/provider.dart';

class MudeIcon extends StatelessWidget {
  /// Set a icon, you get all options in [MudeIcons]
  /// This field is required.
  final MudeIconData icon;

  /// Set a size, you get all options in [MudeIconSize].
  /// If you don't he will assume [MudeIconSize.lg].
  final MudeIconSize size;

  /// Set a color, this field accept value null.
  final Color? color;

  /// Set true to displayed heading inverse.
  final bool inverse;

  ///A string value that indicates if you add more information from accessibility
  ///The default value is null
  final String? semanticsLabel;

  const MudeIcon({
    super.key,
    required this.icon,
    this.color,
    this.size = MudeIconSize.lg,
    this.inverse = false,
    this.semanticsLabel,
  });

  @override
  Widget build(BuildContext context) {
    var tokens = Provider.of<MudeThemeManager>(context);
    var globalTokens = tokens.globals;
    var aliasTokens = tokens.alias;

    double getSizeIcon() {
      switch (size) {
        case MudeIconSize.sm:
          return globalTokens.shapes.size.s2x;
        case MudeIconSize.lg:
          return globalTokens.shapes.size.s2_5x;
        case MudeIconSize.xl:
          return globalTokens.shapes.size.s3x;
      }
    }

    Color getIconColor() {
      if (inverse) {
        return aliasTokens.color.inverse.iconColor;
      }

      return color ?? aliasTokens.color.elements.iconColor;
    }

    double sizeIcon = getSizeIcon();

    return Semantics(
      image: true,
      label: semanticsLabel,
      child: SvgPicture.asset(
        icon.path,
        package: icon.package,
        color: getIconColor(),
        width: sizeIcon,
        height: sizeIcon,
      ),
    );
  }
}
