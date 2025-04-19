import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:expense_core/core.dart';
import 'package:provider/provider.dart';

class ExpenseSwitch extends StatefulWidget {
  ///A boolean value that determines whether the switch is disabled or not.
  ///The default value is false.
  final bool disabled;

  ///A boolean value that determines the state of the switch.
  final bool value;

  ///(Optional) A string representing the label text to be displayed next to the checkbox.
  final String? label;

  ///A callback function that will be called when the state of the switch changes.
  ///It returns an bool with the new switch value.
  final Function(bool value) onChanged;

  ///(Optional) A boolean parameter that specifies whether the link should have an inverse color scheme.
  ///The default value is false.
  final bool inverse;

  ///A string value that indicates if you add more information from accessibility
  ///The default value is null
  final String? semanticsLabel;

  const ExpenseSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.label,
    this.disabled = false,
    this.inverse = false,
    this.semanticsLabel,
  });

  @override
  State<ExpenseSwitch> createState() => _ExpenseSwitchState();
}

class _ExpenseSwitchState extends State<ExpenseSwitch> {
  bool _isPressed = false;
  double _positionDot = 5;

  void _onTap(bool value) {
    if (!widget.disabled) {
      setState(() => _isPressed = value);
    }
  }

  _onPressed(bool value) {
    if (widget.disabled) return null;
    setState(() => _positionDot = widget.value ? 5 : 20);
    SemanticsService.announce(
      widget.value ? 'off' : 'on',
      TextDirection.ltr,
    );

    return widget.onChanged(value);
  }

  @override
  void initState() {
    super.initState();
    setState(() => _positionDot = widget.value ? 20 : 5);
  }

  @override
  Widget build(BuildContext context) {
    final tokens = Provider.of<ExpenseThemeManager>(context, listen: false);
    final globalTokens = tokens.globals;
    final aliasTokens = tokens.alias;

    final spacing = globalTokens.shapes.spacing;
    final size = globalTokens.shapes.size;
    final border = globalTokens.shapes.border;

    Color getBackgroundColor() {
      if (widget.disabled) {
        return widget.value ? aliasTokens.color.unselected.bg : Colors.transparent;
      }

      if (widget.inverse) {
        return widget.value ? aliasTokens.color.inverse.bgColor : Colors.transparent;
      }

      return widget.value ? aliasTokens.color.elements.bgColor06 : Colors.transparent;
    }

    Widget getLabel() {
      if (widget.label != null) {
        if (widget.inverse) {
          return Text(
            widget.label!,
            style: aliasTokens.mixin.labelMd1.merge(TextStyle(
              color: aliasTokens.color.inverse.labelColor,
            )),
          );
        }

        if (widget.disabled) {
          return Text(
            widget.label!,
            style: aliasTokens.mixin.labelMd1.merge(TextStyle(
              color: aliasTokens.color.disabled.labelColor,
            )),
          );
        }

        return Text(
          widget.label!,
          style: aliasTokens.mixin.labelMd1.merge(
            TextStyle(
              color: aliasTokens.color.text.labelColor,
            ),
          ),
        );
      } else {
        return const SizedBox.shrink();
      }
    }

    double getOpacity() {
      if (widget.disabled) return aliasTokens.color.disabled.opacity;

      return _isPressed ? aliasTokens.color.pressed.containerOpacity : 1;
    }

    Color getBorderColor() {
      if (widget.inverse) {
        return aliasTokens.color.inverse.borderColor;
      }

      if (widget.disabled) {
        return aliasTokens.color.disabled.borderColor;
      }

      return widget.value ? aliasTokens.color.selected.bgColor : aliasTokens.color.unselected.border;
    }

    Color getPressedColor() {
      return widget.inverse ? aliasTokens.mixin.pressedOutlineInverse : aliasTokens.mixin.pressedOutline;
    }

    bool labelIsNotEmpty = widget.label != null && widget.label!.isNotEmpty;

    return Semantics(
      label: widget.semanticsLabel,
      toggled: widget.value,
      enabled: !widget.disabled,
      child: GestureDetector(
        onTap: () => _onPressed(!widget.value),
        onTapDown: (details) => _onTap(true),
        onTapUp: (details) => _onTap(false),
        onTapCancel: () => _onTap(false),
        child: Opacity(
          opacity: getOpacity(),
          child: Container(
            height: 48,
            width: labelIsNotEmpty ? null : 56,
            color: Colors.transparent,
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.centerLeft,
              children: [
                //
                // Pressed
                if (_isPressed)
                  Positioned(
                    left: -spacing.s1x,
                    child: Container(
                      key: const Key('switch.pressed'),
                      height: size.s3x + spacing.s2x,
                      width: size.s5x + spacing.s2x,
                      decoration: BoxDecoration(
                        color: getPressedColor(),
                        borderRadius: BorderRadius.circular(
                          border.radiusCircular,
                        ),
                      ),
                    ),
                  ),

                //
                Wrap(
                  spacing: labelIsNotEmpty ? size.s1x : 0,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    AnimatedContainer(
                      key: const Key('switch.background'),
                      duration: globalTokens.motions.durations.moderate02,
                      padding: EdgeInsets.symmetric(
                        horizontal: spacing.half,
                      ),
                      width: size.s5x,
                      height: size.s3x,
                      decoration: BoxDecoration(
                        color: getBackgroundColor(),
                        borderRadius: BorderRadius.circular(
                          border.radiusCircular,
                        ),
                        border: Border.all(
                          width: aliasTokens.defaultt.borderWidth,
                          color: getBorderColor(),
                        ),
                      ),
                    ),
                    getLabel(),
                  ],
                ),

                //
                _Dot(
                  positionDot: _positionDot,
                  disabled: widget.disabled,
                  inverse: widget.inverse,
                  value: widget.value,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  final double positionDot;
  final bool disabled;
  final bool inverse;
  final bool value;

  const _Dot({
    required this.positionDot,
    required this.disabled,
    required this.inverse,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final tokens = Provider.of<ExpenseThemeManager>(context);
    final globalTokens = tokens.globals;
    final aliasTokens = tokens.alias;

    final size = globalTokens.shapes.size;
    final aliasInverse = aliasTokens.color.inverse;
    final aliasDisabled = aliasTokens.color.disabled;

    Color getDotColor() {
      if (inverse) {
        return value ? aliasInverse.onBgColor : aliasInverse.bgColor;
      }

      if (disabled) {
        return value ? aliasDisabled.onBgColor : aliasDisabled.bgColor;
      }

      return value ? aliasTokens.color.selected.onBgColor : aliasTokens.color.unselected.bg;
    }

    return AnimatedPositioned(
      duration: globalTokens.motions.durations.moderate02,
      top: 16,
      left: positionDot,
      child: Container(
        width: size.s2x,
        height: size.s2x,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            globalTokens.shapes.border.radiusCircular,
          ),
          color: getDotColor(),
        ),
      ),
    );
  }
}
