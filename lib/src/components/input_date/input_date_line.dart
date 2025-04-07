import 'package:flutter/material.dart';
import 'package:mude_core/core.dart';
import 'package:provider/provider.dart';

import 'widgets/content_widget.dart';
import 'widgets/open_drawer.dart';
import 'widgets/support_widget.dart';

class MudeInputDateLine extends StatefulWidget {
  ///A string representing the label for the select field.
  final String label;

  ///(Optional) A string representing support text for the select field.
  final String? supportText;

  ///(Optional) A string representing text button confirm for the select field.
  final String buttonLabel;

  ///(Optional) A callback function that will be called when the value of the select field changes.
  ///It returns a [List<DateTime?>] parameter representing the new selected value.
  final ValueChanged<List<DateTime?>>? onConfirm;

  ///A [List<DateTime?>] object representing the currently selected value.
  final List<DateTime?> value;

  ///A boolean indicating whether the select field is disabled.
  ///The default value is false.
  final bool disabled;

  ///A boolean indicating whether the select field has an error.
  ///The default value is false.
  final bool hasError;

  ///(Optional) A optional [MudeInputDateType] object that represents the type
  ///that will be rendered on the screen [single] or [range]
  final MudeInputDateType type;

  ///(Optional) A optional [MudeInputDateType] object that represents the type
  ///that will be rendered on the screen [day] or [years]
  final MudeInputDateMode mode;

  ///A boolean indicating whether this field is actived to change years
  final bool hasChangedYear;

  ///(Optional) A [DateTime] indicating what is date current
  final DateTime? currentDate;

  ///(Optional) A [DateTime] indicating what date is beginner the calendar
  final DateTime firstDate;

  ///(Optional) A [DateTime] indicating what date is finished the calendar
  final DateTime lastDate;

  ///A string value that provides a descriptive label for accessibility purposes.
  ///The default value is null
  final String? semanticsLabel;

  ///A string value that indicates additional accessibility information.
  ///The default value is null
  final String? semanticsHint;

  const MudeInputDateLine({
    super.key,
    required this.label,
    required this.firstDate,
    required this.lastDate,
    required this.value,
    this.onConfirm,
    this.currentDate,
    this.supportText,
    this.type = MudeInputDateType.single,
    this.mode = MudeInputDateMode.day,
    this.disabled = false,
    this.hasError = false,
    this.buttonLabel = 'Confirmar',
    this.hasChangedYear = true,
    this.semanticsLabel,
    this.semanticsHint,
  });

  @override
  State<MudeInputDateLine> createState() => _MudeInputDateLineState();
}

class _MudeInputDateLineState extends State<MudeInputDateLine> {
  bool _isPressed = false;

  void _onPressed(bool isPressed) {
    if (widget.disabled) return;
    setState(() => _isPressed = isPressed);
  }

  @override
  Widget build(BuildContext context) {
    final tokens = Provider.of<MudeThemeManager>(context);
    final globalTokens = tokens.globals;
    final aliasTokens = tokens.alias;
    final spacing = globalTokens.shapes.spacing;

    double getOpacity() {
      if (widget.disabled) {
        return aliasTokens.color.disabled.opacity;
      }

      return _isPressed ? globalTokens.shapes.opacity.superHigh : 1;
    }

    Color getBackgroundColor() {
      if (_isPressed) {
        return aliasTokens.mixin.pressedOutline;
      }

      return Colors.transparent;
    }

    Color getTextColor() {
      if (widget.disabled) {
        return aliasTokens.color.disabled.placeholderColor;
      }

      if (widget.hasError) {
        return aliasTokens.color.negative.placeholderColor;
      }

      return widget.value.isNotEmpty
          ? aliasTokens.color.active.onPlaceholderColor
          : aliasTokens.color.text.onPlaceholderColor;
    }

    Color getLabelColor() {
      if (widget.disabled) {
        return aliasTokens.color.disabled.labelColor;
      }

      if (widget.hasError) {
        return aliasTokens.color.negative.labelColor;
      }

      return widget.value.isNotEmpty
          ? aliasTokens.color.text.onLabelColor
          : aliasTokens.color.text.labelColor;
    }

    Color getBorderColor() {
      if (widget.disabled) {
        return aliasTokens.color.disabled.borderColor;
      }

      if (widget.hasError) {
        return aliasTokens.color.negative.borderColor;
      }

      if (widget.value.isNotEmpty) {
        return aliasTokens.color.active.borderColor;
      }

      if (_isPressed) {
        return aliasTokens.mixin.pressedOutline;
      }

      return aliasTokens.color.elements.borderColor;
    }

    Color getIconColor() {
      if (widget.disabled) {
        return aliasTokens.color.disabled.iconColor;
      }

      if (widget.hasError) {
        return aliasTokens.color.negative.iconColor;
      }

      return aliasTokens.color.elements.iconColor;
    }

    openCalendar() => openDrawer(
          context,
          label: widget.label,
          backgroundColor: aliasTokens.color.elements.bgColor02,
          onConfirm: widget.onConfirm,
          value: widget.value,
          disabled: widget.disabled,
          currentDate: widget.currentDate,
          firstDate: widget.firstDate,
          lastDate: widget.lastDate,
          buttonLabel: widget.buttonLabel,
          type: widget.type,
          mode: widget.mode,
          hasChangedYear: widget.hasChangedYear,
        );

    return Semantics(
      button: true,
      enabled: !widget.disabled,
      child: GestureDetector(
        onTap: openCalendar,
        onTapDown: (_) => _onPressed(true),
        onTapUp: (_) => _onPressed(false),
        onTapCancel: () => _onPressed(false),
        child: Opacity(
          opacity: getOpacity(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //
              // Content
              Semantics(
                enabled: !widget.disabled,
                label: widget.semanticsLabel,
                hint: widget.semanticsHint,
                excludeSemantics: true,
                child: Content(
                  label: widget.label,
                  value: widget.value,
                  disabled: widget.disabled,
                  hasError: widget.hasError,
                  onPressed: openCalendar,
                  decoration: BoxDecoration(
                    color: getBackgroundColor(),
                    border: Border(
                      bottom: BorderSide(
                        width: aliasTokens.defaultt.borderWidth,
                        color: getBorderColor(),
                      ),
                    ),
                  ),
                  textColor: getTextColor(),
                  iconColor: getIconColor(),
                  labelColor: getLabelColor(),
                  padding: const EdgeInsets.all(0),
                  type: widget.type,
                ),
              ),

              SizedBox(height: spacing.s1x),

              // Support text
              SupportText(
                supportText: widget.supportText,
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
