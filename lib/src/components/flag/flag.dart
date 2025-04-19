import 'package:flutter/material.dart';
import 'package:expense_core/core.dart';
import 'package:provider/provider.dart';

import 'widgets/description.dart';

class ExpenseFlag extends StatelessWidget {
  ///A string representing the label or text of the button.
  final String message;

  ///(Optional) An [AlertHyperLink] object that represents a hyperlink in the widget.
  ///It will be displayed in the end of the text.
  final ExpenseFlagHyperLink? hyperLink;

  ///A ExpenseFlagType type that represents the type or category of the flag,
  ///It can be positive, informative, negative, promote, or warning.
  final ExpenseFlagType type;

  ///A string value that provides a descriptive label for accessibility purposes.
  ///The default value is null
  final String? semanticsLabel;

  ///A string value that indicates additional accessibility information.
  ///The default value is null
  final String? semanticsHint;

  const ExpenseFlag({
    super.key,
    required this.type,
    this.hyperLink,
    this.semanticsLabel,
    this.semanticsHint,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    final tokens = Provider.of<ExpenseThemeManager>(context);
    final globalTokens = tokens.globals;
    final aliasTokens = tokens.alias;
    final spacing = globalTokens.shapes.spacing;

    Color getBackgroundColor() {
      switch (type) {
        case ExpenseFlagType.positive:
          return aliasTokens.color.positive.bgColor;
        case ExpenseFlagType.informative:
          return aliasTokens.color.informative.bgColor;
        case ExpenseFlagType.negative:
          return aliasTokens.color.negative.bgColor;
        case ExpenseFlagType.promote:
          return aliasTokens.color.promote.bgColor;
        case ExpenseFlagType.warning:
          return aliasTokens.color.warning.bgColor;
      }
    }

    ExpenseIconData getIcon() {
      switch (type) {
        case ExpenseFlagType.positive:
          return ExpenseIcons.positiveLine;
        case ExpenseFlagType.informative:
          return ExpenseIcons.informationLine;
        case ExpenseFlagType.negative:
          return ExpenseIcons.negativeLine;
        case ExpenseFlagType.promote:
          return ExpenseIcons.promoteLine;
        case ExpenseFlagType.warning:
          return ExpenseIcons.warningLine;
      }
    }

    Color getIconColor() {
      switch (type) {
        case ExpenseFlagType.positive:
          return aliasTokens.color.positive.onIconColor;
        case ExpenseFlagType.informative:
          return aliasTokens.color.informative.onIconColor;
        case ExpenseFlagType.negative:
          return aliasTokens.color.negative.onIconColor;
        case ExpenseFlagType.promote:
          return aliasTokens.color.promote.onIconColor;
        case ExpenseFlagType.warning:
          return aliasTokens.color.warning.onIconColor;
      }
    }

    String getSemanticsLabel() {
      final labelSemantics = semanticsLabel ?? message;
      final linkSemantics = hyperLink != null ? hyperLink!.text : '';

      switch (type) {
        case ExpenseFlagType.positive:
          return 'positivo: $labelSemantics $linkSemantics';
        case ExpenseFlagType.informative:
          return 'informativo: $labelSemantics $linkSemantics';
        case ExpenseFlagType.negative:
          return 'negativo: $labelSemantics $linkSemantics';
        case ExpenseFlagType.promote:
          return 'promoção: $labelSemantics $linkSemantics';
        case ExpenseFlagType.warning:
          return 'atenção: $labelSemantics $linkSemantics';
      }
    }

    return Semantics(
      container: true,
      label: getSemanticsLabel(),
      hint: semanticsHint,
      excludeSemantics: true,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: spacing.s3x,
        ),
        constraints: BoxConstraints(minHeight: globalTokens.shapes.size.s7x),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            aliasTokens.defaultt.borderRadius,
          ),
          color: getBackgroundColor(),
        ),
        child: Row(
          children: [
            ExcludeSemantics(
              child: ExpenseIcon(
                icon: getIcon(),
                color: getIconColor(),
              ),
            ),
            SizedBox(
              width: spacing.s1x,
            ),
            Expanded(
              child: FlagDescription(
                type: type,
                message: message,
                hyperLink: hyperLink,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
