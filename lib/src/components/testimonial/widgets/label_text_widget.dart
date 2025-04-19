import 'package:expense_core/core.dart';
import 'package:flutter/material.dart';

class LabelText extends StatelessWidget {
  final String label;

  const LabelText(this.label, {super.key});

  @override
  Widget build(BuildContext context) {
    return ExpenseHeading(
      label,
      size: ExpenseHeadingSize.xs,
    );
  }
}
