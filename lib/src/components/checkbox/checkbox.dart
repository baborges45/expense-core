import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:expense_core/core.dart';
import 'package:provider/provider.dart';

class ExpenseCheckbox extends StatefulWidget {
  ///(Optional) A boolean indicating whether the checkbox should be disabled. The default value is false.
  final bool disabled;

  ///(Optional) A string representing the label text to be displayed next to the checkbox.
  final String? label;

  ///(Optional) A boolean representing the current value of the checkbox.
  ///null indicates an indeterminate state. The default value is null.
  final bool? value;

  ///A required callback that will be called when the value of the checkbox changes.
  final ValueChanged<bool> onChanged;

  ///(Optional) A boolean parameter that specifies whether the link should have an inverse color scheme.
  ///The default value is false.
  final bool inverse;

  ///A string value that indicates if you add more information from accessibility
  ///The default value is null
  final String? semanticsLabel;

  ///A string value that indicates if you add more information from accessibility
  ///The default value is null
  final String? semanticsHint;

  ///A boolean value that indicates if you want ignore auto accessibility from widget
  ///The default value is false
  final bool excludeSemantics;

  const ExpenseCheckbox({
    super.key,
    required this.onChanged,
    this.disabled = false,
    this.inverse = false,
    this.label,
    this.value,
    this.semanticsLabel,
    this.semanticsHint,
    this.excludeSemantics = false,
  });

  @override
  State<ExpenseCheckbox> createState() => _ExpenseCheckboxState();
}

class _ExpenseCheckboxState extends State<ExpenseCheckbox> {
  bool _isPressed = false;

  void _onPressed(bool value) {
    setState(() {
      _isPressed = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    var tokens = Provider.of<ExpenseThemeManager>(context);
    var globalTokens = tokens.globals;
    var aliasTokens = tokens.alias;

    Color getBorderColor() {
      if (widget.inverse) return aliasTokens.color.inverse.borderColor;
      if (widget.disabled) return aliasTokens.color.disabled.borderColor;

      if (widget.value == null || widget.value == true) {
        return aliasTokens.color.selected.borderColor;
      }

      return aliasTokens.color.unselected.border;
    }

    Color? getBackgroundColor() {
      if (widget.inverse) {
        return widget.value == true || widget.value == null ? aliasTokens.color.inverse.bgColor : null;
      }

      if (widget.disabled) {
        return widget.value == true || widget.value == null ? aliasTokens.color.disabled.bgColor : null;
      }

      return widget.value == true || widget.value == null ? aliasTokens.color.selected.bgColor : null;
    }

    double getOpacity() {
      if (widget.disabled) return aliasTokens.color.disabled.opacity;

      return _isPressed ? aliasTokens.color.pressed.containerOpacity : 1;
    }

    Color getIconColor() {
      if (widget.inverse) return aliasTokens.color.inverse.onIconColor;
      if (widget.disabled) return aliasTokens.color.disabled.onIconColor;

      return aliasTokens.color.selected.onIconColor;
    }

    Widget? getLabel() {
      if (widget.label != null) {
        if (widget.inverse) {
          return ExpenseParagraph(
            widget.label!,
            size: ExpenseParagraphSize.sm,
          );
        }

        if (widget.disabled) {
          return ExpenseParagraph(
            widget.label!,
            size: ExpenseParagraphSize.sm,
          );
        }

        return ExpenseParagraph(
          widget.label!,
          size: ExpenseParagraphSize.sm,
        );
      } else {
        return const SizedBox.shrink();
      }
    }

    ExpenseIcon? getIcon() {
      if (widget.value == null) {
        return ExpenseIcon(
          icon: ExpenseIcons.minusLine,
          color: getIconColor(),
          size: ExpenseIconSize.sm,
        );
      }
      if (widget.value == false) return null;

      return ExpenseIcon(
        icon: ExpenseIcons.checkLine,
        color: getIconColor(),
        size: ExpenseIconSize.sm,
      );
    }

    Color getPressedColor() {
      return widget.inverse ? aliasTokens.mixin.pressedOutlineInverse : aliasTokens.mixin.pressedOutline;
    }

    Widget onPressAnimation() {
      var size = globalTokens.shapes.size.s6x;

      return _isPressed && !widget.disabled
          ? Positioned(
              left: -14,
              bottom: -14,
              child: Container(
                key: const Key('checkbox.animation'),
                width: size,
                height: size,
                decoration: BoxDecoration(
                  color: getPressedColor(),
                  borderRadius: BorderRadius.circular(
                    globalTokens.shapes.border.radiusCircular,
                  ),
                ),
              ),
            )
          : const SizedBox(height: 0, width: 0);
    }

    bool labelIsNotEmpty = widget.label != null && widget.label!.isNotEmpty;

    void onPressed() {
      final value = widget.value;
      final onChanged = widget.onChanged;
      final semantics = value == false ? 'checked' : 'not checked';

      if (widget.disabled) return;

      if (value == null) {
        onChanged(true);
        SemanticsService.announce(semantics, TextDirection.ltr);
      } else {
        onChanged(!value);
        SemanticsService.announce(semantics, TextDirection.ltr);
      }
    }

    double opacity = getOpacity();
    double size = globalTokens.shapes.size.s2_5x;

    return Semantics(
      checked: widget.value,
      enabled: !widget.disabled,
      label: widget.semanticsLabel,
      hint: widget.semanticsHint,
      excludeSemantics: widget.excludeSemantics,
      child: GestureDetector(
        onTap: onPressed,
        onTapDown: (details) => _onPressed(true),
        onTapUp: (details) => _onPressed(false),
        onTapCancel: () => _onPressed(false),
        child: Container(
          width: labelIsNotEmpty ? null : 48,
          color: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  onPressAnimation(),
                  Opacity(
                    opacity: opacity,
                    child: Container(
                      key: const Key('checkbox.background'),
                      height: size,
                      width: size,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: getBorderColor(),
                          width: aliasTokens.defaultt.borderWidth,
                        ),
                        color: getBackgroundColor(),
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            globalTokens.shapes.border.radiusXs,
                          ),
                        ),
                      ),
                      child: getIcon(),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: labelIsNotEmpty ? globalTokens.shapes.size.s1x : 0,
              ),
              Expanded(
                child: Opacity(
                  opacity: opacity,
                  child: getLabel(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
