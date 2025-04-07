import 'package:flutter/material.dart';
import 'package:mude_core/core.dart';
import 'package:provider/provider.dart';

import 'widgets/input_password_error_icon.dart';
import 'widgets/input_password_icon_widget.dart';
import 'widgets/input_password_support_text_widget.dart';

class MudeInputPasswordLine extends StatefulWidget {
  ///A string that represents the label for the password field.
  final String label;

  ///(Optional) A string that represents support text for the password field.
  final String? supportText;

  /// A boolean indicating whether the password field is disabled.
  final bool disabled;

  ///A boolean indicating whether the password field has an error.
  final bool hasError;

  ///(Optional) A TextEditingController object that can be used to control the password field.
  final TextEditingController? controller;

  ///(Optional) A [FocusNode] object that represents the focus node for the password field
  final FocusNode? focusNode;

  ///(Optional) A optional [TextInputType] object that represents the type of keyboard
  ///to be used for the password field.
  final TextInputType? keyboardType;

  ///A boolean indicating whether the password field is read-only.
  final bool readOnly;

  ///A boolean indicating whether the password field should automatically receive focus.
  final bool autofocus;

  ///A boolean indicating whether autocorrection is enabled for the password field.
  final bool autocorrect;

  ///An int indicating how many characters limit this input has.
  final int? maxLength;

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

  const MudeInputPasswordLine({
    super.key,
    required this.label,
    this.supportText,
    this.disabled = false,
    this.hasError = false,

    // input control
    this.controller,
    this.focusNode,
    this.keyboardType,
    this.readOnly = false,
    this.autofocus = false,
    this.autocorrect = true,
    this.maxLength,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.textInputAction,

    // Accessibility
    this.semanticsLabel,
    this.semanticsHint,
  });

  @override
  State<MudeInputPasswordLine> createState() => _MudeInputTextLPasswordtate();
}

class _MudeInputTextLPasswordtate extends State<MudeInputPasswordLine> {
  bool _isPressed = false;
  bool _isFocussed = false;
  bool _isFilled = false;
  bool _isHide = true;

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
    var tokens = Provider.of<MudeThemeManager>(context);
    var globalTokens = tokens.globals;
    var aliasTokens = tokens.alias;
    var size = globalTokens.shapes.size;
    var defaultColor = aliasTokens.defaultt;

    Color getBackgroundColor() {
      return _isPressed
          ? aliasTokens.mixin.pressedOutline
          : aliasTokens.color.elements.bgColor01;
    }

    Color getTextColor() {
      if (widget.disabled) {
        return aliasTokens.color.disabled.placeholderColor;
      }

      if (widget.hasError) {
        return aliasTokens.color.negative.placeholderColor;
      }

      return _isFilled || _isFocussed
          ? aliasTokens.color.active.placeholderColor
          : aliasTokens.color.text.placeholderColor;
    }

    Color getLabelColor() => widget.hasError
        ? aliasTokens.color.negative.labelColor
        : aliasTokens.color.active.labelColor;

    TextStyle? getLabelStyle() {
      Color color = getLabelColor();

      if (widget.disabled) {
        color = aliasTokens.color.disabled.labelColor;
      }

      return _isFocussed || _isFilled
          ? aliasTokens.mixin.labelSm2.merge(
              TextStyle(
                color: color,
                fontSize: globalTokens.typographys.fontSize3xs * 1.333,
              ),
            )
          : aliasTokens.mixin.labelLg2.merge(TextStyle(color: color));
    }

    Color getBorderColor() {
      return widget.hasError
          ? aliasTokens.color.negative.borderColor
          : aliasTokens.color.elements.borderColor;
    }

    Color getBorderFocusColor() {
      return widget.hasError
          ? aliasTokens.color.negative.borderColor
          : aliasTokens.color.active.borderColor;
    }

    UnderlineInputBorder getBorderDiasbleColor() {
      return UnderlineInputBorder(
        borderSide: BorderSide(
          color: aliasTokens.color.disabled.borderColor,
          width: aliasTokens.defaultt.borderWidth,
        ),
      );
    }

    double getOpacity() {
      if (widget.disabled) {
        return aliasTokens.color.disabled.opacity;
      }

      return widget.disabled ? globalTokens.shapes.opacity.low : 1;
    }

    EdgeInsetsGeometry? getPaddingError() {
      if (!widget.hasError) return null;

      double spacingRight =
          widget.hasError ? (24 * 2) + globalTokens.shapes.spacing.s2x : 0;

      return EdgeInsets.only(right: spacingRight, bottom: 12, top: 12);
    }

    final textColor = getTextColor();

    final style = aliasTokens.mixin.placeholder.apply(
      color: textColor,
    );

    return MergeSemantics(
      child: Opacity(
        key: const Key('input-password.opacity'),
        opacity: getOpacity(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            //
            // Input
            Semantics(
              textField: true,
              enabled: !widget.disabled,
              obscured: _isHide,
              label: widget.semanticsLabel,
              hint: widget.semanticsHint,
              child: GestureDetector(
                onTapDown: _onPressedDown,
                onTapUp: _onPressedUp,
                onTapCancel: () => _onPressedUp(null),
                child: Container(
                  key: const Key('input-password.container'),
                  alignment: Alignment.bottomCenter,
                  height: size.s8x,
                  width: double.maxFinite,
                  decoration: BoxDecoration(color: getBackgroundColor()),
                  child: Stack(
                    clipBehavior: Clip.hardEdge,
                    fit: StackFit.expand,
                    children: [
                      //
                      // Textfield
                      TextField(
                        controller: _controller,
                        focusNode: _focusNode,
                        cursorColor: textColor,
                        style: style,
                        enabled: !widget.disabled,
                        obscureText: _isHide,
                        keyboardType: widget.keyboardType,
                        readOnly: widget.readOnly,
                        autofocus: widget.autofocus,
                        autocorrect: widget.autocorrect,
                        maxLength: widget.maxLength,
                        onChanged: widget.onChanged,
                        onEditingComplete: widget.onEditingComplete,
                        onSubmitted: widget.onSubmitted,
                        textInputAction: widget.textInputAction,
                        decoration: InputDecoration(
                          contentPadding: getPaddingError(),
                          label: Text(widget.label, style: getLabelStyle()),
                          labelStyle: style,
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: getBorderFocusColor(),
                              width: defaultColor.borderWidth,
                            ),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: getBorderColor(),
                              width: defaultColor.borderWidth,
                            ),
                          ),
                          disabledBorder: getBorderDiasbleColor(),
                        ),
                      ),

                      // Icon Error
                      Positioned(
                        right: 0,
                        top: -4,
                        child: Row(
                          children: [
                            Container(
                              alignment: Alignment.centerRight,
                              color: Colors.transparent,
                              height: size.s8x,
                              child: InputPasswordErrorIcon(
                                show: widget.hasError && !widget.disabled,
                              ),
                            ),

                            // Icon Password
                            InputPasswordIconWidget(
                              onPressed: () =>
                                  setState(() => _isHide = !_isHide),
                              hide: _isHide,
                              disabled: widget.disabled,
                              hasError: widget.hasError,
                              hasPaddingAll: false,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Support Text
            InputPasswordSupportTextWidget(
              text: widget.supportText,
              disabled: widget.disabled,
              hasError: widget.hasError,
            ),
          ],
        ),
      ),
    );
  }
}
