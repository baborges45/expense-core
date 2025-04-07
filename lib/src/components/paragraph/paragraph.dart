import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:mude_core/core.dart';

class MudeParagraph extends StatelessWidget {
  /// Set a text to display in the paragraph.
  final String text;

  /// Set a size, you get all options in [MudeHeadingSize].
  /// If you don't he will assume [MudeHeadingSize.lg].
  final MudeParagraphSize size;

  /// Set true to displayed heading inverse.
  final bool inverse;

  /// A string value that indicates additional accessibility information.
  /// The default value is null
  final String? semanticsHint;

  /// Indicates if the paragraph is expanded.
  final bool isExpanded;

  /// Set the overflow behavior of the text.
  final TextOverflow overflow;

  /// Set the maximum number of lines for the text.
  final int? maxLines;

  const MudeParagraph(
    this.text, {
    super.key,
    this.size = MudeParagraphSize.lg,
    this.inverse = false,
    this.semanticsHint,
    this.isExpanded = false,
    this.overflow = TextOverflow.ellipsis,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    var tokens = Provider.of<MudeThemeManager>(context);
    var globalTokens = tokens.globals;
    var aliasTokens = tokens.alias;

    double getSize(MudeParagraphSize size) {
      switch (size) {
        case MudeParagraphSize.lg:
          return globalTokens.typographys.fontSizeXs;
        case MudeParagraphSize.sm:
          return globalTokens.typographys.fontSize2xs;
      }
    }

    Color getColor() {
      return inverse ? aliasTokens.color.inverse.paragraphColor : aliasTokens.color.text.paragraphColor;
    }

    return Semantics(
      hint: semanticsHint,
      child: Text(
        text,
        overflow: isExpanded ? TextOverflow.visible : overflow,
        maxLines: isExpanded ? null : maxLines ?? 3,
        style: TextStyle(
          color: getColor(),
          fontFamily: globalTokens.typographys.fontFamilyBase,
          fontWeight: globalTokens.typographys.fontWeightRegular,
          fontSize: getSize(size),
          height: globalTokens.typographys.lineHeightMd,
          letterSpacing: globalTokens.typographys.letterSpacingDefault,
        ),
      ),
    );
  }
}
