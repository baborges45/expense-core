// coverage:ignore-start
part of '../date_picker.dart';

/// A scrollable grid of years to allow picking a year.
///
/// The year picker widget is rarely used directly. Instead, consider using
/// [CalendarDatePicker2], or [showDatePicker2] which create full date pickers.
///
/// See also:
///
///  * [CalendarDatePicker2], which provides a Material Design date picker
///    interface.
///
///  * [showDatePicker2], which shows a dialog containing a Material Design
///    date picker.
///
class YearPicker extends StatefulWidget {
  /// Creates a year picker.
  const YearPicker({
    required this.config,
    required this.selectedDates,
    required this.onChanged,
    required this.initialMonth,
    this.dragStartBehavior = DragStartBehavior.start,
    Key? key,
  }) : super(key: key);

  /// The calendar configurations
  final ExpenseDatePickerConfig config;

  /// The currently selected dates.
  ///
  /// Selected dates are highlighted in the picker.
  final List<DateTime?> selectedDates;

  /// Called when the user picks a year.
  final ValueChanged<DateTime> onChanged;

  /// The initial month to display.
  final DateTime initialMonth;

  /// {@macro flutter.widgets.scrollable.dragStartBehavior}
  final DragStartBehavior dragStartBehavior;

  @override
  State<YearPicker> createState() => _YearPickerState();
}

class _YearPickerState extends State<YearPicker> {
  late ScrollController _scrollController;

  // The approximate number of years necessary to fill the available space.
  static const int minYears = 18;

  @override
  void initState() {
    super.initState();
    final scrollOffset = widget.selectedDates.isNotEmpty && widget.selectedDates[0] != null
        ? _scrollOffsetForYear(widget.selectedDates[0]!)
        : _scrollOffsetForYear(DateUtils.dateOnly(DateTime.now()));
    _scrollController = ScrollController(initialScrollOffset: scrollOffset);
  }

  @override
  void didUpdateWidget(YearPicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedDates != oldWidget.selectedDates) {
      final scrollOffset = widget.selectedDates.isNotEmpty && widget.selectedDates[0] != null
          ? _scrollOffsetForYear(widget.selectedDates[0]!)
          : _scrollOffsetForYear(DateUtils.dateOnly(DateTime.now()));
      _scrollController.jumpTo(scrollOffset);
    }
  }

  double _scrollOffsetForYear(DateTime date) {
    final int initialYearIndex = date.year - widget.config.firstDate.year;
    final int initialYearRow = initialYearIndex ~/ _yearPickerColumnCount;
    // Move the offset down by 2 rows to approximately center it.
    final int centeredYearRow = initialYearRow - 2;

    return _itemCount < minYears ? 0 : centeredYearRow * _yearPickerRowHeight;
  }

  Widget _buildYearItem(BuildContext context, int index) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;

    // Backfill the _YearPicker with disabled years if necessary.
    final firstDate = widget.config.firstDate;
    final int offset = _itemCount < minYears ? (minYears - _itemCount) ~/ 2 : 0;
    final int year = firstDate.year + index - offset;
    final bool isSelected = widget.initialMonth.year == year;

    final bool isCurrentYear = year == widget.config.currentDate.year;
    final bool isDisabled = year < firstDate.year || year > widget.config.lastDate.year;

    final Color textColor;

    if (isSelected) {
      textColor = colorScheme.onPrimary;
    } else if (isDisabled) {
      textColor = colorScheme.onSurface.withOpacity(0.38);
    } else if (isCurrentYear) {
      textColor = widget.config.selectedDayHighlightColor ?? colorScheme.primary;
    } else {
      textColor = colorScheme.onSurface.withOpacity(0.87);
    }

    TextStyle? itemStyle = widget.config.yearTextStyle ?? textTheme.bodyLarge?.apply(color: textColor);

    if (isSelected) {
      itemStyle = widget.config.selectedYearTextStyle ?? itemStyle;
    }

    Widget yearItem = _Year(
      onPressed: () {
        final month = widget.selectedDates.isNotEmpty ? widget.selectedDates[0]?.month ?? 1 : 1;

        widget.onChanged(DateTime(year, month));
      },
      year: year,
      isSelected: isSelected,
      isDisabled: isDisabled,
    );

    if (isDisabled) {
      yearItem = ExcludeSemantics(
        child: yearItem,
      );
    }

    return yearItem;
  }

  int get _itemCount {
    return widget.config.lastDate.year - widget.config.firstDate.year + 1;
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterial(context));

    return Column(
      children: <Widget>[
        Expanded(
          child: GridView.builder(
            controller: _scrollController,
            dragStartBehavior: widget.dragStartBehavior,
            gridDelegate: _yearPickerGridDelegate,
            itemBuilder: _buildYearItem,
            itemCount: math.max(_itemCount, minYears),
            padding: const EdgeInsets.symmetric(horizontal: _yearPickerPadding),
          ),
        ),
      ],
    );
  }
}

class _Year extends StatefulWidget {
  final int year;
  final VoidCallback onPressed;
  final bool isSelected;
  final bool isDisabled;

  const _Year({
    required this.year,
    required this.onPressed,
    required this.isSelected,
    required this.isDisabled,
  });

  @override
  State<_Year> createState() => _YearState();
}

class _YearState extends State<_Year> {
  bool _isPressed = false;

  void _onPressed(bool isPressed) {
    setState(() => _isPressed = isPressed);
  }

  @override
  Widget build(BuildContext context) {
    final tokens = Provider.of<ExpenseThemeManager>(context);
    final globalTokens = tokens.globals;
    final aliasTokens = tokens.alias;

    final double decorationHeight = globalTokens.shapes.size.s5x;
    const double decorationWidth = 72.0;

    TextStyle getTextColor() {
      Color textColor = aliasTokens.color.text.labelColor;

      if (widget.isSelected) {
        textColor = aliasTokens.color.selected.onLabelColor;
      } else if (widget.isDisabled) {
        textColor = aliasTokens.color.disabled.labelColor.withOpacity(
          globalTokens.shapes.opacity.low,
        );
      }

      return aliasTokens.mixin.labelMd2.apply(
        color: textColor,
      );
    }

    Color getBackgroundColor() {
      if (widget.isDisabled) return Colors.transparent;

      if (_isPressed) {
        return aliasTokens.mixin.pressedOutline;
      }

      return widget.isSelected ? aliasTokens.color.selected.bgColor : Colors.transparent;
    }

    return Center(
      child: GestureDetector(
        onTap: widget.isDisabled ? null : widget.onPressed,
        onTapDown: (details) => _onPressed(true),
        onTapUp: (details) => _onPressed(false),
        onTapCancel: () => _onPressed(false),
        child: Container(
          decoration: BoxDecoration(
            color: getBackgroundColor(),
            borderRadius: BorderRadius.circular(
              globalTokens.shapes.border.radiusCircular,
            ),
          ),
          height: decorationHeight,
          width: decorationWidth,
          child: Center(
            child: Semantics(
              selected: widget.isSelected,
              button: true,
              child: Text(
                widget.year.toString(),
                style: getTextColor(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _YearPickerGridDelegate extends SliverGridDelegate {
  const _YearPickerGridDelegate();

  @override
  SliverGridLayout getLayout(SliverConstraints constraints) {
    final double tileWidth = (constraints.crossAxisExtent - (_yearPickerColumnCount - 1) * _yearPickerRowSpacing) / _yearPickerColumnCount;

    return SliverGridRegularTileLayout(
      childCrossAxisExtent: tileWidth,
      childMainAxisExtent: _yearPickerRowHeight,
      crossAxisCount: _yearPickerColumnCount,
      crossAxisStride: tileWidth + _yearPickerRowSpacing,
      mainAxisStride: _yearPickerRowHeight,
      reverseCrossAxis: axisDirectionIsReversed(constraints.crossAxisDirection),
    );
  }

  @override
  bool shouldRelayout(_YearPickerGridDelegate oldDelegate) => false;
}

const _YearPickerGridDelegate _yearPickerGridDelegate = _YearPickerGridDelegate();
// coverage:ignore-end
