// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:mude_core/core.dart';
import 'widgets/content_widget.dart';

class MudeTestimonial extends StatelessWidget {
  ///A string representing the label text
  final String label;

  ///A string text that will be displayed as the description.
  final String description;

  /// A dynamic type that can be this one of these:
  /// [MudeIconData], [MudeImage], [MudeAvatarName], [MudeAvatarIcon],
  /// [MudeAvatarIcon].
  final dynamic leading;

  /// A [MudeButtonMini] button that will be displayed on the right.
  final MudeButtonIcon? trailingButton;

  ///A string value that provides a descriptive label for accessibility purposes.
  ///The default value is null
  final String? semanticsLabel;

  ///A string value that indicates additional accessibility information.
  ///The default value is null
  final String? semanticsHint;

  const MudeTestimonial({
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
