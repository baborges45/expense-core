// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:expense_core/core.dart';
import 'widgets/content_widget.dart';

class ExpenseTestimonial extends StatelessWidget {
  ///A string representing the label text
  final String label;

  ///A string text that will be displayed as the description.
  final String description;

  /// A dynamic type that can be this one of these:
  /// [ExpenseIconData], [ExpenseImage], [ExpenseAvatarName], [ExpenseAvatarIcon],
  /// [ExpenseAvatarIcon].
  final dynamic leading;

  /// A [ExpenseButtonMini] button that will be displayed on the right.
  final ExpenseButtonIcon? trailingButton;

  ///A string value that provides a descriptive label for accessibility purposes.
  ///The default value is null
  final String? semanticsLabel;

  ///A string value that indicates additional accessibility information.
  ///The default value is null
  final String? semanticsHint;

  const ExpenseTestimonial({
    super.key,
    required this.label,
    required this.description,
    this.leading,
    this.trailingButton,
    this.semanticsLabel,
    this.semanticsHint,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      label: semanticsLabel,
      hint: semanticsHint,
      excludeSemantics: semanticsLabel != null,
      child: ContentWidget(
        label: label,
        leading: leading,
        trailingButton: trailingButton,
        description: description,
      ),
    );
  }
}
