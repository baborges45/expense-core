import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:expense_core/core.dart';

class InputCreditCardWidget extends StatelessWidget {
  final ExpenseFlagData? flag;
  final bool isPressed;

  const InputCreditCardWidget({
    super.key,
    required this.flag,
    required this.isPressed,
  });

  @override
  Widget build(BuildContext context) {
    var tokens = Provider.of<ExpenseThemeManager>(context);
    var globalTokens = tokens.globals;

    return Padding(
      padding: EdgeInsets.only(
        right: globalTokens.shapes.spacing.s2x,
      ),
      child: ExpenseCreditCard(
        flag: flag,
        inverse: isPressed,
      ),
    );
  }
}
