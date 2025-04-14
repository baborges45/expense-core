import 'package:flutter/material.dart';
import 'package:expense_core/core.dart';
import 'package:provider/provider.dart';

import 'widgets/content_navigation_widget.dart';

class ExpenseListNavigationLine extends StatefulWidget {
  ///A string that represents the label for the list navigator.
  final String label;

  ///(Optional) A string that provides a short description of the list item.
  final String? description;

  /// A dynamic type that can be this one of these:
  /// [ExpenseIconData], [ExpenseImage], [ExpenseAvatarName], [ExpenseAvatarIcon],
  /// [ExpenseAvatarIcon], [ExpenseCreditCard].
  final dynamic leading;

  ///(Optional)  A tag that can be used to identify the list item.
  final ExpenseTagContainer? tag;

  ///(Optional) A [VoidCallback] that is called when the list item is pressed.
  final VoidCallback? onPressed;

  ///A [ExpenseListNavigationPosition] enum representing the currently line position in the list navigation.
  ///It can be top, bottom and none.
  final ExpenseListNavigationPosition linePosition;

  ///A string value that provides a descriptive label for accessibility purposes.
  ///The default value is null
  final String? semanticsLabel;

  ///A string value that indicates additional accessibility information.
  ///The default value is null
  final String? semanticsHint;

  const ExpenseListNavigationLine({
    super.key,
    required this.label,
    this.description,
    this.leading,
    this.tag,
    this.onPressed,
    this.linePosition = ExpenseListNavigationPosition.top,
    this.semanticsLabel,
    this.semanticsHint,
  });

  @override
  State<ExpenseListNavigationLine> createState() => _ExpenseListNavigationLineState();
}

class _ExpenseListNavigationLineState extends State<ExpenseListNavigationLine> {
  bool _isPressed = false;

  _onPressedDown(_) {
    if (widget.onPressed == null) return;
    setState(() => _isPressed = true);
  }

  _onPressedUp(_) {
    if (widget.onPressed == null) return;
    setState(() => _isPressed = false);
  }

  @override
  Widget build(BuildContext context) {
    var tokens = Provider.of<ExpenseThemeManager>(context);
    var globalTokens = tokens.globals;
    var aliasTokens = tokens.alias;

    Color getBackgroundColor() {
      return _isPressed ? aliasTokens.mixin.pressedOutline : Colors.transparent;
    }

    double getOpacity() {
      return _isPressed ? aliasTokens.color.pressed.containerOpacity : 1;
    }

    Border? getBorder() {
      if (widget.linePosition == ExpenseListNavigationPosition.top) {
        return Border(
          top: BorderSide(
            color: aliasTokens.color.elements.borderColor,
            width: aliasTokens.defaultt.borderWidth,
          ),
        );
      }

      if (widget.linePosition == ExpenseListNavigationPosition.bottom) {
        return Border(
          bottom: BorderSide(
            color: aliasTokens.color.elements.borderColor,
            width: aliasTokens.defaultt.borderWidth,
          ),
        );
      }

      return null;
    }

    return Semantics(
      button: true,
      label: widget.semanticsLabel,
      hint: widget.semanticsHint,
      excludeSemantics: widget.semanticsLabel != null,
      child: GestureDetector(
        onTap: widget.onPressed,
        onTapDown: _onPressedDown,
        onTapUp: _onPressedUp,
        onTapCancel: () => _onPressedUp(null),

        // Container
        child: Opacity(
          opacity: getOpacity(),

          // Container
          child: Container(
            height: globalTokens.shapes.size.s11x,
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: getBackgroundColor(),
              border: getBorder(),
            ),

            // Content
            child: ContentNavigationWidget(
              description: widget.description,
              label: widget.label,
              leading: widget.leading,
              tag: widget.tag,
            ),
          ),
        ),
      ),
    );
  }
}
