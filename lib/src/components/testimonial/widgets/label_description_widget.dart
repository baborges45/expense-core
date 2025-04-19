import 'package:flutter/material.dart';
import 'package:expense_core/core.dart';
import 'package:provider/provider.dart';

class LabelDescriptionWidget extends StatelessWidget {
  final String description;

  const LabelDescriptionWidget(this.description, {super.key});

  @override
  Widget build(BuildContext context) {
    var globalTokens = Provider.of<ExpenseThemeManager>(context).globals;
    var aliasTokens = globalTokens.shapes.spacing;

    return Padding(
      padding: EdgeInsets.only(
        right: aliasTokens.s1_5x,
      ),
      child: ExpenseDescription(description),
    );
  }
}
