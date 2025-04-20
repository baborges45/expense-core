// coverage:ignore-start
part of '../date_picker.dart';

/// Displays the days of a given month and allows choosing a day.
///
/// The days are arranged in a rectangular grid with one column for each day of
/// the week.
class _DayPicker extends StatefulWidget {
  /// Creates a day picker.
  const _DayPicker({
    required this.config,
    required this.displayedMonth,
    required this.selectedDates,
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  /// The calendar configurations
  final ExpenseDatePickerConfig config;

  /// The currently selected dates.
  ///
  /// Selected dates are highlighted in the picker.
  final List<DateTime> selectedDates;

  /// Called when the user picks a day.
  final ValueChanged<DateTime> onChanged;

  /// The month whose days are displayed by this picker.
  final DateTime displayedMonth;

  @override
  _DayPickerState createState() => _DayPickerState();
}

class _DayPickerState extends State<_DayPicker> {
  /// List of [FocusNode]s, one for each day of the month.
  late List<FocusNode> _dayFocusNodes;

  @override
  void initState() {
    super.initState();
    final int daysInMonth = DateUtils.getDaysInMonth(
      widget.displayedMonth.year,
      widget.displayedMonth.month,
    );

    _dayFocusNodes = List<FocusNode>.generate(
      daysInMonth,
      (int index) => FocusNode(skipTraversal: true, debugLabel: 'Day ${index + 1}'),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Check to see if the focused date is in this month, if so focus it.
    final DateTime? focusedDate = _FocusedDate.maybeOf(context);
    if (focusedDate != null && DateUtils.isSameMonth(widget.displayedMonth, focusedDate)) {
      _dayFocusNodes[focusedDate.day - 1].requestFocus();
    }
  }

  @override
  void dispose() {
    for (final FocusNode node in _dayFocusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  /// Builds widgets showing abbreviated days of week. The first widget in the
  /// returned list corresponds to the first day of week for the current locale.
  ///
  /// Examples:
  ///
  /// ```
  /// ┌ Sunday is the first day of week in the US (en_US)
  /// |
  /// S M T W T F S  <-- the returned list contains these widgets
  /// _ _ _ _ _ 1 2
  /// 3 4 5 6 7 8 9
  ///
  /// ┌ But it's Monday in the UK (en_GB)
  /// |
  /// M T W T F S S  <-- the returned list contains these widgets
  /// _ _ _ _ 1 2 3
  /// 4 5 6 7 8 9 10
  /// ```
  List<Widget> _dayHeaders(
    TextStyle? headerStyle,
    MaterialLocalizations localizations,
  ) {
    final List<Widget> result = <Widget>[];
    final weekdays = widget.config.weekdayLabels ?? localizations.narrowWeekdays;
    final firstDayOfWeek = widget.config.firstDayOfWeek ?? localizations.firstDayOfWeekIndex;
    assert(firstDayOfWeek >= 0 && firstDayOfWeek <= 6, 'firstDayOfWeek must between 0 and 6');
    for (int i = firstDayOfWeek; true; i = (i + 1) % 7) {
      final String weekday = weekdays[i];
      result.add(ExcludeSemantics(
        child: Center(
          child: Text(
            weekday,
            style: widget.config.weekdayLabelTextStyle ?? headerStyle,
          ),
        ),
      ));
      if (i == (firstDayOfWeek - 1) % 7) break;
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    final tokens = Provider.of<ExpenseThemeManager>(context);
    final globalTokens = tokens.globals;
    final aliasTokens = tokens.alias;

    final colors = aliasTokens.color;
    final colorsText = aliasTokens.color.text;

    final MaterialLocalizations localizations = MaterialLocalizations.of(context);

    final TextStyle headerStyle = aliasTokens.mixin.labelMd2.merge(
      TextStyle(color: aliasTokens.color.text.labelColor),
    );

    final TextStyle dayStyle = aliasTokens.mixin.labelMd2;

    final Color enabledDayColor = colorsText.labelColor;
    final Color disabledDayColor = colors.disabled.labelColor;

    final Color selectedDayColor = colors.selected.onLabelColor;
    final Color selectedDayBackground = colors.selected.bgColor;
    final Color todayColor = colorsText.labelColor;

    final int year = widget.displayedMonth.year;
    final int month = widget.displayedMonth.month;

    final int daysInMonth = DateUtils.getDaysInMonth(year, month);
    final int dayOffset = getMonthFirstDayOffset(
      year,
      month,
      widget.config.firstDayOfWeek ?? localizations.firstDayOfWeekIndex,
    );

    final List<Widget> dayItems = _dayHeaders(headerStyle, localizations);

    // 1-based day of month, e.g. 1-31 for January, and 1-29 for February on
    // a leap year.
    int day = -dayOffset;
    while (day < daysInMonth) {
      day++;
      if (day < 1) {
        dayItems.add(Container());
      } else {
        final DateTime dayToBuild = DateTime(year, month, day);

        final bool isDisabled = dayToBuild.isAfter(widget.config.lastDate) ||
            dayToBuild.isBefore(widget.config.firstDate) ||
            !(widget.config.selectableDayPredicate?.call(dayToBuild) ?? true);

        final bool isSelectedDay = widget.selectedDates.any((d) => DateUtils.isSameDay(d, dayToBuild));

        final bool isToday = DateUtils.isSameDay(widget.config.currentDate, dayToBuild);

        BoxDecoration? decoration;
        Color dayColor = enabledDayColor;

        if (isSelectedDay) {
          // The selected day gets a circle background highlight, and a
          // contrasting text color.
          dayColor = selectedDayColor;
          decoration = BoxDecoration(
            borderRadius: widget.config.dayBorderRadius,
            color: widget.config.selectedDayHighlightColor ?? selectedDayBackground,
            shape: widget.config.dayBorderRadius != null ? BoxShape.rectangle : BoxShape.circle,
          );
        } else if (isDisabled) {
          dayColor = disabledDayColor.withAlpha(
            (globalTokens.shapes.opacity.low * 255).toInt(),
          );
        } else if (isToday) {
          // The current day gets a different text color and a circle stroke
          // border.
          dayColor = widget.config.selectedDayHighlightColor ?? todayColor;
          decoration = BoxDecoration(
            borderRadius: widget.config.dayBorderRadius,
            shape: widget.config.dayBorderRadius != null ? BoxShape.rectangle : BoxShape.circle,
          );
        }

        var customDayTextStyle = widget.config.dayTextStylePredicate?.call(date: dayToBuild) ?? widget.config.dayTextStyle;

        if (isToday && widget.config.todayTextStyle != null) {
          customDayTextStyle = widget.config.todayTextStyle;
        }

        if (isDisabled) {
          customDayTextStyle = customDayTextStyle?.copyWith(
            color: disabledDayColor,
            fontWeight: FontWeight.normal,
          );
          if (widget.config.disabledDayTextStyle != null) {
            customDayTextStyle = widget.config.disabledDayTextStyle;
          }
        }

        final isFullySelectedRangePicker = widget.config.calendarType == ExpenseDatePickerType.range && widget.selectedDates.length == 2;
        var isDateInBetweenRangePickerSelectedDates = false;

        if (isFullySelectedRangePicker) {
          final startDate = DateUtils.dateOnly(widget.selectedDates[0]);
          final endDate = DateUtils.dateOnly(widget.selectedDates[1]);

          isDateInBetweenRangePickerSelectedDates =
              !(dayToBuild.isBefore(startDate) || dayToBuild.isAfter(endDate)) && !DateUtils.isSameDay(startDate, endDate);
        }

        if (isDateInBetweenRangePickerSelectedDates && widget.config.selectedRangeDayTextStyle != null) {
          customDayTextStyle = widget.config.selectedRangeDayTextStyle;
        }

        if (isSelectedDay) {
          customDayTextStyle = widget.config.selectedDayTextStyle;
        }

        final dayTextStyle = customDayTextStyle ?? dayStyle.apply(color: dayColor);

        Widget dayWidget = widget.config.dayBuilder?.call(
              date: dayToBuild,
              textStyle: dayTextStyle,
              decoration: decoration,
              isSelected: isSelectedDay,
              isDisabled: isDisabled,
              isToday: isToday,
            ) ??
            _buildDefaultDayWidgetContent(
              decoration,
              localizations,
              day,
              dayTextStyle,
            );

        if (isToday) {
          dayWidget = _TodaySelected(
            day: day,
            isSelectedDay: isSelectedDay,
            disabled: widget.config.currentDate.isBefore(
              widget.config.firstDate,
            ),
          );
        }

        if (isDateInBetweenRangePickerSelectedDates) {
          // define color dates range
          final rangePickerIncludedDayDecoration = BoxDecoration(
            color: aliasTokens.color.elements.bgColor02,
          );

          if (DateUtils.isSameDay(
            DateUtils.dateOnly(widget.selectedDates[0]),
            dayToBuild,
          )) {
            dayWidget = Stack(
              children: [
                Row(children: [
                  const Spacer(),
                  Expanded(
                    child: Container(
                      key: const Key('calendar-day-picker.selected-range'),
                      decoration: rangePickerIncludedDayDecoration,
                    ),
                  ),
                ]),
                dayWidget,
              ],
            );
          } else if (DateUtils.isSameDay(
            DateUtils.dateOnly(widget.selectedDates[1]),
            dayToBuild,
          )) {
            dayWidget = Stack(
              children: [
                Row(children: [
                  Expanded(
                    child: Container(
                      key: const Key('calendar-day-picker.selected-range'),
                      decoration: rangePickerIncludedDayDecoration,
                    ),
                  ),
                  const Spacer(),
                ]),
                dayWidget,
              ],
            );
          } else {
            dayWidget = Stack(
              children: [
                Container(
                  key: const Key('calendar-day-picker.selected-range'),
                  decoration: rangePickerIncludedDayDecoration,
                ),
                dayWidget,
              ],
            );
          }
        }

        dayWidget = Padding(
          padding: const EdgeInsets.symmetric(vertical: 1),
          child: dayWidget,
        );

        dayWidget = isDisabled
            ? ExcludeSemantics(child: dayWidget)
            : _Today(
                onPressed: () => widget.onChanged(dayToBuild),
                localizations: localizations,
                day: day,
                dayToBuild: dayToBuild,
                isSelectedDay: isSelectedDay,
                child: dayWidget,
              );

        dayItems.add(dayWidget);
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: _monthPickerHorizontalPadding,
      ),
      child: GridView.custom(
        padding: EdgeInsets.zero,
        physics: const ClampingScrollPhysics(),
        gridDelegate: _dayPickerGridDelegate,
        childrenDelegate: SliverChildListDelegate(
          dayItems,
          addRepaintBoundaries: false,
        ),
      ),
    );
  }

  Widget _buildDefaultDayWidgetContent(
    BoxDecoration? decoration,
    MaterialLocalizations localizations,
    int day,
    TextStyle dayTextStyle,
  ) {
    return Row(
      children: [
        const Spacer(),
        AspectRatio(
          aspectRatio: 1,
          child: Container(
            decoration: decoration,
            child: Center(
              child: Text(
                localizations.formatDecimal(day),
                style: dayTextStyle,
              ),
            ),
          ),
        ),
        const Spacer(),
      ],
    );
  }
}

class _Today extends StatefulWidget {
  final VoidCallback onPressed;
  final Widget child;
  final MaterialLocalizations localizations;
  final int day;
  final DateTime dayToBuild;
  final bool isSelectedDay;

  const _Today({
    required this.onPressed,
    required this.child,
    required this.localizations,
    required this.day,
    required this.dayToBuild,
    required this.isSelectedDay,
  });

  @override
  State<_Today> createState() => _TodayState();
}

class _TodayState extends State<_Today> {
  bool _isPressed = false;

  void _onPressed(bool isPressed) {
    setState(() => _isPressed = isPressed);
  }

  @override
  Widget build(BuildContext context) {
    final tokens = Provider.of<ExpenseThemeManager>(context);
    final aliasTokens = tokens.alias;

    Color getBackgroundColor() {
      return _isPressed ? aliasTokens.mixin.pressedOutline : Colors.transparent;
    }

    return GestureDetector(
      onTap: widget.onPressed,
      onTapDown: (_) => _onPressed(true),
      onTapUp: (_) => _onPressed(false),
      onTapCancel: () => _onPressed(false),
      child: Semantics(
        // We want the day of month to be spoken first irrespective of the
        // locale-specific preferences or TextDirection. This is because
        // an accessibility user is more likely to be interested in the
        // day of month before the rest of the date, as they are looking
        // for the day of month. To do that we prepend day of month to the
        // formatted full date.
        label: '${widget.localizations.formatDecimal(widget.day)}, ${widget.localizations.formatFullDate(widget.dayToBuild)}',
        selected: widget.isSelectedDay,
        excludeSemantics: true,
        child: Container(
          key: widget.isSelectedDay ? const Key('calendar-day-picker.selected') : null,
          decoration: BoxDecoration(
            color: getBackgroundColor(),
            shape: BoxShape.circle,
          ),
          child: widget.child,
        ),
      ),
    );
  }
}

class _TodaySelected extends StatelessWidget {
  final bool isSelectedDay;
  final int day;
  final bool disabled;

  const _TodaySelected({
    required this.isSelectedDay,
    required this.day,
    required this.disabled,
  });

  @override
  Widget build(BuildContext context) {
    final tokens = Provider.of<ExpenseThemeManager>(context);
    final globalTokens = tokens.globals;
    final aliasTokens = tokens.alias;

    final MaterialLocalizations localizations = MaterialLocalizations.of(context);

    Color getBackgroundColor() {
      return isSelectedDay && !disabled ? aliasTokens.color.selected.bgColor : Colors.transparent;
    }

    Color getTextColor() {
      if (disabled) {
        return aliasTokens.color.disabled.labelColor.withAlpha(
          (globalTokens.shapes.opacity.low * 255).toInt(),
        );
      }

      return isSelectedDay ? aliasTokens.color.selected.onLabelColor : aliasTokens.color.text.labelColor;
    }

    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: getBackgroundColor(),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              localizations.formatDecimal(day),
              style: aliasTokens.mixin.labelMd2.apply(
                color: getTextColor(),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 10,
            width: double.maxFinite,
            color: Colors.transparent,
            child: Center(
              child: Container(
                width: 4,
                height: 4,
                decoration: BoxDecoration(
                  color: aliasTokens.color.elements.bgColor06,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _DayPickerGridDelegate extends SliverGridDelegate {
  const _DayPickerGridDelegate();

  @override
  SliverGridLayout getLayout(SliverConstraints constraints) {
    const int columnCount = DateTime.daysPerWeek;
    final double tileWidth = constraints.crossAxisExtent / columnCount;
    final double tileHeight = math.min(
      _dayPickerRowHeight,
      constraints.viewportMainAxisExtent / (_maxDayPickerRowCount + 1),
    );

    return SliverGridRegularTileLayout(
      childCrossAxisExtent: tileWidth,
      childMainAxisExtent: tileHeight,
      crossAxisCount: columnCount,
      crossAxisStride: tileWidth,
      mainAxisStride: tileHeight,
      reverseCrossAxis: axisDirectionIsReversed(constraints.crossAxisDirection),
    );
  }

  @override
  bool shouldRelayout(_DayPickerGridDelegate oldDelegate) => false;
}

const _DayPickerGridDelegate _dayPickerGridDelegate = _DayPickerGridDelegate();
// coverage:ignore-end
