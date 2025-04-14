import 'package:flutter/material.dart';
import 'package:expense_core/core.dart';
import 'package:expense_core/src/utils/pixel_ratio.dart';
import 'package:provider/provider.dart';

void openDrawer(
  BuildContext context, {
  required String label,
  required Color backgroundColor,
  required ValueChanged<List<DateTime?>>? onConfirm,
  required List<DateTime?> value,
  required bool disabled,
  required DateTime? currentDate,
  required DateTime firstDate,
  required DateTime lastDate,
  required String buttonLabel,
  required ExpenseInputDateType type,
  required ExpenseInputDateMode mode,
  required bool hasChangedYear,
}) {
  if (disabled) return;

  ExpenseSuperDrawer.show(
    padding: const EdgeInsets.all(0),
    backgroundColor: backgroundColor,
    context,
    children: [
      _DrawerContent(
        label: label,
        value: value,
        onConfirm: onConfirm,
        currentDate: currentDate,
        firstDate: firstDate,
        lastDate: lastDate,
        buttonLabel: buttonLabel,
        type: type,
        mode: mode,
        hasChangedYear: hasChangedYear,
      ),
    ],
  );
}

class _DrawerContent extends StatefulWidget {
  final String label;
  final ValueChanged<List<DateTime?>>? onConfirm;
  final List<DateTime?> value;
  final DateTime? currentDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final String buttonLabel;
  final ExpenseInputDateType type;
  final ExpenseInputDateMode mode;
  final bool hasChangedYear;

  const _DrawerContent({
    required this.label,
    required this.firstDate,
    required this.lastDate,
    required this.buttonLabel,
    required this.type,
    required this.mode,
    required this.hasChangedYear,
    required this.value,
    this.onConfirm,
    this.currentDate,
  });

  @override
  State<_DrawerContent> createState() => __DrawerContentState();
}

class __DrawerContentState extends State<_DrawerContent> {
  List<DateTime?> _dateSelected = [];

  void _onDateChanged(List<DateTime?> date) {
    setState(() => _dateSelected = date);
  }

  void _onConfirm() {
    if (widget.onConfirm != null) {
      widget.onConfirm!(_dateSelected);
      Navigator.pop(context);
    }
  }

  DateTime _getCurrentDate() {
    return widget.currentDate ?? DateTime.now();
  }

  @override
  void initState() {
    super.initState();
    setState(() => _dateSelected = widget.value);
  }

  ExpenseDatePickerType getCalendarDatePickerType() {
    switch (widget.type) {
      case ExpenseInputDateType.single:
        return ExpenseDatePickerType.single;
      case ExpenseInputDateType.range:
        return ExpenseDatePickerType.range;
    }
  }

  ExpenseDatePickerMode getCalendarDataPickerMode() {
    switch (widget.mode) {
      case ExpenseInputDateMode.day:
        return ExpenseDatePickerMode.day;
      case ExpenseInputDateMode.year:
        return ExpenseDatePickerMode.year;
    }
  }

  @override
  Widget build(BuildContext context) {
    final tokens = Provider.of<ExpenseThemeManager>(context);
    final globalTokens = tokens.globals;
    final spacing = globalTokens.shapes.spacing;

    bool disableButton() {
      return widget.type == ExpenseInputDateType.range ? !(_dateSelected.length > 1 && _dateSelected[1] != null) : (_dateSelected == widget.value);
    }

    return Expanded(
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: PixelRatio.calc(context, spacing.s1x),
                  bottom: PixelRatio.calc(context, spacing.s4x),
                  left: spacing.s3x,
                ),
                child: ExpenseHeading(
                  widget.label,
                  size: ExpenseHeadingSize.lg,
                ),
              ),
              ExpenseDatePicker(
                firstDate: widget.firstDate,
                lastDate: widget.lastDate,
                onValueChanged: _onDateChanged,
                currentDate: _getCurrentDate(),
                value: _dateSelected,
                type: getCalendarDatePickerType(),
                calendarViewMode: getCalendarDataPickerMode(),
                hasChangedYear: widget.hasChangedYear,
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Padding(
              padding: EdgeInsets.all(spacing.s3x),
              child: ExpenseButton(
                label: widget.buttonLabel,
                type: ExpenseButtonType.blocked,
                onPressed: _onConfirm,
                disabled: disableButton(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
