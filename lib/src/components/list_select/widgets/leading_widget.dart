import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:expense_core/core.dart';

import '../validations/validation_leading.dart';

class LeadingWidget extends StatelessWidget {
  final dynamic child;
  final bool inverse;

  const LeadingWidget({
    super.key,
    this.child,
    this.inverse = false,
  });

  @override
  Widget build(BuildContext context) {
    if (child == null) return const SizedBox.shrink();

    var globalTokens = Provider.of<ExpenseThemeManager>(context).globals;

    return Row(
      children: [
        ValidationLeadingType.widgetAccept(child, inverse),
        SizedBox(width: globalTokens.shapes.spacing.s2x),
      ],
    );
  }
}
