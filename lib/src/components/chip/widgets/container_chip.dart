import 'package:flutter/material.dart';
import 'package:expense_core/core.dart';
import 'package:provider/provider.dart';

import '../mixins/properties_mixin.dart';

class ContainerChip extends StatelessWidget with PropertiesMixin {
  final List<Widget> children;
  final ExpenseChipType type;
  final bool isSelected;
  final bool isPressed;

  const ContainerChip({
    super.key,
    required this.children,
    required this.type,
    required this.isSelected,
    required this.isPressed,
  });

  @override
  Widget build(BuildContext context) {
    var tokens = Provider.of<ExpenseThemeManager>(context);
    var aliasTokens = tokens.alias;
    var globalsTokens = tokens.globals;
    final spacing = globalsTokens.shapes.spacing;

    Border getBorder() {
      double borderWidth = aliasTokens.defaultt.borderWidth;

      return Border.all(
        color: aliasTokens.color.elements.borderColor,
        width: borderWidth,
      );
    }

    Color getColor() {
      if (isSelected) {
        return aliasTokens.color.selected.bgColor;
      }

      return isPressed ? aliasTokens.mixin.pressedOutline : Colors.transparent;
    }

    return IntrinsicWidth(
      child: Container(
        key: const Key('chip.background'),
        padding: EdgeInsets.symmetric(
          horizontal: spacing.s2x,
          vertical: spacing.s1x,
        ),
        alignment: Alignment.center,
        height: globalsTokens.shapes.size.s6x,
        decoration: BoxDecoration(
          color: getColor(),
          borderRadius: BorderRadius.all(
            Radius.circular(
              globalsTokens.shapes.border.radiusCircular,
            ),
          ),
          border: getBorder(),
        ),
        child: Row(
          children: children,
        ),
      ),
    );
  }
}
