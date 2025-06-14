// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:expense_core/core.dart';
import 'package:provider/provider.dart';

import 'mixins/sizes_mixin.dart';
import 'widgets/container_size.dart';

class ExpenseButtonPlay extends StatefulWidget {
  ///The initial status of the button. It is of type [ExpenseButtonPlayType] and has a default value of [ExpenseButtonPlayType.play].
  final ExpenseButtonPlayType initialStatus;

  ///(Optional) A boolean indicating whether the button should be disabled.
  ///The default value is false.
  final bool disabled;

  ///A required callback that will be called when the button is pressed passing the current state.
  final void Function(ExpenseButtonPlayType) onPressed;

  ///(Optional) A boolean parameter that specifies whether the link should have an inverse color scheme.
  ///The default value is false.
  final bool inverse;

  ///A string value that provides a descriptive label for accessibility purposes.
  ///The default value is null
  final String? semanticsLabel;

  ///A string value that indicates additional accessibility information.
  ///The default value is null
  final String? semanticsHint;

  const ExpenseButtonPlay({
    super.key,
    required this.onPressed,
    this.disabled = false,
    this.initialStatus = ExpenseButtonPlayType.pause,
    this.inverse = false,
    this.semanticsLabel,
    this.semanticsHint,
  });

  @override
  State<ExpenseButtonPlay> createState() => _ExpenseButtonPlayState();
}

class _ExpenseButtonPlayState extends State<ExpenseButtonPlay> with SizesMixin {
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
      Color? color = widget.disabled ? aliasTokens.color.disabled.iconColor : aliasTokens.color.action.iconPrimaryColor;

      return ExpenseIcon(
        key: const Key('button-play.icon'),
        icon: widget.initialStatus == ExpenseButtonPlayType.pause ? ExpenseIcons.pauseLine : ExpenseIcons.playFill,
        size: ExpenseIconSize.xl,
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
        onTap: widget.disabled
            ? null
            : () {
                widget.onPressed(widget.initialStatus);
              },
        onTapDown: _onPressedDown,
        onTapUp: _onPressedUp,
        onTapCancel: () => _onPressedUp(null),
        child: Opacity(
          key: const Key('button-play.animated-opacity'),
          opacity: opacity,
          child: ContainerSize(
            inverse: widget.inverse,
            isPressed: _isPressed,
            child: Container(
              key: const Key('button-play.background'),
              decoration: BoxDecoration(
                color: getBackgroundColor(),
                borderRadius: BorderRadius.all(Radius.circular(radius)),
              ),
              width: size.s6x,
              height: size.s6x,
              child: Center(child: getIcon()),
            ),
          ),
        ),
      ),
    );
  }
}
