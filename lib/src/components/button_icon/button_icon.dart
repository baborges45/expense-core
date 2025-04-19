// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:expense_core/core.dart';
import 'package:provider/provider.dart';

import 'mixins/sizes_mixin.dart';
import 'widgets/container_size.dart';

class ExpenseButtonIcon extends StatefulWidget {
  ///The size of the button. It is of type [ExpenseButtonIconSize] and has a default value of [ExpenseButtonIconSize.lg].
  final ExpenseButtonIconSize size;

  ///(Optional) A boolean indicating whether the button should be disabled.
  ///The default value is false.
  final bool disabled;

  ///(Optional) A Color that represents the icon color.
  final Color? iconColor;

  ///(Optional) A Color that represents the background color when pressed.
  final Color? backgroundColor;

  ///(Optional) A boolean indicating whether to show a notification dot on the button.
  ///The default value is false.
  final bool showNotification;

  ///A required callback that will be called when the button is pressed.
  final VoidCallback onPressed;

  ///A [ExpenseIconData] object representing the icon to be displayed on the button.
  final ExpenseIconData icon;

  ///(Optional) A boolean parameter that specifies whether the link should have an inverse color scheme.
  ///The default value is false.
  final bool inverse;

  ///A string value that provides a descriptive label for accessibility purposes.
  ///The default value is null
  final String? semanticsLabel;

  ///A string value that indicates additional accessibility information.
  ///The default value is null
  final String? semanticsHint;

  const ExpenseButtonIcon({
    super.key,
    required this.icon,
    required this.onPressed,
    this.size = ExpenseButtonIconSize.lg,
    this.disabled = false,
    this.showNotification = false,
    this.inverse = false,
    this.semanticsLabel,
    this.semanticsHint,
    this.iconColor,
    this.backgroundColor,
  });

  @override
  State<ExpenseButtonIcon> createState() => _ExpenseButtonIconState();
}

class _ExpenseButtonIconState extends State<ExpenseButtonIcon> with SizesMixin {
  bool _isPressed = false;

  _onPressedDown(_) {
    if (widget.disabled) return null;
    setState(() => _isPressed = true);
  }

  _onPressedUp(_) {
    if (widget.disabled) return null;
    setState(() => _isPressed = false);
  }

  @override
  Widget build(BuildContext context) {
    final tokens = Provider.of<ExpenseThemeManager>(context);
    final aliasTokens = tokens.alias;
    final globalTokens = tokens.globals;
    final size = globalTokens.shapes.size;

    final radius = globalTokens.shapes.border.radiusCircular;

    ExpenseIcon getIcon() {
      ExpenseIconSize iconSize = widget.size == ExpenseButtonIconSize.lg ? ExpenseIconSize.lg : ExpenseIconSize.sm;

      Color? color = widget.disabled ? aliasTokens.color.disabled.iconColor : widget.iconColor;

      return ExpenseIcon(
        key: const Key('button-icon.icon'),
        icon: widget.icon,
        size: iconSize,
        color: color,
        inverse: widget.inverse,
      );
    }

    double getOpacity() {
      if (widget.disabled) {
        return aliasTokens.color.disabled.opacity;
      } else if (_isPressed) {
        return aliasTokens.color.pressed.containerOpacity;
      }

      return 1;
    }

    Color? getBackgroundColor() {
      if (_isPressed) {
        if (widget.backgroundColor != null) {
          return widget.backgroundColor!;
        }

        return widget.inverse ? aliasTokens.mixin.pressedOutlineInverse : aliasTokens.mixin.pressedOutline;
      }

      return null;
    }

    double opacity = getOpacity();

    return Semantics(
      button: true,
      enabled: !widget.disabled,
      label: widget.semanticsLabel,
      hint: widget.semanticsHint,
      excludeSemantics: widget.semanticsHint != null,
      child: GestureDetector(
        onTap: widget.disabled ? null : widget.onPressed,
        onTapDown: _onPressedDown,
        onTapUp: _onPressedUp,
        onTapCancel: () => _onPressedUp(null),
        child: Opacity(
          key: const Key('button-icon.animated-opacity'),
          opacity: opacity,
          child: ContainerSize(
            child: Stack(
              children: [
                Container(
                  key: const Key('button-icon.background'),
                  decoration: BoxDecoration(
                    color: getBackgroundColor(),
                    borderRadius: BorderRadius.all(Radius.circular(radius)),
                  ),
                  width: size.s6x,
                  height: size.s6x,
                  child: Center(child: getIcon()),
                ),
                getNotificationDot(
                  show: widget.showNotification,
                  size: widget.size,
                  opacity: opacity,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
