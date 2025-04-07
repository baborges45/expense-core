// coverage:ignore-start
part of '../date_picker.dart';

/// A button that used to toggle the [DatePickerMode] for a date picker.
///
/// This appears above the calendar grid and allows the user to toggle the
/// [DatePickerMode] to display either the calendar view or the year list.
class _DatePickerModeToggleButton extends StatefulWidget {
  const _DatePickerModeToggleButton({
    required this.mode,
    required this.title,
    required this.onTitlePressed,
    required this.config,
  });

  /// The current display of the calendar picker.
  final MudeDatePickerMode mode;

  /// The text that displays the current month/year being viewed.
  final String title;

  /// The callback when the title is pressed.
  final VoidCallback onTitlePressed;

  /// The calendar configurations
  final MudeDatePickerConfig config;

  @override
  _DatePickerModeToggleButtonState createState() =>
      _DatePickerModeToggleButtonState();
}

class _DatePickerModeToggleButtonState
    extends State<_DatePickerModeToggleButton>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  //
  bool _isPressed = false;
  double _sizeWidth = 0;
  final _keyContent = GlobalKey();
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      value: widget.mode == MudeDatePickerMode.year ? 0.5 : 0,
      upperBound: 0.5,
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) => _getSizeContent());
  }

  @override
  void didChangeMetrics() {
    WidgetsBinding.instance.addPostFrameCallback((_) => _getSizeContent());
    super.didChangeMetrics();
  }

  @override
  void didUpdateWidget(_DatePickerModeToggleButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    _getSizeContent();

    if (oldWidget.mode == widget.mode) {
      return;
    }

    if (widget.mode == MudeDatePickerMode.year) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  void _onPressed(bool isPressed) {
    if (widget.config.disableModePicker == true) return;
    setState(() => _isPressed = isPressed);
  }

  void _getSizeContent() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (_keyContent.currentContext == null) return;
      final size = _keyContent.currentContext!.size;
      setState(() => _sizeWidth = size!.width);
    });
  }

  void _onTilePressed() {
    if (widget.config.disableModePicker == true) return;
    widget.onTitlePressed();
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      child: Container(
        padding: const EdgeInsetsDirectional.only(start: 26, end: 2),
        height: _subHeaderHeight,
        child: Row(
          children: [
            Flexible(
              child: Semantics(
                label:
                    MaterialLocalizations.of(context).selectYearSemanticsLabel,
                excludeSemantics: true,
                button: true,
                child: SizedBox(
                  height: _subHeaderHeight,
                  child: GestureDetector(
                    key: const Key('calendar-mode.gesture'),
                    onTap: _onTilePressed,
                    onTapDown: (_) => _onPressed(true),
                    onTapUp: (_) => _onPressed(false),
                    onTapCancel: () => _onPressed(false),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 0, right: 8, top: 6),
                      child: IntrinsicWidth(
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            _Month(
                              keyContent: _keyContent,
                              controller: _controller,
                              widget: widget,
                              hasChangedYear:
                                  widget.config.disableModePicker == true,
                            ),
                            _ContainerPressed(
                              show: _isPressed,
                              sizeWidth: _sizeWidth,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            if (widget.mode == MudeDatePickerMode.day)
              const SizedBox(width: _monthNavButtonsWidth),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class _Month extends StatelessWidget {
  final GlobalKey<State<StatefulWidget>> keyContent;
  final _DatePickerModeToggleButton widget;
  final AnimationController controller;
  final bool hasChangedYear;

  const _Month({
    required this.keyContent,
    required this.widget,
    required this.controller,
    required this.hasChangedYear,
  });

  @override
  Widget build(BuildContext context) {
    final tokens = Provider.of<MudeThemeManager>(context);
    final globalTokens = tokens.globals;
    final aliasTokens = tokens.alias;

    return Container(
      key: keyContent,
      color: Colors.transparent,
      height: globalTokens.shapes.size.s6x,
      child: Row(
        children: [
          Flexible(
            child: Text(
              widget.title,
              overflow: TextOverflow.ellipsis,
              style: aliasTokens.mixin.labelLg2.apply(
                color: aliasTokens.color.action.labelPrimaryColor,
              ),
            ),
          ),
          SizedBox(
            width: globalTokens.shapes.spacing.s1x,
          ),
          if (!hasChangedYear)
            RotationTransition(
              turns: controller,
              child: MudeIcon(icon: MudeIcons.dropdownOpenLine),
            ),
        ],
      ),
    );
  }
}

class _ContainerPressed extends StatelessWidget {
  final bool show;
  final double sizeWidth;

  const _ContainerPressed({
    required this.show,
    required this.sizeWidth,
  });

  @override
  Widget build(BuildContext context) {
    if (!show) return const SizedBox.shrink();

    final tokens = Provider.of<MudeThemeManager>(context);
    final globalTokens = tokens.globals;
    final aliasTokens = tokens.alias;
    final size = globalTokens.shapes.size;

    return Positioned(
      top: 8,
      left: -size.s1x,
      child: Container(
        height: size.s4x,
        width: sizeWidth + size.s2x,
        decoration: BoxDecoration(
          color: aliasTokens.mixin.pressedOutline,
          borderRadius: BorderRadius.circular(
            aliasTokens.defaultt.borderRadius,
          ),
        ),
      ),
    );
  }
}
// coverage:ignore-end