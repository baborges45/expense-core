import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:mude_core/core.dart';
import 'package:provider/provider.dart';

import '../mixins/properties_mixin.dart';

class ContainerButtonWidget extends StatefulWidget {
  final String label;
  final TextStyle? labelStyle;
  final VoidCallback onPressed;
  final double? width;
  final List<BoxShadow>? boxShadow;
  final MudeIconData? icon;
  final Widget? child;
  final bool disabled;
  final bool loading;
  final bool isFixedFull;
  final bool inverse;
  final String? semanticsLabel;
  final String? semanticsHint;
  final bool excludeSemantics;
  final double? minWidth;
  final bool isFloat;
  final bool negative;

  const ContainerButtonWidget({
    super.key,
    required this.label,
    required this.onPressed,
    this.labelStyle,
    this.width,
    this.minWidth,
    this.boxShadow,
    this.icon,
    this.child,
    this.disabled = false,
    this.loading = false,
    this.isFixedFull = false,
    this.inverse = false,
    this.semanticsLabel,
    this.semanticsHint,
    this.excludeSemantics = false,
    this.isFloat = false,
    this.negative = false,
  });

  @override
  State<ContainerButtonWidget> createState() => _ContainerButtonState();
}

class _ContainerButtonState extends State<ContainerButtonWidget> with PropertiesMixin {
  bool _isPressed = false;

  _onPressedDown(_) {
    if (widget.disabled || widget.loading) return null;
    setState(() => _isPressed = true);
  }

  _onPressedUp(_) {
    if (widget.disabled || widget.loading) return null;
    setState(() => _isPressed = false);
  }

  _onPressed() {
    if (widget.disabled || widget.loading) return null;

    return widget.onPressed();
  }

  @override
  void didUpdateWidget(covariant ContainerButtonWidget oldWidget) {
    if (widget.loading) {
      SemanticsService.announce('Carregando', TextDirection.ltr);
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    var tokens = Provider.of<MudeThemeManager>(context);
    var globalTokens = tokens.globals;
    var aliasTokens = tokens.alias;
    var spacing = globalTokens.shapes.spacing;
    var size = globalTokens.shapes.size;
    var durations = globalTokens.motions.durations;

    Color getTextColors() {
      if (widget.disabled && widget.isFloat) {
        return aliasTokens.color.disabled.onLabelColor;
      }

      return getTextColor(
        disabled: widget.disabled && !widget.loading && !widget.isFloat,
        inverse: widget.inverse,
        negative: widget.negative,
        context: context,
      );
    }

    Color textColor = getTextColors();

    Color getBackgroundColors() {
      if (widget.disabled && widget.isFloat) {
        return aliasTokens.color.elements.bgColor04;
      }

      return getBackgroundColor(
        disabled: widget.disabled && !widget.loading,
        inverse: widget.inverse,
        negative: widget.negative,
        context: context,
      );
    }

    Color backgroundColor = getBackgroundColors();

    double opacity = getOpacity(
      disabled: widget.disabled && !widget.loading,
      isPressed: _isPressed,
      context: context,
    );

    Widget getButton() {
      Widget getText() {
        Widget iconShow = widget.icon != null
            ? Padding(
                padding: EdgeInsets.only(
                  right: spacing.s1x,
                ),
                child: MudeIcon(
                  key: const Key('ds-button-icon'),
                  icon: widget.icon!,
                  color: textColor,
                  size: MudeIconSize.lg,
                ),
              )
            : const SizedBox.shrink();

        return Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: widget.minWidth != null ? spacing.s2x : spacing.s5x,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                iconShow,
                Text(
                  widget.label,
                  style: (widget.labelStyle ?? aliasTokens.mixin.labelLg2).merge(
                    TextStyle(
                      color: textColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }

      Widget getChild() {
        if (widget.loading) {
          return Stack(
            children: [
              // Text
              Opacity(opacity: 0, child: getText()),

              // Loading
              const Positioned.fill(
                child: Align(
                  alignment: Alignment.center,
                  child: MudeLoading(),
                ),
              ),
            ],
          );
        }

        return widget.child ?? getText();
      }

      double? width = widget.isFixedFull ? double.maxFinite : null;

      double? height = widget.isFixedFull ? size.s10x : size.s8x;

      double borderRadius = widget.isFixedFull ? 0 : globalTokens.shapes.border.radiusCircular;

      return Semantics(
        button: true,
        label: widget.semanticsLabel,
        hint: widget.semanticsHint,
        enabled: !widget.disabled,
        excludeSemantics: widget.excludeSemantics,
        child: AnimatedOpacity(
          duration: durations.fast02,
          opacity: opacity,
          child: GestureDetector(
            onTap: _onPressed,
            onTapDown: _onPressedDown,
            onTapUp: _onPressedUp,
            onTapCancel: () => _onPressedUp(null),
            child: AnimatedContainer(
              key: const Key('ds-container-widget-button'),
              duration: durations.fast02,
              constraints: BoxConstraints(minWidth: widget.minWidth ?? 148),
              height: height,
              width: width,
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(borderRadius),
                boxShadow: widget.boxShadow,
              ),
              child: getChild(),
            ),
          ),
        ),
      );
    }

    if (widget.width != null || widget.isFixedFull) {
      return getButton();
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        getButton(),
      ],
    );
  }
}
