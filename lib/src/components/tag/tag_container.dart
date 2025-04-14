import 'package:flutter/material.dart';
import 'package:expense_core/core.dart';
import 'package:provider/provider.dart';

import 'mixins/accessibility_mixin.dart';

class ExpenseTagContainer extends StatelessWidget with AccessibilityMixin {
  ///A String representing the label of the tag.
  final String tag;

  ///A ExpenseTagStatus enum object representing the status of the tag.
  ///The default is ExpenseTagStatus.neutral.
  final ExpenseTagStatus status;

  ///(Optional) A boolean parameter that specifies whether the link should have an inverse color scheme.
  ///The default value is false.
  final bool inverse;

  ///(Optional) A string paramenter that represents the status of the tag in terms of accessibility.
  final String? semanticsLabel;

  const ExpenseTagContainer(
    this.tag, {
    super.key,
    this.status = ExpenseTagStatus.neutral,
    this.inverse = false,
    this.semanticsLabel,
  });

  @override
  Widget build(BuildContext context) {
    var tokens = Provider.of<ExpenseThemeManager>(context);
    var globalTokens = tokens.globals;
    var aliasTokens = tokens.alias;

    Color getBackgroundColor() {
      if (inverse) {
        return aliasTokens.color.inverse.bgColor;
      }

      switch (status) {
        case ExpenseTagStatus.neutral:
          return aliasTokens.color.elements.bgColor04;
        case ExpenseTagStatus.positive:
          return aliasTokens.color.positive.bgColor;
        case ExpenseTagStatus.promote:
          return aliasTokens.color.promote.bgColor;
        case ExpenseTagStatus.negative:
          return aliasTokens.color.negative.bgColor;
        case ExpenseTagStatus.informative:
          return aliasTokens.color.informative.bgColor;
        case ExpenseTagStatus.warning:
          return aliasTokens.color.warning.bgColor;
      }
    }

    Color getTextColor() {
      if (inverse) {
        return aliasTokens.color.inverse.onLabelColor;
      }

      switch (status) {
        case ExpenseTagStatus.neutral:
          return aliasTokens.color.text.onLabelColor;
        case ExpenseTagStatus.positive:
          return aliasTokens.color.positive.onLabelColor;
        case ExpenseTagStatus.promote:
          return aliasTokens.color.promote.onLabelColor;
        case ExpenseTagStatus.negative:
          return aliasTokens.color.negative.onLabelColor;
        case ExpenseTagStatus.informative:
          return aliasTokens.color.informative.onLabelColor;
        case ExpenseTagStatus.warning:
          return aliasTokens.color.warning.onLabelColor;
      }
    }

    return Semantics(
      container: true,
      label: getSemanticsLabel(
        semanticsLabel: semanticsLabel,
        tag: tag,
        status: status,
      ),
      excludeSemantics: semanticsLabel != null,
      child: Container(
        height: globalTokens.shapes.size.s3x,
        padding: EdgeInsets.symmetric(
          horizontal: globalTokens.shapes.spacing.s1x,
        ),
        decoration: BoxDecoration(
          color: getBackgroundColor(),
          borderRadius: BorderRadius.circular(
            globalTokens.shapes.border.radiusXs,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              tag.toUpperCase(),
              textAlign: TextAlign.center,
              style: aliasTokens.mixin.labelSm2.merge(
                TextStyle(color: getTextColor()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
