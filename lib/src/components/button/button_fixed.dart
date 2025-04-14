import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:expense_core/core.dart';

class ExpenseButtonFixed extends StatelessWidget {
  ///A [ExpenseButton] object that represents the button to be displayed.
  final ExpenseButton button;

  const ExpenseButtonFixed({
    super.key,
    required this.button,
  });

  @override
  Widget build(BuildContext context) {
    var globalTokens = Provider.of<ExpenseThemeManager>(context).globals;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ExpenseDivider.thin(),
        Padding(
          padding: EdgeInsets.only(top: globalTokens.shapes.spacing.s3x),
          child: button,
        ),
      ],
    );
  }
}
