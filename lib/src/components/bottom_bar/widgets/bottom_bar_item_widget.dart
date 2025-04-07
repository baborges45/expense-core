part of '../bottom_bar_float.dart';

class BottomBarItemWidget extends StatefulWidget {
  /// Set a text that will be displayed on the label.
  final String label;

  /// Set a icon to displayed.
  final MudeIconData icon;

  /// Set a icon displayed if tab selected.
  final MudeIconData? iconFilled;

  /// Get index when the tab is pressed.
  final ValueChanged<int> onPressed;

  /// Set value to select a tab (index).
  final int value;

  /// Set if item is active.
  final bool active;

  /// Set if item is active and inverse you color.
  final bool activeInverse;

  /// Define if showing just icon.
  final bool onlyIcon;

  /// Define if showing just icon.
  final bool onlyIconActive;

  /// Set if showing symbol notification.
  final bool showNotification;

  /// Set if all colors is inverse.
  final bool inverse;

  ///A string value that provides a descriptive label for accessibility purposes.
  ///The default value is null
  final String? semanticsLabel;

  ///A string value that indicates additional accessibility information.
  ///The default value is null
  final String? semanticsHint;

  final TextStyle textSize;

  const BottomBarItemWidget({
    super.key,
    required this.label,
    required this.icon,
    required this.active,
    required this.value,
    required this.onPressed,
    this.iconFilled,
    this.onlyIcon = false,
    this.onlyIconActive = false,
    this.showNotification = false,
    this.inverse = false,
    this.activeInverse = false,
    required this.textSize,
    this.semanticsLabel,
    this.semanticsHint,
  });

  @override
  State<BottomBarItemWidget> createState() => _BottomBarItemWidgetState();
}

class _BottomBarItemWidgetState extends State<BottomBarItemWidget> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    var tokens = Provider.of<MudeThemeManager>(context);
    var globalTokens = tokens.globals;
    var aliasTokens = tokens.alias;
    final size = globalTokens.shapes.size;

    Color getTextColor() {
      if (widget.inverse) {
        return aliasTokens.color.inverse.labelColor;
      }

      if (widget.active && widget.activeInverse) {
        return aliasTokens.color.selected.onLabelColor;
      }

      return widget.active
          ? aliasTokens.color.selected.labelColor
          : aliasTokens.color.text.labelColor;
    }

    Widget getText() {
      if (widget.onlyIcon || (widget.onlyIconActive && widget.active)) {
        return const SizedBox.shrink();
      }

      return Text(
        widget.label,
        style: widget.textSize.merge(
          TextStyle(
            color: getTextColor(),
            overflow: TextOverflow.clip,
            fontWeight: globalTokens.typographys.fontWeightMedium,
          ),
        ),
      );
    }

    onPressedDown(_) {
      setState(() => _isPressed = true);
    }

    onPressedUp(_) {
      setState(() => _isPressed = false);
    }

    double opacity({
      required isPressed,
      required BuildContext context,
    }) {
      var tokens = Provider.of<MudeThemeManager>(context);
      var aliasTokens = tokens.alias;

      if (isPressed) return aliasTokens.color.pressed.containerOpacity;

      return 1;
    }

    bool isOnlyIcon = widget.onlyIconActive || widget.onlyIcon;
    String? labelSemantic =
        isOnlyIcon && widget.active ? widget.label : widget.semanticsLabel;

    return Semantics(
      label: widget.active ? 'Ativo $labelSemantic' : labelSemantic,
      hint: widget.semanticsHint,
      child: AnimatedOpacity(
        duration: globalTokens.motions.durations.fast02,
        opacity: widget.active
            ? 1
            : opacity(
                isPressed: _isPressed,
                context: context,
              ),
        child: GestureDetector(
          onTap: () => widget.onPressed(widget.value),
          onTapDown: onPressedDown,
          onTapUp: onPressedUp,
          onTapCancel: () => onPressedUp(null),
          child: Container(
            constraints: BoxConstraints(
              minWidth: size.s6x,
            ),
            decoration: BoxDecoration(
              color: _isPressed
                  ? aliasTokens.mixin.pressedOutline
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(
                globalTokens.shapes.border.radiusCircular,
              ),
            ),
            height: size.s6x,
            padding: widget.active
                ? EdgeInsets.symmetric(
                    horizontal: size.s2_5x,
                  )
                : EdgeInsets.zero,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _Icon(
                  active: widget.active,
                  iconFilled: widget.iconFilled,
                  icon: widget.icon,
                  inverse: widget.inverse,
                  activeInverse: widget.activeInverse,
                ),
                if (widget.active) ...[
                  SizedBox(width: globalTokens.shapes.spacing.s1x),
                  getText(),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// This is used to calculate the size of the current bar item.
class _FakeBottomBarWidget extends StatelessWidget {
  final MudeIconData icon;
  final String label;
  final TextStyle textSize;

  const _FakeBottomBarWidget({
    super.key,
    required this.icon,
    required this.label,
    required this.textSize,
  });

  @override
  Widget build(BuildContext context) {
    var tokens = Provider.of<MudeThemeManager>(context);
    var globalTokens = tokens.globals;
    final size = globalTokens.shapes.size;

    return Container(
      constraints: BoxConstraints(
        minWidth: size.s6x,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: size.s2_5x,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _Icon(
            active: true,
            iconFilled: icon,
            icon: icon,
            inverse: false,
            activeInverse: false,
          ),
          SizedBox(width: globalTokens.shapes.spacing.s1x),
          Text(
            label,
            style: textSize.merge(
              TextStyle(
                overflow: TextOverflow.clip,
                fontWeight: globalTokens.typographys.fontWeightMedium,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Icon extends StatelessWidget {
  final MudeIconData? iconFilled;
  final MudeIconData icon;
  final bool active;
  final bool inverse;
  final bool activeInverse;

  const _Icon({
    required this.active,
    required this.iconFilled,
    required this.icon,
    required this.inverse,
    required this.activeInverse,
  });

  @override
  Widget build(BuildContext context) {
    var tokens = Provider.of<MudeThemeManager>(context);
    var aliasTokens = tokens.alias;

    Color getColorIcon() {
      if (inverse && !active) {
        return aliasTokens.color.elements.iconColor;
      }

      if (active && activeInverse) {
        return aliasTokens.color.selected.onIconColor;
      }

      return active
          ? aliasTokens.color.selected.onBgColor
          : aliasTokens.color.elements.iconColor;
    }

    MudeIconData getIcon() {
      if (iconFilled != null && active) {
        return iconFilled!;
      }

      return icon;
    }

    return Center(
      child: MudeIcon(
        icon: getIcon(),
        color: getColorIcon(),
      ),
    );
  }
}
