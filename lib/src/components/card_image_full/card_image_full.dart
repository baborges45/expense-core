import 'package:flutter/material.dart';
import 'package:expense_core/core.dart';
import 'package:expense_core/src/utils/check_url_is_valid.dart';
import 'package:provider/provider.dart';

class ExpenseCardImageFull extends StatefulWidget {
  /// Set a local or web path to load an image
  final String src;

  /// Set the heroTag value
  final String? heroTag;

  /// Set size [height] in container is apply
  final double height;

  /// Set a new [Widget] to displayed.
  final Widget? child;

  /// Set a function to call when Card is pressed.
  final VoidCallback? onPressed;

  /// Set a new [BoxFit] to manipulate position image
  /// You get all options in [BoxFit]
  final BoxFit fit;

  ///A string value that provides a descriptive label for accessibility purposes.
  ///The default value is null
  final String? semanticsLabel;

  ///A string value that indicates additional accessibility information.
  ///The default value is null
  final String? semanticsHint;

  const ExpenseCardImageFull({
    super.key,
    required this.src,
    required this.height,
    this.child,
    this.heroTag,
    this.onPressed,
    this.fit = BoxFit.cover,
    this.semanticsLabel,
    this.semanticsHint,
  });

  @override
  State<ExpenseCardImageFull> createState() => _ExpenseCardImageFullState();
}

class _ExpenseCardImageFullState extends State<ExpenseCardImageFull> {
  bool _isPressed = false;

  _onPressedDown(_) {
    if (widget.onPressed != null) {
      setState(() => _isPressed = true);
    }
  }

  _onPressedUp(_) {
    if (widget.onPressed != null) {
      setState(() => _isPressed = false);
    }
  }

  _onPressed() {
    if (widget.onPressed != null) {
      return widget.onPressed!();
    }
  }

  @override
  Widget build(BuildContext context) {
    var tokens = Provider.of<ExpenseThemeManager>(context);
    var globalTokens = tokens.globals;
    var aliasTokens = tokens.alias;
    var size = globalTokens.shapes.size;
    final spacing = globalTokens.shapes.spacing;

    Widget getImage() {
      var sourceLoad = urlIsvalid(widget.src) ? ExpenseImage.network : ExpenseImage.asset;

      return Hero(
        tag: widget.heroTag ?? UniqueKey(),
        child: sourceLoad(
          borderRadius: BorderRadius.circular(
            aliasTokens.defaultt.borderRadius,
          ),
          widget.src,
          fit: widget.fit,
          fillContainer: true,
        ),
      );
    }

    double getOpacity() {
      return _isPressed ? aliasTokens.color.pressed.containerOpacity : 1;
    }

    return Semantics(
      button: true,
      label: widget.semanticsLabel,
      hint: widget.semanticsHint,
      child: GestureDetector(
        onTap: _onPressed,
        onTapDown: _onPressedDown,
        onTapUp: _onPressedUp,
        onTapCancel: () => _onPressedUp(null),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(
            aliasTokens.defaultt.borderRadius,
          ),
          child: Opacity(
            opacity: getOpacity(),
            child: SizedBox(
              width: size.s30x,
              height: widget.height,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  getImage(),
                  const _Gradient(),
                  Container(
                    color: Colors.transparent,
                    width: double.maxFinite,
                    constraints: BoxConstraints(
                      minHeight: size.s9x,
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: spacing.s2x,
                      vertical: spacing.s3x,
                    ),
                    child: widget.child,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Gradient extends StatelessWidget {
  const _Gradient();

  @override
  Widget build(BuildContext context) {
    var tokens = Provider.of<ExpenseThemeManager>(context);
    var globalTokens = tokens.globals;
    var aliasTokens = tokens.alias;

    return Container(
      constraints: BoxConstraints(
        minHeight: globalTokens.shapes.size.s20x,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: aliasTokens.mixin.overlayGradient,
        ),
      ),
    );
  }
}
