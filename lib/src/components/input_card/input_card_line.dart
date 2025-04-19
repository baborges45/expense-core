import 'package:flutter/material.dart';
import 'package:expense_core/core.dart';
import 'package:provider/provider.dart';

import 'widgets/input_support_text_widget.dart';
import 'widgets/input_widget.dart';

class ExpenseInputCardLine extends StatefulWidget {
  ///A string that represents the label for the password field.
  final String label;

  ///(Optional) A string that represents support text for the password field.
  final String? supportText;

  /// A boolean indicating whether the password field is disabled.
  ///The default value is false.
  final bool disabled;

  ///A boolean indicating whether the password field has an error.
  ///The default value is false.
  final bool hasError;

  ///(Optional) A TextEditingController object that can be used to control the password field.
  final TextEditingController? controller;

  ///(Optional) A [FocusNode] object that represents the focus node for the password field
  final FocusNode? focusNode;

  ///(Optional) A optional [TextInputType] object that represents the type of keyboard
  ///to be used for the password field.
  final TextInputType? keyboardType;

  ///A boolean indicating whether the password field is read-only.
  ///The default value is false.
  final bool readOnly;

  ///A boolean indicating whether the password field should automatically receive focus.
  ///The default value is false.
  final bool autofocus;

  ///A boolean indicating whether autocorrection is enabled for the password field.
  ///The default value is true.
  final bool autocorrect;

  ///A callback function that will be called when the value of the password field is changed.
  ///It takes a string parameter representing the new value.
  final ValueChanged<String>? onChanged;

  ///(Optional) A callback function that will be called when the editing of the password field is completed.
  final VoidCallback? onEditingComplete;

  ///(Optional) A callback function that will be called when the user submits the password field.
  final ValueChanged<String>? onSubmitted;

  ///(Optional) A [TextInputAction] object representing the action to be taken by the keyboard when the
  ///user interacts with the password field.
  final TextInputAction? textInputAction;

  ///A string value that provides a descriptive label for accessibility purposes.
  ///The default value is null
  final String? semanticsLabel;

  ///A string value that indicates additional accessibility information.
  ///The default value is null
  final String? semanticsHint;

  ///(Optional) A [ExpenseInputCardType] enum representing the type render this widget [card], [validate], [cvv]
  ///The default value is [card]
  final ExpenseInputCardType type;

  ///(Optional) A callback function that will be called when the user pressed question icon.
  ///Ps: This widget rendered just if type is [validate] and [cvv]
  final VoidCallback? onQuestion;

  const ExpenseInputCardLine({
    super.key,
    required this.label,
    this.supportText,
    this.disabled = false,
    this.hasError = false,
    this.onQuestion,

    // Input control
    this.controller,
    this.focusNode,
    this.keyboardType,
    this.readOnly = false,
    this.autofocus = false,
    this.autocorrect = true,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.textInputAction,
    this.type = ExpenseInputCardType.card,

    // Accessibility
    this.semanticsLabel,
    this.semanticsHint,
  });

  @override
  State<ExpenseInputCardLine> createState() => _ExpenseInputCardState();
}

class _ExpenseInputCardState extends State<ExpenseInputCardLine> {
  bool _isPressed = false;
  bool _isFocussed = false;
  bool _isFilled = false;

  late TextEditingController _controller;
  late FocusNode _focusNode;

  _onPressedDown(_) {
    if (widget.disabled) return;
    setState(() => _isPressed = true);
  }

  _onPressedUp(_) {
    if (widget.disabled) return;
    setState(() => _isPressed = false);
  }

  @override
  void initState() {
    super.initState();

    _controller = widget.controller ?? TextEditingController();
    _focusNode = widget.focusNode ?? FocusNode();

    _focusNode.addListener(() {
      setState(() {
        _isFocussed = _focusNode.hasFocus;
      });
    });

    _controller.addListener(() {
      setState(() {
        _isFilled = _controller.text.isNotEmpty;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var tokens = Provider.of<ExpenseThemeManager>(context);
    var globalTokens = tokens.globals;
    var aliasTokens = tokens.alias;
    var opacity = globalTokens.shapes.opacity;

    Color getBackgroundColor() {
      return _isPressed ? aliasTokens.mixin.pressedOutline : Colors.transparent;
    }

    Color getTextColor() {
      if (widget.disabled) {
        return aliasTokens.color.disabled.labelColor;
      }

      if (widget.hasError) {
        return aliasTokens.color.negative.placeholderColor;
      }

      return _isFilled || _isFocussed ? aliasTokens.color.active.placeholderColor : aliasTokens.color.text.placeholderColor;
    }

    Color getBorderColor() {
      if (widget.disabled) {
        return aliasTokens.color.disabled.borderColor;
      }

      if (widget.hasError) {
        return aliasTokens.color.negative.borderColor;
      }

      return _isFocussed ? aliasTokens.color.active.borderColor : aliasTokens.color.elements.borderColor;
    }

    Color getLabelColor() => widget.hasError ? aliasTokens.color.negative.labelColor : aliasTokens.color.text.onLabelColor;

    TextStyle? getLabelStyle() {
      Color color = getLabelColor();

      if (widget.disabled) {
        color = aliasTokens.color.disabled.labelColor;
      }

      return _isFocussed || _isFilled
          ? aliasTokens.mixin.labelSm2.merge(TextStyle(color: color))
          : aliasTokens.mixin.labelLg2.merge(TextStyle(color: color));
    }

    double getOpacity() {
      if (widget.disabled) {
        return aliasTokens.color.disabled.opacity;
      }

      return _isPressed ? opacity.superHigh : 1;
    }

    final textColor = getTextColor();

    return Semantics(
      textField: true,
      explicitChildNodes: true,
      child: Opacity(
        opacity: getOpacity(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            //
            // Input
            GestureDetector(
              onTapDown: _onPressedDown,
              onTapUp: _onPressedUp,
              onTapCancel: () => _onPressedUp(null),
              child: Container(
                key: const Key('input-card.container'),
                height: globalTokens.shapes.size.s8x,
                width: double.maxFinite,
                padding: const EdgeInsets.symmetric(
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: getBackgroundColor(),
                  border: Border(
                    bottom: BorderSide(
                      width: aliasTokens.defaultt.borderWidth,
                      color: getBorderColor(),
                    ),
                  ),
                ),
                child: Stack(
                  children: [
                    //
                    // Textfield
                    Semantics(
                      textField: true,
                      enabled: !widget.disabled,
                      label: widget.semanticsLabel,
                      hint: widget.semanticsHint,
                      excludeSemantics: true,
                      child: InputWidget(
                        controller: _controller,
                        focusNode: _focusNode,
                        textColor: textColor,
                        placeholder: '',
                        disabled: widget.disabled,
                        hasError: widget.hasError,
                        readOnly: widget.readOnly,
                        autofocus: widget.autofocus,
                        autocorrect: widget.autocorrect,
                        onChanged: widget.onChanged,
                        keyboardType: widget.keyboardType,
                        textInputAction: widget.textInputAction,
                        label: Text(widget.label, style: getLabelStyle()),
                        labelStyle: TextStyle(color: textColor),
                        iconColor: getLabelColor(),
                        type: widget.type,
                        onQuestion: widget.onQuestion,
                        isPressed: _isPressed,
                        addOpacityBody: true,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Support Text
            ExcludeSemantics(
              excluding: widget.disabled,
              child: InputSupportTextWidget(
                text: widget.supportText,
                disabled: widget.disabled,
                hasError: widget.hasError,
                addOpacityBody: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
