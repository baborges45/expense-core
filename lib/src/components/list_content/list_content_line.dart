// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:expense_core/core.dart';
import 'package:provider/provider.dart';

import 'widgets/content_widget.dart';

class ExpenseListContentLine extends StatelessWidget {
  ///A string representing the label text
  final String label;

  ///(Optional) A string text that will be displayed as the description.
  final String description;

  ///(Optional) A string label text that will be displayed on the right side.
  final String? labelRight;

  ///(Optional) A string description text that will be displayed on the right side.
  final String? descriptionRight;

  /// A dynamic type that can be this one of these:
  /// [ExpenseIconData], [ExpenseImage], [ExpenseAvatarName], [ExpenseAvatarIcon],
  /// [ExpenseAvatarIcon], [ExpenseCreditCard].
  final dynamic leading;

  ///(Optional) A [ExpenseButtonMini] button that will be displayed on the right.
  final ExpenseButtonIcon? trailingButton;

  /// A [ExpenseListContentPosition] that defines the position of the border line
  /// It can be a top, bottom or none.
  /// The default value is none.
  final ExpenseListContentPosition linePosition;

  ///A string value that provides a descriptive label for accessibility purposes.
  ///The default value is null
  final String? semanticsLabel;

  ///A string value that indicates additional accessibility information.
  ///The default value is null
  final String? semanticsHint;

  const ExpenseListContentLine({
    super.key,
    required this.label,
    this.description = '',
    this.labelRight,
    this.descriptionRight,
    this.leading,
    this.trailingButton,
    this.semanticsLabel,
    this.semanticsHint,
    this.linePosition = ExpenseListContentPosition.top,
  });

  @override
  Widget build(BuildContext context) {
    var tokens = Provider.of<ExpenseThemeManager>(context);
    var globalTokens = tokens.globals;
    var aliasTokens = tokens.alias;

    Border? getBorder() {
      if (linePosition == ExpenseListContentPosition.top) {
        return Border(
          top: BorderSide(
            color: aliasTokens.color.elements.borderColor,
            width: aliasTokens.defaultt.borderWidth,
          ),
        );
      }
      if (linePosition == ExpenseListContentPosition.bottom) {
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
      container: true,
      label: semanticsLabel,
      hint: semanticsHint,
      excludeSemantics: semanticsLabel != null,
      child: Container(
        height: globalTokens.shapes.size.s11x,
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: getBorder(),
        ),
        child: ContentWidget(
          label: label,
          description: description,
          labelRight: labelRight,
          descriptionRight: descriptionRight,
          leading: leading,
          trailingButton: trailingButton,
        ),
      ),
    );
  }
}
