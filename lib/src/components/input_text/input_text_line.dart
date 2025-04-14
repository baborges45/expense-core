import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:expense_core/core.dart';
import 'package:provider/provider.dart';

import 'input_formatters/text_cellphone.dart';
import 'input_formatters/text_cep.dart';
import 'input_formatters/text_cnpj.dart';
import 'input_formatters/text_cpf.dart';
import 'widgets/input_error_icon.dart';
import 'widgets/input_support_text_widget.dart';

class ExpenseInputTextLine extends StatefulWidget {
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

  ///(Optional) A optional [TextCapitalization] object that represents capitalization strategy
  final TextCapitalization? textCapitalization;

  ///A boolean indicating whether the password field is read-only.
  ///The default value is false.
  final bool readOnly;

  ///A boolean indicating whether the password field should automatically receive focus.
  ///The default value is false.
  final bool autofocus;

  ///A boolean indicating whether autocorrection is enabled for the password field.
  ///The default value true.
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

  /// (Optional) A [ExpenseInputTextType] enum representing the type of text input for this widget: [cellphone], [cep], [cnpj], [cpf], or [text].
  /// The default value is [text].
  final ExpenseInputTextType type;

  const ExpenseInputTextLine({
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
    this.textCapitalization,

    // Accessibility
    this.semanticsLabel,
    this.semanticsHint,
    this.type = ExpenseInputTextType.text,
  });

  @override
  State<ExpenseInputTextLine> createState() => _ExpenseInputTextLineState();
}

class _ExpenseInputTextLineState extends State<ExpenseInputTextLine> {
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
    var size = globalTokens.shapes.size;
    var defaultColor = aliasTokens.defaultt;

    final Map<ExpenseInputTextType, List<TextInputFormatter>> inputFormatterMap = {
      ExpenseInputTextType.cellphone: [
        FilteringTextInputFormatter.digitsOnly,
        CellphoneInputFormatter(),
      ],
      ExpenseInputTextType.cep: [
        FilteringTextInputFormatter.digitsOnly,
        CEPInputFormatter(),
      ],
      ExpenseInputTextType.cnpj: [
        FilteringTextInputFormatter.digitsOnly,
        CNPJInputFormatter(),
      ],
      ExpenseInputTextType.cpf: [
        FilteringTextInputFormatter.digitsOnly,
        CPFInputFormatter(),
      ],
      ExpenseInputTextType.text: [],
    };

    final List<TextInputFormatter>? inputFormatters = inputFormatterMap[widget.type] ?? inputFormatterMap[ExpenseInputTextType.text];

    Color getBackgroundColor() {
      return _isPressed ? aliasTokens.mixin.pressedOutline : Colors.transparent;
    }

    Color getTextColor() {
      if (widget.disabled) {
        return aliasTokens.color.disabled.placeholderColor;
      }

      if (widget.hasError) {
        return aliasTokens.color.negative.placeholderColor;
      }

      return _isFilled || _isFocussed ? aliasTokens.color.active.placeholderColor : aliasTokens.color.text.placeholderColor;
    }

    TextStyle? getLabelStyle() {
      Color color = widget.hasError ? aliasTokens.color.negative.labelColor : aliasTokens.color.active.labelColor;

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
      if (widget.disabled) {
        return aliasTokens.color.disabled.borderColor;
      }

      return widget.hasError ? aliasTokens.color.negative.borderColor : aliasTokens.color.elements.borderColor;
    }

    Color getBorderFocusColor() {
      return widget.hasError ? aliasTokens.color.negative.borderColor : aliasTokens.color.active.borderColor;
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

      double spacingRight = widget.hasError ? (24 * 2) + globalTokens.shapes.spacing.s2x : 0;

      return EdgeInsets.only(right: spacingRight, bottom: 12, top: 12);
    }

    getKeyboardType() {
      if (widget.keyboardType != null) return widget.keyboardType;

      return widget.type == ExpenseInputTextType.text ? TextInputType.text : TextInputType.number;
    }

    final textColor = getTextColor();

    return MergeSemantics(
      child: Opacity(
        key: const Key('input-text.opacity'),
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
              label: widget.semanticsLabel,
              hint: widget.semanticsHint,
              child: GestureDetector(
                onTapDown: _onPressedDown,
                onTapUp: _onPressedUp,
                onTapCancel: () => _onPressedUp(null),
                child: Container(
                  key: const Key('input-text.container'),
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
                        style: aliasTokens.mixin.placeholder.apply(
                          color: textColor,
                        ),
                        textCapitalization: widget.textCapitalization ?? TextCapitalization.none,
                        enabled: !widget.disabled,
                        keyboardType: getKeyboardType(),
                        readOnly: widget.readOnly,
                        autofocus: widget.autofocus,
                        autocorrect: widget.autocorrect,
                        maxLength: widget.maxLength,
                        onChanged: widget.onChanged,
                        onEditingComplete: widget.onEditingComplete,
                        onSubmitted: widget.onSubmitted,
                        inputFormatters: inputFormatters,
                        textInputAction: widget.textInputAction,
                        decoration: InputDecoration(
                          contentPadding: getPaddingError(),
                          label: Text(widget.label, style: getLabelStyle()),
                          labelStyle: aliasTokens.mixin.labelSm2.apply(
                            color: textColor,
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: getBorderFocusColor(),
                              width: defaultColor.borderWidth,
                              strokeAlign: BorderSide.strokeAlignInside,
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
                        child: Container(
                          alignment: Alignment.centerRight,
                          color: Colors.transparent,
                          height: size.s8x,
                          child: InputErrorIcon(
                            show: widget.hasError && !widget.disabled,
                          ),
                        ),
                      ),
                    ],
                  ),
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
