import 'package:flutter/material.dart';
import 'package:expense_core/core.dart';
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
    var tokens = Provider.of<ExpenseThemeManager>(context);
    var globalTokens = tokens.globals;
    var aliasTokens = tokens.alias;

    Color getIconColor() {
      if (disabled) return aliasTokens.color.disabled.iconColor;
      if (hasError) return errorColor ?? aliasTokens.color.negative.iconColor;

      return aliasTokens.color.elements.iconColor;
    }

    ExpenseIconData getIcon() {
      return actived ? ExpenseIcons.dropdownCloseLine : ExpenseIcons.dropdownOpenLine;
    }

    Widget getIconAlert() {
      if (!hasError || disabled) return const SizedBox.shrink();

      return ExpenseIcon(
        icon: ExpenseIcons.negativeLine,
        size: ExpenseIconSize.lg,
        color: getIconColor(),
      );
    }

    return Row(
      children: [
        getIconAlert(),
        SizedBox(width: globalTokens.shapes.spacing.s2x),
        ExpenseIcon(
          icon: getIcon(),
          size: ExpenseIconSize.lg,
          color: getIconColor(),
        ),
      ],
    );
  }
}
