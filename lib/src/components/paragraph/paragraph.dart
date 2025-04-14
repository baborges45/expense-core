import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:expense_core/core.dart';

class ExpenseParagraph extends StatelessWidget {
  /// Set a text to display in the paragraph.
  final String text;

  /// Set a size, you get all options in [ExpenseHeadingSize].
  /// If you don't he will assume [ExpenseHeadingSize.lg].
  final ExpenseParagraphSize size;

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

  const ExpenseParagraph(
    this.text, {
    super.key,
    this.size = ExpenseParagraphSize.lg,
    this.inverse = false,
    this.semanticsHint,
    this.isExpanded = false,
    this.overflow = TextOverflow.ellipsis,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    var tokens = Provider.of<ExpenseThemeManager>(context);
    var globalTokens = tokens.globals;
    var aliasTokens = tokens.alias;

    double getSize(ExpenseParagraphSize size) {
      switch (size) {
        case ExpenseParagraphSize.lg:
          return globalTokens.typographys.fontSizeXs;
        case ExpenseParagraphSize.sm:
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
