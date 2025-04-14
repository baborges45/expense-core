import 'package:flutter/material.dart';
import 'package:expense_core/core.dart';
import 'package:provider/provider.dart';

import '../mixins/properties_mixin.dart';

class ContainerWidget extends StatefulWidget {
  final String label;
  final String description;
  final Widget? child;
  final VoidCallback onPressed;
  final bool disabled;
  final Gradient? gradient;

  const ContainerWidget({
    super.key,
    required this.label,
    required this.description,
    required this.onPressed,
    this.gradient,
    this.child,
    this.disabled = false,
  });

  @override
  State<ContainerWidget> createState() => _ContainerWidgetState();
}

class _ContainerWidgetState extends State<ContainerWidget> with PropertiesMixin {
  bool _isPressed = false;

  _onPressedDown(_) {
    if (widget.disabled) return null;
    setState(() => _isPressed = true);
  }

  _onPressedUp(_) {
    if (widget.disabled) return null;
    setState(() => _isPressed = false);
  }

  _onPressed() {
    if (widget.disabled) return null;

    return widget.onPressed();
  }

  @override
  Widget build(BuildContext context) {
    var tokens = Provider.of<ExpenseThemeManager>(context);
    var globalTokens = tokens.globals;
    var aliasTokens = tokens.alias;
    var size = globalTokens.shapes.size;
    var durations = globalTokens.motions.durations;
    var lineHeightSm = globalTokens.typographys.lineHeightSm;

    Color getTextColor() {
      if (widget.disabled) {
        return aliasTokens.color.disabled.onLabelColor;
      }

      if (widget.gradient != null) {
        return aliasTokens.color.overlay.onGradient;
      }

      return aliasTokens.color.text.labelColor;
    }

    Color getDescriptionColor() {
      if (widget.disabled) {
        return aliasTokens.color.disabled.descriptionColor;
      }

      if (widget.gradient != null) {
        return aliasTokens.color.overlay.onGradient;
      }

      return aliasTokens.color.text.descriptionColor;
    }

    Color? getBackgroundColor() {
      if (widget.disabled) {
        return aliasTokens.color.disabled.bgColor;
      }

      return widget.gradient == null ? aliasTokens.color.elements.bgColor02 : null;
    }

    Widget getChild() {
      return widget.child != null ? widget.child! : const SizedBox.shrink();
    }

    double getAnimatedOpacity() {
      return getOpacity(widget.disabled, _isPressed, context);
    }

    return AnimatedOpacity(
      duration: durations.fast02,
      opacity: getAnimatedOpacity(),
      child: Stack(
        children: [
          GestureDetector(
            onTap: _onPressed,
            onTapDown: _onPressedDown,
            onTapUp: _onPressedUp,
            onTapCancel: () => _onPressedUp(null),
            child: AnimatedContainer(
              duration: durations.fast02,
              padding: EdgeInsets.all(globalTokens.shapes.spacing.s2x),
              height: size.s20x,
              width: size.s20x,
              decoration: BoxDecoration(
                gradient: widget.gradient,
                color: getBackgroundColor(),
                borderRadius: BorderRadius.circular(
                  aliasTokens.defaultt.borderRadius,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getChild(),
                  const Spacer(),
                  ...[
                    Text(
                      widget.label,
                      style: aliasTokens.mixin.labelMd2.merge(
                        TextStyle(
                          color: getTextColor(),
                          height: lineHeightSm,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.s1x,
                    ),
                    Text(
                      widget.description,
                      style: aliasTokens.mixin.labelMd1.merge(
                        TextStyle(
                          color: getDescriptionColor(),
                          height: lineHeightSm,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
