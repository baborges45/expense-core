import 'package:flutter/material.dart';
import 'package:expense_core/core.dart';
import 'package:provider/provider.dart';

import 'widgets/select.dart';
import 'widgets/select_icon_widget.dart';
import 'widgets/select_support_text_widget.dart';

class ExpenseInputSelectLine extends StatefulWidget {
  ///A string representing the label for the select field.
  final String label;

  ///(Optional) A string representing support text for the select field.
  final String? supportText;

  ///A list of [ExpenseInputSelectItem] objects representing the selectable items in the select field.
  final List<ExpenseInputSelectItem> items;

  ///(Optional) A [ExpenseInputSelectItem] object representing the currently selected value.
  final ExpenseInputSelectItem? value;

  ///A callback function that will be called when the value of the select field changes.
  ///It returns a [ExpenseInputSelectItem] parameter representing the new selected value.
  final ValueChanged<ExpenseInputSelectItem> onChanged;

  ///A string representing the placeholder text for the select field.
  ///The default value is Selecione um item.
  final String placeholder;

  ///A boolean indicating whether the select field is disabled.
  ///The default value is false.
  final bool disabled;

  ///A boolean indicating whether the select field has an error.
  ///The default value is false.
  final bool hasError;
  const ExpenseInputSelectLine({
    super.key,
    required this.label,
    required this.items,
    required this.value,
    required this.onChanged,
    this.placeholder = 'Selecione um item',
    this.supportText,
    this.disabled = false,
    this.hasError = false,
  });

  @override
  State<ExpenseInputSelectLine> createState() => _ExpenseInputSelectLineState();
}

class _ExpenseInputSelectLineState extends State<ExpenseInputSelectLine> {
  bool _isPressed = false;
  bool _isActive = false;

  _onPressedDown(_) {
    setState(() => _isPressed = true);
  }

  _onPressedUp(_) {
    setState(() => _isPressed = false);
  }

  _onPressed() async {
    if (widget.disabled) return;

    setState(() => _isActive = true);

    Select.open(
      context: context,
      items: widget.items,
      onInit: () => setState(() => _isActive = true),
      onChanged: (v) => widget.onChanged(v),
      onFinish: () => setState(() => _isActive = false),
      value: widget.value,
    );
  }

  @override
  Widget build(BuildContext context) {
    var tokens = Provider.of<ExpenseThemeManager>(context);
    var globalTokens = tokens.globals;
    var aliasTokens = tokens.alias;

    Color getBackgroundColor() {
      return _isPressed ? aliasTokens.mixin.pressedOutline : aliasTokens.color.elements.bgColor01;
    }

    Color getTextColor() {
      if (widget.disabled) {
        return aliasTokens.color.disabled.placeholderColor;
      }

      if (widget.hasError) {
        return aliasTokens.color.negative.placeholderColor;
      }

      return _isActive || widget.value != null ? aliasTokens.color.active.placeholderColor : aliasTokens.color.text.placeholderColor;
    }

    Color getBorderColor() {
      if (widget.disabled) {
        return aliasTokens.color.disabled.borderColor;
      }

      if (widget.hasError) {
        return aliasTokens.color.negative.borderColor;
      }

      return _isActive ? aliasTokens.color.active.borderColor : aliasTokens.color.elements.borderColor;
    }

    Widget getPlaceholder() {
      if (widget.value == null) return const SizedBox.shrink();

      bool isLabel = widget.value?.label != null;

      String placeholder = isLabel ? widget.value!.label : widget.placeholder;
      TextStyle labelMixin = isLabel ? aliasTokens.mixin.labelLg2 : aliasTokens.mixin.placeholder;

      double spacing = 10 + globalTokens.shapes.spacing.s1x;

      return Container(
        margin: EdgeInsets.only(top: spacing),
        child: Text(
          placeholder,
          style: labelMixin.merge(
            TextStyle(
              color: getTextColor(),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      );
    }

    Color getLabelColor() {
      if (widget.disabled) {
        return aliasTokens.color.disabled.labelColor;
      }

      if (widget.hasError) {
        return aliasTokens.color.negative.labelColor;
      }

      return _isActive || widget.value != null ? aliasTokens.color.active.labelColor : aliasTokens.color.text.labelColor;
    }

    Widget getLabel() {
      TextStyle sizeLabel = widget.value == null ? aliasTokens.mixin.labelLg2 : aliasTokens.mixin.labelSm2;

      return Text(
        widget.label,
        style: sizeLabel.merge(
          TextStyle(color: getLabelColor()),
        ),
      );
    }

    double getOpacity() {
      if (widget.disabled) {
        return aliasTokens.color.disabled.opacity;
      }

      return widget.disabled ? globalTokens.shapes.opacity.low : 1;
    }

    return Semantics(
      button: true,
      enabled: !widget.disabled,
      child: GestureDetector(
        onTap: _onPressed,
        onTapDown: _onPressedDown,
        onTapUp: _onPressedUp,
        onTapCancel: () => _onPressedUp(null),
        child: Opacity(
          opacity: getOpacity(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //
              // Select
              Container(
                height: globalTokens.shapes.size.s8x,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: getBackgroundColor(),
                  border: Border(
                    bottom: BorderSide(
                      width: aliasTokens.defaultt.borderWidth,
                      color: getBorderColor(),
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Stack(
                        children: [
                          getLabel(),
                          getPlaceholder(),
                        ],
                      ),
                    ),

                    // Icon Select
                    SelectIconWidget(
                      actived: _isActive,
                      disabled: widget.disabled,
                      hasError: widget.hasError,
                    ),
                  ],
                ),
              ),

              // Support Text
              SelectSupportTextWidget(
                text: widget.supportText,
                disabled: widget.disabled,
                hasError: widget.hasError,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
