import 'package:expense_core/core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../validations/validation_leading.dart';

class LeadingNavWidget extends StatelessWidget {
  final dynamic child;
  final bool inverse;

  const LeadingNavWidget({
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
    var globalShapes = globalTokens.shapes;

    var rightPadding = child is ExpenseIconData || child is ExpenseAvatarGroup ? globalShapes.spacing.s1x : globalShapes.spacing.s2x;

    return Container(
      padding: EdgeInsets.only(right: rightPadding),
      child: ValidationLeadingType.widgetAccept(child, inverse),
    );
  }
}
