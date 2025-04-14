import 'package:flutter/material.dart';
import 'package:expense_core/core.dart';
import 'package:provider/provider.dart';

import 'widgets/input_control.dart';
import 'widgets/line_blink_widget.dart';

class ExpenseInputCodeLine extends StatefulWidget {
  ///An integer representing the number of items in the input code field.
  final int itemsCount;

  ///A string representing the current value of the input code field.
  final String value;

  ///A callback function that will be called when the value of the input code field changes.
  ///It takes a string parameter representing the new value.
  final ValueChanged<String> onChanged;

  ///A string representing a description for the input code field.
  final String description;

  ///(Optional) A [ExpenseInputCodeController] object that can be used to control the input code field.
  final ExpenseInputCodeController? controller;

  ///(Optional) A  callback function that will be called when the input code field is finished
  ///(e.g., when all items have been filled).
  final ValueChanged<bool>? onFinished;

  ///A boolean indicating whether the input code should be obscured
  ///(e.g., for password input).
  final bool obscureText;

  ///A boolean indicating whether the input code field should automatically receive focus.
  final bool autofocus;

  ///(Optional) A [FocusNode] object representing the focus node for the input code field.
  final FocusNode? focusNode;

  ///(Optional) A [TextInputType] object representing the type of keyboard to use for the input code field.
  final TextInputType? keyboardType;

  ///(Optional) A [TextCapitalization] object representing the capitalization behavior for the input code field.
  final TextCapitalization? textCapitalization;

  ///(Optional) A string value that indicates if you add more information from accessibility
  ///The default value is null
  final String? semanticsLabel;

  ///(Optional) A string value that indicates if you add more information from accessibility
  ///The default value is null
  final String? semanticsHint;

  const ExpenseInputCodeLine({
    super.key,
    required this.value,
    required this.onChanged,
    this.itemsCount = 3,
    this.description = '',
    this.controller,
    this.onFinished,
    this.focusNode,
    this.obscureText = false,
    this.autofocus = false,
    this.keyboardType = TextInputType.number,
    this.textCapitalization,
    this.semanticsLabel,
    this.semanticsHint,
  });

  @override
  State<ExpenseInputCodeLine> createState() => _ExpenseInputCodeLineState();
}

class _ExpenseInputCodeLineState extends State<ExpenseInputCodeLine> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    var aliasTokens = Provider.of<ExpenseThemeManager>(context).alias;

    int getItemsCount() {
      if (widget.itemsCount > 6) return 6;
      if (widget.itemsCount < 3) return 3;

      return widget.itemsCount;
    }

    Color getBackgroundColor() {
      return _isPressed ? aliasTokens.mixin.pressedOutline : Colors.transparent;
    }

    return Semantics(
      explicitChildNodes: true,
      child: GestureDetector(
        onTapDown: (details) => setState(() => _isPressed = true),
        onTapUp: (details) => setState(() => _isPressed = false),
        onTapCancel: () => setState(() => _isPressed = false),
        child: InputCodeControl(
          itemsCount: getItemsCount(),
          value: widget.value,
          onChanged: widget.onChanged,
          description: widget.description,
          controller: widget.controller,
          onFinished: widget.onFinished,
          autofocus: widget.autofocus,
          focusNode: widget.focusNode,
          keyboardType: widget.keyboardType,
          textCapitalization: widget.textCapitalization,
          semanticsLabel: widget.semanticsHint,
          semanticsHint: widget.semanticsHint,
          onRender: (onFocus, text, actived, focused) {
            //
            // Return box from input
            return _Box(
              onPressed: onFocus,
              label: text,
              obscureText: widget.obscureText,
              actived: actived,
              backgroundColor: getBackgroundColor(),
              focused: focused,
            );
          },
        ),
      ),
    );
  }
}

class _Box extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final bool obscureText;
  final bool actived;
  final bool focused;
  final Color backgroundColor;

  const _Box({
    required this.onPressed,
    required this.label,
    required this.obscureText,
    required this.actived,
    required this.focused,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    var tokens = Provider.of<ExpenseThemeManager>(context);
    var globalTokens = tokens.globals;
    var aliasTokens = tokens.alias;
    var size = globalTokens.shapes.size;

    Widget getWidgetRender() {
      if (obscureText && label.isNotEmpty) {
        return Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: aliasTokens.color.active.placeholderColor,
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }

      if (actived && focused) {
        return const LineBlinkWidget();
      }

      return Text(
        label,
        style: TextStyle(
          color: aliasTokens.color.active.placeholderColor,
          fontSize: globalTokens.typographys.fontSizeSm,
          fontWeight: globalTokens.typographys.fontWeightRegular,
          fontFamily: globalTokens.typographys.fontFamilyBase,
        ),
      );
    }

    Color getBorderColor() {
      return actived && focused ? aliasTokens.color.active.borderColor : aliasTokens.color.elements.borderColor;
    }

    return Row(
      children: [
        GestureDetector(
          onTap: onPressed,
          child: Container(
            height: size.s7x,
            width: size.s5x,
            decoration: BoxDecoration(
              color: backgroundColor,
              border: Border(
                bottom: BorderSide(
                  width: aliasTokens.defaultt.borderWidth,
                  color: getBorderColor(),
                ),
              ),
            ),
            child: Center(
              child: getWidgetRender(),
            ),
          ),
        ),
        SizedBox(
          width: globalTokens.shapes.spacing.s1x,
        ),
      ],
    );
  }
}
