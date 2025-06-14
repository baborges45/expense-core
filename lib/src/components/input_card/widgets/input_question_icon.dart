import 'package:flutter/material.dart';
import 'package:expense_core/core.dart';

class InputQuestionIcon extends StatelessWidget {
  final bool show;
  final Color? iconColor;
  final VoidCallback? onQuestion;
  final String? label;

  const InputQuestionIcon({
    super.key,
    required this.show,
    required this.label,
    this.iconColor,
    this.onQuestion,
  });

  @override
  Widget build(BuildContext context) {
    if (!show) return const SizedBox.shrink();

    return Semantics(
      button: true,
      child: ExpenseButtonIcon(
        icon: ExpenseIcons.supportLine,
        iconColor: iconColor,
        onPressed: onQuestion ?? () {},
      ),
    );
  }
}
