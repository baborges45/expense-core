import 'package:flutter/material.dart';

import 'package:expense_core/core.dart';

class TrailingWidget extends StatelessWidget {
  final ExpenseButtonIcon? trailingButton;

  const TrailingWidget({
    super.key,
    this.trailingButton,
  });

  @override
  Widget build(BuildContext context) {
    if (trailingButton == null) {
      return const SizedBox.shrink();
    }

    return trailingButton!;
  }
}
