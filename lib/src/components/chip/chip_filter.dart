import 'package:flutter/material.dart';
import 'package:expense_core/core.dart';
import 'package:provider/provider.dart';

import 'mixins/properties_mixin.dart';
import 'widgets/container_chip.dart';

class ExpenseChipFilter extends StatefulWidget {
  ///A required callback that will be called when the chip filter is pressed.
  final VoidCallback onPressed;

  ///A string representing the label text to be displayed in the chip filter.
  final String label;

  ///A string value that provides a descriptive label for accessibility purposes.
  ///The default value is null
  final String? semanticsLabel;

  ///A string value that indicates additional accessibility information.
  ///The default value is null
  final String? semanticsHint;

  const ExpenseChipFilter({
    super.key,
    required this.onPressed,
    required this.label,
    this.semanticsLabel,
    this.semanticsHint,
  });

  @override
  State<ExpenseChipFilter> createState() => _ExpenseChipFilterState();
}

class _ExpenseChipFilterState extends State<ExpenseChipFilter> with PropertiesMixin {
  bool _isPressed = false;

  void _onPressedDown() {
    setState(() => _isPressed = true);
  }

  void _onPressedUp() {
    setState(() => _isPressed = false);
  }

  @override
  Widget build(BuildContext context) {
    var tokens = Provider.of<ExpenseThemeManager>(context);
    var aliasTokens = tokens.alias;
    var globalsTokens = tokens.globals;

    double getOpacity() {
      return _isPressed ? aliasTokens.color.pressed.containerOpacity : 1;
    }

    Color getIconColor() {
      return aliasTokens.color.selected.iconColor;
    }

    return Semantics(
      button: true,
      label: widget.semanticsLabel,
      hint: widget.semanticsHint,
      child: GestureDetector(
        onTap: widget.onPressed,
        onTapDown: (e) => _onPressedDown(),
        onTapUp: (e) => _onPressedUp(),
        onTapCancel: () => setState(() => _isPressed = false),
        child: Opacity(
          opacity: getOpacity(),
          child: ContainerChip(
            isPressed: _isPressed,
            isSelected: false,
            type: ExpenseChipType.filter,
            children: [
              Text(
                widget.label,
                style: aliasTokens.mixin.labelMd2.copyWith(color: aliasTokens.color.text.labelColor),
              ),
              SizedBox(
                width: globalsTokens.shapes.spacing.half,
              ),
              ExpenseIcon(
                icon: ExpenseIcons.closeLine,
                color: getIconColor(),
                size: ExpenseIconSize.sm,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
