import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mude_core/core.dart';
import 'package:provider/provider.dart';

import '../input_formatters/card_flags.dart';
import '../input_formatters/card_month.dart';
import '../input_formatters/card_number.dart';
import 'input_credit_card_widget.dart';
import 'input_error_icon.dart';
import 'input_question_icon.dart';

class InputWidget extends StatelessWidget {
  // Layout Control
  final Color textColor;
  final Color? iconColor;
  final bool disabled;
  final bool hasError;

  // Input Control
  final TextEditingController controller;
  final FocusNode focusNode;
  final TextInputType? keyboardType;
  final bool readOnly;
  final bool autofocus;
  final bool autocorrect;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onSubmitted;
  final String? placeholder;
  final TextInputAction? textInputAction;
  final Widget? label;
  final TextStyle? labelStyle;
  final MudeInputCardType type;
  final VoidCallback? onQuestion;
  final bool isPressed;
  final bool addOpacityBody;

  const InputWidget({
    super.key,
    required this.textColor,
    required this.placeholder,
    required this.disabled,
    required this.hasError,
    this.iconColor,
    this.onQuestion,
    this.isPressed = false,
    this.addOpacityBody = false,

    // Input
    required this.controller,
    required this.focusNode,
    required this.readOnly,
    required this.autofocus,
    required this.autocorrect,
    this.keyboardType,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.textInputAction,
    this.label,
    this.labelStyle,
    this.type = MudeInputCardType.card,
  });

  @override
  Widget build(BuildContext context) {
    var tokens = Provider.of<MudeThemeManager>(context);
    var globalTokens = tokens.globals;
    var aliasTokens = tokens.alias;

    final Map<MudeInputCardType, List<TextInputFormatter>> inputFormatterMap = {
      MudeInputCardType.card: [
        FilteringTextInputFormatter.digitsOnly,
        CardNumberInputFormatter(),
        LengthLimitingTextInputFormatter(19),
      ],
      MudeInputCardType.validate: [
        FilteringTextInputFormatter.digitsOnly,
        CardMonthInputFormatter(),
        LengthLimitingTextInputFormatter(5),
      ],
      MudeInputCardType.cvv: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(3),
      ],
    };

    final List<TextInputFormatter>? inputFormatters =
        inputFormatterMap[type] ?? inputFormatterMap[MudeInputCardType.card];

    final MudeFlagData? cardFlag = CardFlags.getCardFlag(controller.text);

    final positionIconError = type != MudeInputCardType.card ? 30.0 : 0.0;

    final opacityBody =
        disabled && addOpacityBody ? globalTokens.shapes.opacity.low : 1.0;

    TextStyle getPlaceholderStyle() {
      return aliasTokens.mixin.placeholder.merge(
        TextStyle(color: textColor),
      );
    }

    final placeholderStyle = getPlaceholderStyle();

    return Row(
      children: [
        //
        // Credit Card Widget
        Visibility(
          visible: type == MudeInputCardType.card,
          child: ExcludeSemantics(
            child: InputCreditCardWidget(
              flag: cardFlag,
              isPressed: isPressed,
            ),
          ),
        ),

        Expanded(
          child: Opacity(
            opacity: opacityBody,
            child: TextField(
              //
              // Controls Layout
              cursorColor: textColor,
              style: placeholderStyle,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: placeholder,
                hintStyle: placeholderStyle,
                label: label,
                labelStyle: placeholderStyle,
              ),

              // Controls Input
              controller: controller,
              focusNode: focusNode,
              readOnly: readOnly,
              autofocus: autofocus,
              autocorrect: autocorrect,
              keyboardType: TextInputType.number,
              inputFormatters: inputFormatters,
              onChanged: onChanged,
              onEditingComplete: onEditingComplete,
              onSubmitted: onSubmitted,
              enabled: !disabled,
              textInputAction: textInputAction,
            ),
          ),
        ),

        Opacity(
          opacity: opacityBody,
          child: SizedBox(
            height: 50,
            width: 48,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                //
                // Icon Error
                Positioned(
                  top: 14,
                  right: positionIconError,
                  child: InputErrorIcon(
                    show: hasError && !disabled,
                    iconColor: iconColor,
                  ),
                ),

                // Icon Question
                Positioned(
                  right: -16,
                  child: InputQuestionIcon(
                    show: type != MudeInputCardType.card,
                    iconColor: iconColor,
                    onQuestion: disabled ? null : onQuestion,
                    label: controller.text,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
