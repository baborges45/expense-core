import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:expense_core/core.dart';

class LabelWidget extends StatelessWidget {
  final String label;
  final String? semanticsLabel;

  const LabelWidget({
    super.key,
    required this.label,
    this.semanticsLabel,
  });

  @override
  Widget build(BuildContext context) {
    var aliasTokens = Provider.of<ExpenseThemeManager>(context).alias;

    Color getLabelColor() {
      return aliasTokens.color.text.labelColor;
    }

    return Text(
      label,
      style: aliasTokens.mixin.labelMd2.merge(
        TextStyle(
          color: getLabelColor(),
        ),
      ),
    );
  }
}
