// ignore_for_file: deprecated_member_use

part of '../avatar_group.dart';

class _Icon extends StatelessWidget {
  final MudeIconData icon;
  final Color? color;
  final bool inverse;
  final double size;
  final String? semanticsLabel;

  const _Icon({
    super.key,
    required this.icon,
    this.color,
    this.inverse = false,
    this.semanticsLabel,
    this.size = 0,
  });

  @override
  Widget build(BuildContext context) {
    var tokens = Provider.of<MudeThemeManager>(context);
    var aliasTokens = tokens.alias;

    Color getIconColor() {
      if (inverse) {
        return aliasTokens.color.inverse.iconColor;
      }

      return color ?? aliasTokens.color.elements.iconColor;
    }

    return Semantics(
      image: true,
      label: semanticsLabel,
      child: SvgPicture.asset(
        icon.path,
        package: icon.package,
        color: getIconColor(),
        width: size,
        height: size,
      ),
    );
  }
}
