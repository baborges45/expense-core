// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:expense_core/core.dart';

class ExpenseDivider extends StatelessWidget {
  ///An enumeration representing the size of the divider.
  ///It has two values: [ExpenseDividerSize.thin] and [ExpenseDividerSize.thick].
  late ExpenseDividerSize size;

  ExpenseDivider.thin({super.key}) {
    size = ExpenseDividerSize.thin;
  }

  @override
  Widget build(BuildContext context) {
    var tokens = Provider.of<ExpenseThemeManager>(context);
    var aliasTokens = tokens.alias;
    double getSizes = 1.0;

    return Container(
      height: getSizes,
      color: aliasTokens.color.elements.borderColor,
    );
  }
}
