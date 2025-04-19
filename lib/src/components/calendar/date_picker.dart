// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:math' as math;

import 'package:expense_core/core.dart';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:expense_core/src/utils/string_extensions.dart';

import 'utils/date_util.dart';

part 'widgets/year_picker.dart';
part 'widgets/_day_picker.dart';
part 'widgets/_focus_date.dart';
part 'widgets/_calendar_view.dart';
part 'widgets/_date_picker_mode_toggle_button.dart';

const Duration _monthScrollDuration = Duration(milliseconds: 200);

const double _dayPickerRowHeight = 42.0;
// A 31 day month that starts on Saturday.
// One extra row for the day-of-week header.
const int _maxDayPickerRowCount = 6;
const double _maxDayPickerHeight = _dayPickerRowHeight * (_maxDayPickerRowCount + 1);
const double _monthPickerHorizontalPadding = 8.0;

const int _yearPickerColumnCount = 3;
const double _yearPickerPadding = 16.0;
const double _yearPickerRowHeight = 52.0;
const double _yearPickerRowSpacing = 8.0;

const double _subHeaderHeight = 52.0;
const double _monthNavButtonsWidth = 108.0;

class ExpenseDatePicker extends StatefulWidget {
  /// The calendar UI related configurations
  // final ExpenseDatePickerConfig config;
  /// The enabled date picker mode
  final ExpenseDatePickerType type;

  /// The earliest allowable [DateTime] that the user can select.
  final DateTime? firstDate;

  /// The latest allowable [DateTime] that the user can select.
  final DateTime? lastDate;

  /// The [DateTime] representing today. It will be highlighted in the day grid.
  final DateTime? currentDate;

  /// The initially displayed view of the calendar picker.
  final ExpenseDatePickerMode calendarViewMode;

  /// The selected [DateTime]s that the picker should display.
  final List<DateTime?> value;

  /// Called when the selected dates changed
  final ValueChanged<List<DateTime?>>? onValueChanged;

  /// Date to control calendar displayed month
  final DateTime? displayedMonthDate;

  /// Called when the displayed month changed
  final ValueChanged<DateTime>? onDisplayedMonthChanged;

  // Fefines whether the user can change the year
  final bool hasChangedYear;

  ///A string value that indicates if you add more information from accessibility
  ///The default value is null
  final String? semanticsLabel;

  ///A string value that indicates if you add more information from accessibility
  ///The default value is null
  final String? semanticsHint;

  ExpenseDatePicker({
    required this.value,
    this.type = ExpenseDatePickerType.single,
    this.firstDate,
    this.lastDate,
    this.currentDate,
    this.calendarViewMode = ExpenseDatePickerMode.day,
    this.onValueChanged,
    this.displayedMonthDate,
    this.onDisplayedMonthChanged,
    this.hasChangedYear = true,
    this.semanticsLabel,
    this.semanticsHint,
    Key? key,
  }) : super(key: key) {
    const valid = true;
    const invalid = false;

    if (type == ExpenseDatePickerType.single) {
      assert(value.length < 2, 'Error: single date picker only allows maximum one initial date');
    }

    if (type == ExpenseDatePickerType.range && value.length > 1) {
      bool isRangePickerValueValid = false;
      if (value[0] == null) {
        isRangePickerValueValid = (value[1] != null ? invalid : valid);
      } else if (value[1] != null) {
        isRangePickerValueValid = (value[1]!.isBefore(value[0]!) ? invalid : valid);
      } else {
        isRangePickerValueValid = valid;
      }

      assert(
        isRangePickerValueValid,
        'Error: range date picker must has start date set before setting end date, and start date must before end date.',
      );
    }
  }

  @override
  State<ExpenseDatePicker> createState() => _ExpenseDatePickerState();
}

class _ExpenseDatePickerState extends State<ExpenseDatePicker> {
  bool _announcedInitialDate = false;
  late List<DateTime?> _selectedDates;
  late ExpenseDatePickerMode _mode;
  late DateTime _currentDisplayedMonthDate;
  final GlobalKey _monthPickerKey = GlobalKey();
  final GlobalKey _yearPickerKey = GlobalKey();
  late MaterialLocalizations _localizations;
  late TextDirection _textDirection;
  late ExpenseDatePickerConfig configNOW;

  @override
  void initState() {
    super.initState();

    configNOW = ExpenseDatePickerConfig(
      calendarType: widget.type,
      firstDate: widget.firstDate,
      lastDate: widget.lastDate,
      currentDate: widget.currentDate,
      calendarViewMode: widget.calendarViewMode,
      disableModePicker: !widget.hasChangedYear,
    );

    final config = configNOW;
    final initialDate = widget.displayedMonthDate ??
        (widget.value.isNotEmpty && widget.value[0] != null
            ? DateTime(widget.value[0]!.year, widget.value[0]!.month)
            : DateUtils.dateOnly(DateTime.now()));
    _mode = config.calendarViewMode;
    _currentDisplayedMonthDate = DateTime(initialDate.year, initialDate.month);
    _selectedDates = widget.value.toList();
  }

  // coverage:ignore-start
  @override
  void didUpdateWidget(ExpenseDatePicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (configNOW.calendarViewMode != oldWidget.calendarViewMode) {
      _mode = configNOW.calendarViewMode;
    }

    if (widget.displayedMonthDate != null) {
      _currentDisplayedMonthDate = DateTime(
        widget.displayedMonthDate!.year,
        widget.displayedMonthDate!.month,
      );
    }

    _selectedDates = widget.value.toList();
  }
  // coverage:ignore-end

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    assert(debugCheckHasMaterial(context));
    assert(debugCheckHasMaterialLocalizations(context));
    assert(debugCheckHasDirectionality(context));
    _localizations = MaterialLocalizations.of(context);
    _textDirection = Directionality.of(context);
    if (!_announcedInitialDate && _selectedDates.isNotEmpty) {
      _announcedInitialDate = true;
      for (final date in _selectedDates) {
        if (date != null) {
          SemanticsService.announce(
            _localizations.formatFullDate(date),
            _textDirection,
          );
        }
      }
    }
  }

  // coverage:ignore-start
  void _vibrate() {
    switch (Theme.of(context).platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        HapticFeedback.vibrate();
        break;
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        break;
    }
  }
  // coverage:ignore-end

  void _handleModeChanged(ExpenseDatePickerMode mode) {
    _vibrate();
    setState(() {
      _mode = mode;
      if (_selectedDates.isNotEmpty) {
        // coverage:ignore-start
        for (final date in _selectedDates) {
          if (date != null) {
            SemanticsService.announce(
              _mode == ExpenseDatePickerMode.day ? _localizations.formatMonthYear(date) : _localizations.formatYear(date),
              _textDirection,
            );
          }
        }
        // coverage:ignore-end
      }
    });
  }

  void _handleMonthChanged(DateTime date, {bool fromYearPicker = false}) {
    setState(() {
      final currentDisplayedMonthDate = DateTime(
        _currentDisplayedMonthDate.year,
        _currentDisplayedMonthDate.month,
      );
      var newDisplayedMonthDate = currentDisplayedMonthDate;

      if (_currentDisplayedMonthDate.year != date.year || _currentDisplayedMonthDate.month != date.month) {
        newDisplayedMonthDate = DateTime(date.year, date.month);
      }

      if (fromYearPicker) {
        final selectedDatesInThisYear = _selectedDates.where((d) => d?.year == date.year).toList()..sort((d1, d2) => d1!.compareTo(d2!));
        if (selectedDatesInThisYear.isNotEmpty) {
          newDisplayedMonthDate = DateTime(date.year, selectedDatesInThisYear[0]!.month);
        }
      }

      if (currentDisplayedMonthDate.year != newDisplayedMonthDate.year || currentDisplayedMonthDate.month != newDisplayedMonthDate.month) {
        _currentDisplayedMonthDate = DateTime(
          newDisplayedMonthDate.year,
          newDisplayedMonthDate.month,
        );
        widget.onDisplayedMonthChanged?.call(_currentDisplayedMonthDate);
      }
    });
  }

  void _handleYearChanged(DateTime value) {
    _vibrate();

    if (value.isBefore(configNOW.firstDate)) {
      value = configNOW.firstDate;
    } else if (value.isAfter(configNOW.lastDate)) {
      value = configNOW.lastDate;
    }

    setState(() {
      _mode = ExpenseDatePickerMode.day;
      _handleMonthChanged(value, fromYearPicker: true);
    });
  }

  void _handleDayChanged(DateTime value) {
    _vibrate();
    setState(() {
      var selectedDates = [..._selectedDates];
      selectedDates.removeWhere((d) => d == null);

      if (configNOW.calendarType == ExpenseDatePickerType.single) {
        selectedDates = [value];
      } else if (configNOW.calendarType == ExpenseDatePickerType.multi) {
        final index = selectedDates.indexWhere((d) => DateUtils.isSameDay(d, value));
        if (index != -1) {
          selectedDates.removeAt(index);
        } else {
          selectedDates.add(value);
        }
      } else if (configNOW.calendarType == ExpenseDatePickerType.range) {
        if (selectedDates.isEmpty) {
          selectedDates.add(value);
        } else {
          final isRangeSet = selectedDates.length > 1 && selectedDates[1] != null;
          final isSelectedDayBeforeStartDate = value.isBefore(selectedDates[0]!);

          selectedDates = isRangeSet || isSelectedDayBeforeStartDate ? [value, null] : [selectedDates[0], value];
        }
      }

      selectedDates
        ..removeWhere((d) => d == null)
        ..sort((d1, d2) => d1!.compareTo(d2!));

      final isValueDifferent = configNOW.calendarType != ExpenseDatePickerType.single ||
          !DateUtils.isSameDay(
            selectedDates[0],
            _selectedDates.isNotEmpty ? _selectedDates[0] : null,
          );
      if (isValueDifferent) {
        _selectedDates = [...selectedDates];
        widget.onValueChanged?.call(_selectedDates);
      }
    });
  }

  Widget _buildPicker() {
    switch (_mode) {
      case ExpenseDatePickerMode.day:
        return _CalendarView(
          config: configNOW,
          key: _monthPickerKey,
          initialMonth: _currentDisplayedMonthDate,
          selectedDates: _selectedDates,
          onChanged: _handleDayChanged,
          onDisplayedMonthChanged: _handleMonthChanged,
        );
      case ExpenseDatePickerMode.year:
        return Padding(
          padding: EdgeInsets.only(
            top: configNOW.controlsHeight ?? _subHeaderHeight,
          ),
          child: YearPicker(
            config: configNOW,
            key: _yearPickerKey,
            initialMonth: _currentDisplayedMonthDate,
            selectedDates: _selectedDates,
            onChanged: _handleYearChanged,
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    String getTitle() {
      return _localizations.formatMonthYear(_currentDisplayedMonthDate).replaceAll(' de', '').capitalize();
    }

    assert(debugCheckHasMaterial(context));
    assert(debugCheckHasMaterialLocalizations(context));
    assert(debugCheckHasDirectionality(context));

    return Semantics(
      label: widget.semanticsLabel,
      hint: widget.semanticsHint,
      child: Stack(
        children: <Widget>[
          SizedBox(
            height: (configNOW.controlsHeight ?? _subHeaderHeight) + _maxDayPickerHeight,
            child: _buildPicker(),
          ),
          // Put the mode toggle button on top so that it won't be covered up by the _CalendarView
          _DatePickerModeToggleButton(
            config: configNOW,
            mode: _mode,
            title: getTitle(),
            onTitlePressed: () {
              // Toggle the day/year mode.
              _handleModeChanged(_mode == ExpenseDatePickerMode.day ? ExpenseDatePickerMode.year : ExpenseDatePickerMode.day);
            },
          ),
        ],
      ),
    );
  }
}
