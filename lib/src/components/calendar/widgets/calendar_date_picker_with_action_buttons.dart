// coverage:ignore-start
import 'package:flutter/material.dart';

import '../date_picker.dart';
import '../models/calendar_date_picker_config.dart';

class ExpenseDatePickerWithActionButtons extends StatefulWidget {
  const ExpenseDatePickerWithActionButtons({
    required this.value,
    required this.config,
    this.onValueChanged,
    this.onDisplayedMonthChanged,
    this.onCancelTapped,
    this.onOkTapped,
    Key? key,
  }) : super(key: key);

  final List<DateTime?> value;

  /// Called when the user taps 'OK' button
  final ValueChanged<List<DateTime?>>? onValueChanged;

  /// Called when the user navigates to a new month/year in the picker.
  final ValueChanged<DateTime>? onDisplayedMonthChanged;

  /// The calendar configurations including action buttons
  final ExpenseDatePickerWithActionButtonsConfig config;

  /// The callback when cancel button is tapped
  final Function? onCancelTapped;

  /// The callback when ok button is tapped
  final Function? onOkTapped;

  @override
  State<ExpenseDatePickerWithActionButtons> createState() => _CalendarDatePickerWithActionButtonsState();
}

class _CalendarDatePickerWithActionButtonsState extends State<ExpenseDatePickerWithActionButtons> {
  List<DateTime?> _values = [];
  List<DateTime?> _editCache = [];

  @override
  void initState() {
    _values = widget.value;
    _editCache = widget.value;
    super.initState();
  }

  @override
  void didUpdateWidget(
    covariant ExpenseDatePickerWithActionButtons oldWidget,
  ) {
    var isValueSame = oldWidget.value.length == widget.value.length;

    if (isValueSame) {
      for (var i = 0; i < oldWidget.value.length; i++) {
        var isSame = (oldWidget.value[i] == null && widget.value[i] == null) || DateUtils.isSameDay(oldWidget.value[i], widget.value[i]);
        if (!isSame) {
          isValueSame = false;
          break;
        }
      }
    }

    if (!isValueSame) {
      _values = widget.value;
      _editCache = widget.value;
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final MaterialLocalizations localizations = MaterialLocalizations.of(context);

    final gapBetweenCalendarAndButtons = widget.config.gapBetweenCalendarAndButtons;

    final colorTheme = Theme.of(context).colorScheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        MediaQuery.removePadding(
          context: context,
          child: ExpenseDatePicker(
            value: [..._editCache],
            onValueChanged: (values) => _editCache = values,
            onDisplayedMonthChanged: widget.onDisplayedMonthChanged,
          ),
        ),
        SizedBox(height: gapBetweenCalendarAndButtons ?? 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _buildCancelButton(colorTheme, localizations),
            if ((gapBetweenCalendarAndButtons ?? 0) > 0) SizedBox(width: gapBetweenCalendarAndButtons),
            _buildOkButton(colorTheme, localizations),
          ],
        ),
      ],
    );
  }

  Widget _buildCancelButton(
    ColorScheme colorScheme,
    MaterialLocalizations localizations,
  ) {
    return InkWell(
      borderRadius: BorderRadius.circular(5),
      onTap: () => setState(() {
        _editCache = _values;
        widget.onCancelTapped?.call();
        if ((widget.config.openedFromDialog ?? false) && (widget.config.closeDialogOnCancelTapped ?? true)) {
          Navigator.pop(context);
        }
      }),
      child: Container(
        padding: widget.config.buttonPadding ?? const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: widget.config.cancelButton ??
            Text(
              localizations.cancelButtonLabel.toUpperCase(),
              style: widget.config.cancelButtonTextStyle ??
                  TextStyle(
                    color: widget.config.selectedDayHighlightColor ?? colorScheme.primary,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
            ),
      ),
    );
  }

  Widget _buildOkButton(
    ColorScheme colorScheme,
    MaterialLocalizations localizations,
  ) {
    return InkWell(
      borderRadius: BorderRadius.circular(5),
      onTap: () => setState(() {
        _values = _editCache;
        widget.onValueChanged?.call(_values);
        widget.onOkTapped?.call();
        if ((widget.config.openedFromDialog ?? false) && (widget.config.closeDialogOnOkTapped ?? true)) {
          Navigator.pop(context, _values);
        }
      }),
      child: Container(
        padding: widget.config.buttonPadding ?? const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: widget.config.okButton ??
            Text(
              localizations.okButtonLabel.toUpperCase(),
              style: widget.config.okButtonTextStyle ??
                  TextStyle(
                    color: widget.config.selectedDayHighlightColor ?? colorScheme.primary,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
            ),
      ),
    );
  }
}
// coverage:ignore-end
