import 'package:flutter/material.dart';
import 'package:expense_core/core.dart';
import 'package:provider/provider.dart';

class InputInformationIcon extends StatelessWidget {
  final bool show;
  final Color? iconColor;

  const InputInformationIcon({
    super.key,
    required this.show,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    if (!show) return const SizedBox.shrink();

    var tokens = Provider.of<ExpenseThemeManager>(context);
    var globalTokens = tokens.globals;
    var aliasTokens = tokens.alias;

    return ExcludeSemantics(
      child: Padding(
        padding: EdgeInsets.only(
          left: globalTokens.shapes.spacing.s2x,
        ),
        child: ExpenseIcon(
          icon: ExpenseIcons.informationLine,
          size: ExpenseIconSize.lg,
          color: iconColor ?? aliasTokens.color.elements.iconColor,
        ),
      ),
    );
  }
}
