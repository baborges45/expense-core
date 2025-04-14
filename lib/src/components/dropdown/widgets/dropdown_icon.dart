import 'package:flutter/material.dart';
import 'package:expense_core/core.dart';
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
    var aliasTokens = Provider.of<ExpenseThemeManager>(context).alias;

    Color getIconColor() {
      if (inverse) {
        return aliasTokens.color.inverse.iconColor;
      }

      return aliasTokens.color.elements.iconColor;
    }

    ExpenseIconData getIcon() {
      return _isOpen ? ExpenseIcons.dropdownCloseLine : ExpenseIcons.dropdownOpenLine;
    }

    return ExpenseIcon(
      icon: getIcon(),
      size: ExpenseIconSize.sm,
      color: getIconColor(),
    );
  }
}
