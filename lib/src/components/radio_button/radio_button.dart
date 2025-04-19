import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:expense_core/core.dart';
import 'package:provider/provider.dart';

class ExpenseRadioButton<T> extends StatefulWidget {
  ///The value corresponding to this ExpenseRadioButton.
  ///This is the value that is assigned to the group when this ExpenseRadioButton is selected.
  final T value;

  ///A string text that appears next to the ExpenseRadioButton.
  final String? label;

  ///A dinymic value currently selected by the group of ExpenseRadioButtons.
  ///If this [ExpenseRadioButton] has the same value as groupValue, it will be selected.
  final T? groupValue;

  ///A callback function called when this ExpenseRadioButton is selected.
  ///The function returns the newly selected value.
  final ValueChanged<T?>? onChanged;

  ///A boolean value that specifies whether the widget is disabled or not.
  ///The default value is false.
  final bool disabled;

  ///A boolean indicating whether the banner is inverse or not for stylish.
  ///The default value is false.
  final bool inverse;

  ///A string value that indicates if you add more information from accessibility
  ///The default value is null
  final String? semanticsLabel;

  const ExpenseRadioButton({
    Key? key,
    required this.value,
    required this.onChanged,
    this.label,
    this.groupValue,
    this.disabled = false,
    this.inverse = false,
    this.semanticsLabel,
  }) : super(key: key);

  bool get _selected => value == groupValue;

  @override
  State<ExpenseRadioButton> createState() => _MyWidgetState<T>();
}

class _MyWidgetState<T> extends State<ExpenseRadioButton<T>> {
  bool isPressed = false;

  void _onPressed(bool value) {
    setState(() {
      isPressed = value;
    });
  }

  void _onChanged(bool selected) {
    if (!widget.disabled) {
      if (selected) {
        widget.onChanged!(widget.value);
      }
    }
    context.findRenderObject()!.sendSemanticsEvent(const TapSemanticEvent());
  }

  @override
  Widget build(BuildContext context) {
    var tokens = Provider.of<ExpenseThemeManager>(context);
    var globalTokens = tokens.globals;
    var aliasTokens = tokens.alias;
    var size = globalTokens.shapes.size.s2_5x;
    final EdgeInsets marginContainer = widget.label != null ? EdgeInsets.only(right: globalTokens.shapes.spacing.s1x) : EdgeInsets.zero;

    Widget? getLabel() {
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
            key: const Key('radio_button.label_disabled'),
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
      }

      return null;
    }

    Widget? fillContainer() {
      var size = globalTokens.shapes.size.s1x;

      Color color = !widget.disabled ? aliasTokens.color.selected.onIconColor : aliasTokens.color.disabled.onIconColor;

      if (widget.inverse) {
        color = aliasTokens.color.inverse.onIconColor;
      }

      return widget._selected
          ? Container(
              height: size,
              width: size,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(
                  globalTokens.shapes.border.radiusCircular,
                ),
              ),
            )
          : null;
    }

    Color getColorFillContainer() {
      if (widget.inverse) {
        return widget._selected ? aliasTokens.color.inverse.bgColor : Colors.transparent;
      }

      if (widget.disabled && widget._selected) {
        return aliasTokens.color.disabled.bgColor;
      }

      return widget._selected ? aliasTokens.color.selected.bgColor : Colors.transparent;
    }

    Color getBorderContainer() {
      if (widget.inverse) return aliasTokens.color.inverse.borderColor;
      if (widget.disabled) return aliasTokens.color.disabled.borderColor;

      return widget._selected ? aliasTokens.color.selected.borderColor : aliasTokens.color.unselected.border;
    }

    double getOpacity() {
      if (widget.disabled) return aliasTokens.color.disabled.opacity;

      return isPressed ? aliasTokens.color.pressed.containerOpacity : 1;
    }

    Color getPressedColor() {
      return widget.inverse ? aliasTokens.mixin.pressedOutlineInverse : aliasTokens.mixin.pressedOutline;
    }

    Widget onPressAnimation() {
      var size = globalTokens.shapes.size.s6x;

      return isPressed && !widget.disabled
          ? Container(
              key: const Key('radio_button.animation'),
              width: size,
              height: size,
              decoration: BoxDecoration(
                color: getPressedColor(),
                borderRadius: BorderRadius.circular(
                  globalTokens.shapes.border.radiusCircular,
                ),
              ),
            )
          : const SizedBox(height: 0, width: 0);
    }

    bool labelIsNotEmpty = widget.label != null && widget.label!.isNotEmpty;

    var opacity = getOpacity();

    return Semantics(
      label: widget.semanticsLabel,
      checked: widget._selected,
      inMutuallyExclusiveGroup: true,
      enabled: !widget.disabled,
      liveRegion: true,
      child: GestureDetector(
        onTap: () => _onChanged(!widget._selected),
        onTapDown: (details) => _onPressed(true),
        onTapUp: (details) => _onPressed(false),
        onTapCancel: () => _onPressed(false),
        child: Container(
          height: 48,
          width: labelIsNotEmpty ? null : 48,
          color: Colors.transparent,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Positioned(
                left: labelIsNotEmpty ? -14 : 0,
                child: onPressAnimation(),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Opacity(
                    opacity: opacity,
                    child: Container(
                      key: const Key('radio_button.container'),
                      margin: marginContainer,
                      alignment: Alignment.center,
                      width: size,
                      height: size,
                      decoration: BoxDecoration(
                        color: getColorFillContainer(),
                        borderRadius: BorderRadius.circular(
                          globalTokens.shapes.border.radiusCircular,
                        ),
                        border: Border.all(
                          width: globalTokens.shapes.border.widthXs,
                          color: getBorderContainer(),
                        ),
                      ),
                      child: fillContainer(),
                    ),
                  ),
                  Opacity(
                    opacity: opacity,
                    child: getLabel(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
