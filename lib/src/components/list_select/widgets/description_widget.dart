import 'package:expense_core/core.dart';
import 'package:flutter/material.dart';

class DescriptionWidget extends StatelessWidget {
  final String? description;
  final String? semanticsDescription;

  const DescriptionWidget({
    super.key,
    required this.description,
    this.semanticsDescription,
  });

  @override
  Widget build(BuildContext context) {
    if (description == null) return const SizedBox.shrink();

    return ExpenseDescription(
      description!,
      semanticsLabel: semanticsDescription ?? description!,
    );
  }
}
