import 'package:flutter/material.dart';
import 'package:mude_core/core.dart';
import 'package:provider/provider.dart';

class SelectIconWidget extends StatelessWidget {
  final bool actived;
  final bool disabled;
  final bool hasError;
  final Color? errorColor;

  const SelectIconWidget({
    super.key,
    required this.actived,
    required this.disabled,
    required this.hasError,
    this.errorColor,
  });

  @override
  Widget build(BuildContext context) {
    var tokens = Provider.of<MudeThemeManager>(context);
    var globalTokens = tokens.globals;
    var aliasTokens = tokens.alias;

    Color getIconColor() {
      if (disabled) return aliasTokens.color.disabled.iconColor;
      if (hasError) return errorColor ?? aliasTokens.color.negative.iconColor;

      return aliasTokens.color.elements.iconColor;
    }

    MudeIconData getIcon() {
      return actived ? MudeIcons.dropdownCloseLine : MudeIcons.dropdownOpenLine;
    }

    Widget getIconAlert() {
      if (!hasError || disabled) return const SizedBox.shrink();

      return MudeIcon(
        icon: MudeIcons.negativeLine,
        size: MudeIconSize.lg,
        color: getIconColor(),
      );
    }

    return Row(
      children: [
        getIconAlert(),
        SizedBox(width: globalTokens.shapes.spacing.s2x),
        MudeIcon(
          icon: getIcon(),
          size: MudeIconSize.lg,
          color: getIconColor(),
        ),
      ],
    );
  }
}
