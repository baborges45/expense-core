import 'package:expense_core/core.dart';
import 'package:flutter/material.dart';

class TagWidget extends StatelessWidget {
  final ExpenseTagContainer? tag;

  const TagWidget({
    super.key,
    required this.tag,
  });

  @override
  Widget build(BuildContext context) {
    if (tag == null) return const SizedBox.shrink();

    return tag!;
  }
}
