import 'package:flutter/material.dart';
import 'package:expense_core/core.dart';
import 'package:provider/provider.dart';

class CardContainer extends StatefulWidget {
  final Widget? child;
  final VoidCallback? onPressed;
  final double? opacity;
  final bool noPadding;
  final bool noBorder;
  final bool fixedSize;
  final ExpenseCardContainerType type;

  const CardContainer({
    super.key,
    required this.type,
    this.child,
    this.onPressed,
    this.opacity,
    this.noPadding = false,
    this.noBorder = false,
    this.fixedSize = false,
  });

  @override
  State<CardContainer> createState() => _CardContainerState();
}

class _CardContainerState extends State<CardContainer> {
  bool _isPressed = false;

  _onPressedDown(_) {
    if (widget.onPressed != null) {
      setState(() => _isPressed = true);
    }
  }

  _onPressedUp(_) {
    if (widget.onPressed != null) {
      setState(() => _isPressed = false);
    }
  }

  _onPressed() {
    if (widget.onPressed != null) {
      return widget.onPressed!();
    }
  }

  @override
  Widget build(BuildContext context) {
    var tokens = Provider.of<ExpenseThemeManager>(context);
    var globalTokens = tokens.globals;
    var aliasTokens = tokens.alias;
    var durations = globalTokens.motions.durations;

    double getOpacity() {
      return _isPressed && widget.opacity != null ? widget.opacity! : 1;
    }

    EdgeInsets getPadding() {
      final spacing = globalTokens.shapes.spacing;

      return EdgeInsets.symmetric(
        horizontal: spacing.s2x,
        vertical: spacing.s3x,
      );
    }

    BoxBorder? getBorder() {
      return widget.noBorder
          ? null
          : Border.all(
              width: aliasTokens.defaultt.borderWidth,
              color: aliasTokens.color.elements.borderColor,
            );
    }

    getDecoration() {
      final elements = aliasTokens.color.elements;
      final color = switch (widget.type) {
        ExpenseCardContainerType.card => elements.bgColor02,
        ExpenseCardContainerType.cardAlternative => elements.bgColor03,
        ExpenseCardContainerType.inverse => aliasTokens.color.inverse.bgColor,
        ExpenseCardContainerType.active => elements.bgColor06,
        ExpenseCardContainerType.gradient => Colors.white,
      };

      return BoxDecoration(
        color: color,
        border: getBorder(),
        gradient: widget.type == ExpenseCardContainerType.gradient
            ? LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  elements.bgColor06.withOpacity(0),
                  elements.bgColor06.withOpacity(0.4),
                ],
              )
            : null,
        borderRadius: BorderRadius.circular(
          aliasTokens.defaultt.borderRadius,
        ),
      );
    }

    return AnimatedOpacity(
      duration: durations.moderate02,
      opacity: getOpacity(),
      child: GestureDetector(
        onTap: _onPressed,
        onTapDown: _onPressedDown,
        onTapUp: _onPressedUp,
        onTapCancel: () => _onPressedUp(null),
        child: AnimatedContainer(
          width: !widget.fixedSize ? double.infinity : globalTokens.shapes.size.s35x,
          duration: durations.moderate02,
          padding: widget.noPadding ? EdgeInsets.zero : getPadding(),
          decoration: getDecoration(),
          child: widget.child,
        ),
      ),
    );
  }
}
