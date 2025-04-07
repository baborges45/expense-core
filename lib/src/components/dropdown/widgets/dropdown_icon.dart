import 'package:flutter/material.dart';
import 'package:mude_core/core.dart';
import 'package:provider/provider.dart';

class DropdownIcon extends StatelessWidget {
  final bool _isOpen;
  final bool inverse;

  const DropdownIcon({
    super.key,
    required bool isOpen,
    this.inverse = false,
  }) : _isOpen = isOpen;

  @override
  Widget build(BuildContext context) {
    var aliasTokens = Provider.of<MudeThemeManager>(context).alias;

    Color getIconColor() {
      if (inverse) {
        return aliasTokens.color.inverse.iconColor;
      }

      return aliasTokens.color.elements.iconColor;
    }

    MudeIconData getIcon() {
      return _isOpen ? MudeIcons.dropdownCloseLine : MudeIcons.dropdownOpenLine;
    }

    return MudeIcon(
      icon: getIcon(),
      size: MudeIconSize.sm,
      color: getIconColor(),
    );
  }
}
