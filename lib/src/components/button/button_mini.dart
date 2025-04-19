import 'package:flutter/material.dart';
import 'package:expense_core/core.dart';
import 'package:provider/provider.dart';

import 'mixins/properties_mixin.dart';

class ExpenseButtonMini extends StatefulWidget {
  ///A string that represents the text label displayed on the button.
  final String label;

  ///A callback function that will be invoked when the button is pressed.
  final VoidCallback onPressed;

  ///A boolean value indicating whether the button is disabled or not.
  ///If disabled, the button will not respond to press events.
  final bool disabled;

  ///(Optional) A boolean parameter that specifies whether the link should have an inverse color scheme.
  ///The default value is false.
  final bool inverse;

  ///A string value that indicates if you add more information from accessibility
  ///The default value is null
  final String? semanticsLabel;

  ///A string value that indicates if you add more information from accessibility
  ///The default value is null
  final String? semanticsHint;

  ///A boolean value can be utilized to determine whether child semantics will be taken into consideration or not.
  ///The default value is false.
  final bool excludeSemantics;

  /// Set a color type to displayed.
  final ExpenseButtonColorType type;

  /// Set a icon to displayed.
  final ExpenseIconData? icon;

  /// Set a icon to displayed.
  final bool isIconNav;

  /// A boolean value indicating whether the text should be underlined.
  final bool underline;

  const ExpenseButtonMini({
    super.key,
    required this.label,
    required this.onPressed,
    this.disabled = false,
    this.inverse = false,
    this.semanticsLabel,
    this.semanticsHint,
    this.excludeSemantics = false,
    this.icon,
    this.type = ExpenseButtonColorType.positive,
    this.isIconNav = true,
    this.underline = false,
  });

  @override
  State<ExpenseButtonMini> createState() => _ExpenseButtonMiniState();
}

class _ExpenseButtonMiniState extends State<ExpenseButtonMini> with PropertiesMixin, WidgetsBindingObserver {
  bool _isPressed = false;
  double _sizeWidth = 0;

  final _keyContent = GlobalKey();

  _onPressedDown(_) {
    if (widget.disabled) return null;
    setState(() => _isPressed = true);
  }

  _onPressedUp(_) {
    if (widget.disabled) return null;
    setState(() => _isPressed = false);
  }

  _onPressed() {
    if (widget.disabled) return;

    return widget.onPressed();
  }

  _getSizeContent() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (_keyContent.currentContext == null) return;
      final size = _keyContent.currentContext!.size;
      setState(() => _sizeWidth = size!.width);
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) => _getSizeContent());
  }

  @override
  void didChangeMetrics() {
    WidgetsBinding.instance.addPostFrameCallback((_) => _getSizeContent());
    super.didChangeMetrics();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tokens = Provider.of<ExpenseThemeManager>(context);
    final globalTokens = tokens.globals;
    final aliasTokens = tokens.alias;
    final spacing = globalTokens.shapes.spacing;
    final size = globalTokens.shapes.size;

    double opacity = getOpacity(
      disabled: widget.disabled,
      isPressed: _isPressed,
      context: context,
    );

    Color getTextColor() {
      final elements = aliasTokens.color;
      final color = switch (widget.type) {
        ExpenseButtonColorType.positive => elements.action.labelPrimaryColor,
        ExpenseButtonColorType.negative => elements.negative.labelColor,
        ExpenseButtonColorType.inverse => elements.inverse.labelColor,
        ExpenseButtonColorType.disabled => elements.disabled.labelColor,
      };

      return color;
    }

    Color getBackgroundColor() {
      if (_isPressed) {
        return widget.inverse ? aliasTokens.mixin.pressedOutlineInverse : aliasTokens.mixin.pressedOutline;
      }

      return Colors.transparent;
    }

    Widget iconShow = widget.icon != null
        ? Padding(
            padding: EdgeInsets.only(
              right: spacing.half,
            ),
            child: ExpenseIcon(
              key: const Key('ds-button-icon'),
              icon: widget.isIconNav ? ExpenseIcons.navigationRightLine : widget.icon!,
              color: aliasTokens.color.elements.iconColor,
              size: ExpenseIconSize.sm,
            ),
          )
        : const SizedBox.shrink();

    return Semantics(
      button: true,
      label: widget.semanticsLabel,
      hint: widget.semanticsHint,
      excludeSemantics: widget.excludeSemantics,
      enabled: !widget.disabled,
      child: Opacity(
        opacity: opacity,
        child: GestureDetector(
          onTap: _onPressed,
          onTapDown: _onPressedDown,
          onTapUp: _onPressedUp,
          onTapCancel: () => _onPressedUp(null),
          child: IntrinsicWidth(
            child: Row(
              children: [
                Container(
                  height: size.s6x,
                  color: Colors.transparent,
                  child: Center(
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        //
                        // Pressed
                        if (_isPressed)
                          Positioned(
                            top: -spacing.s1_5x,
                            left: -spacing.s1_5x,
                            child: Container(
                              key: const Key('button-mini.background'),
                              height: size.s5x,
                              width: _sizeWidth + spacing.s3x,
                              decoration: BoxDecoration(
                                color: getBackgroundColor(),
                                borderRadius: BorderRadius.circular(
                                  globalTokens.shapes.border.radiusCircular,
                                ),
                              ),
                            ),
                          ),

                        // Text
                        IntrinsicWidth(
                          child: Text(
                            key: _keyContent,
                            // key: const Key('ds-label'),
                            widget.label,
                            style: aliasTokens.mixin.labelLg2.merge(
                              TextStyle(
                                color: getTextColor(),
                                decoration: widget.underline ? TextDecoration.underline : TextDecoration.none,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                iconShow,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
