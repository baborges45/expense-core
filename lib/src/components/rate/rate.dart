// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:expense_core/core.dart';
import 'package:expense_core/src/utils/extensions.dart';
import 'package:provider/provider.dart';

class ExpenseRate extends StatelessWidget {
  ///A string value that will be displayed under the rate icon.
  final String value;

  ///A string value that provides a descriptive label for accessibility purposes.
  ///The default value is null
  final String? semanticsLabel;

  ///A string value that indicates additional accessibility information.
  ///The default value is null
  final String? semanticsHint;

  const ExpenseRate(
    this.value, {
    super.key,
    this.semanticsLabel,
    this.semanticsHint,
  });

  @override
  Widget build(BuildContext context) {
    var tokens = Provider.of<ExpenseThemeManager>(context);
    var globalTokens = tokens.globals;
    var aliasTokens = tokens.alias;

    var startSemanticsLabel = value.onlyNumbers() > 1 ? 'estrelas' : 'estrela';

    return Semantics(
      label: semanticsLabel ?? '$value $startSemanticsLabel',
      hint: semanticsHint,
      excludeSemantics: true,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ExpenseIcon(
            icon: ExpenseIcons.rateFill,
            size: ExpenseIconSize.sm,
            color: aliasTokens.color.elements.iconColor,
          ),
          SizedBox(width: globalTokens.shapes.spacing.half),
          ExpenseDescription(
            value,
            color: aliasTokens.color.text.descriptionColor,
          ),
        ],
      ),
    );
  }
}
