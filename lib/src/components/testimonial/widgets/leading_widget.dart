import 'package:expense_core/core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LeadingWidget extends StatelessWidget {
  final dynamic child;
  final bool inverse;

  const LeadingWidget({
    super.key,
    required this.child,
    this.inverse = false,
  });

  @override
  Widget build(BuildContext context) {
    if (child == null) {
      return const SizedBox.shrink();
    }

    var globalTokens = Provider.of<ExpenseThemeManager>(context).globals;

    return Container(
      padding: EdgeInsets.only(
        right: globalTokens.shapes.spacing.s1_5x,
      ),
      child: child,
    );
  }
}
