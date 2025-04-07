import 'package:flutter/material.dart';
import 'package:mude_core/core.dart';
import 'package:provider/provider.dart';

import 'widgets/content_widget.dart';

class MudeListContentGhost extends StatelessWidget {
  ///A string representing the label text
  final String label;

  ///(Optional) A string text that will be displayed as the description.
  final String description;

  ///(Optional) A string description text that will be displayed on the right side.
  final String? descriptionRight;

  /// A dynamic type that can be this one of these:
  /// [MudeIconData], [MudeImage], [MudeAvatarName], [MudeAvatarIcon],
  /// [MudeAvatarIcon], [MudeCreditCard].
  final dynamic leading;

  ///A string value that provides a descriptive label for accessibility purposes.
  ///The default value is null
  final String? semanticsLabel;

  ///A string value that indicates additional accessibility information.
  ///The default value is null
  final String? semanticsHint;

  const MudeListContentGhost({
    super.key,
    required this.label,
    this.description = '',
    this.descriptionRight,
    this.leading,
    this.semanticsLabel,
    this.semanticsHint,
  });

  @override
  Widget build(BuildContext context) {
    var tokens = Provider.of<MudeThemeManager>(context);
    var globalTokens = tokens.globals;

    return Semantics(
      container: true,
      label: semanticsLabel,
      hint: semanticsHint,
      excludeSemantics: semanticsLabel != null,
      child: SizedBox(
        height: globalTokens.shapes.size.s7x,
        child: ContentWidget(
          label: label,
          description: description,
          descriptionRight: descriptionRight,
          leading: leading,
        ),
      ),
    );
  }
}
