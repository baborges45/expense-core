import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:expense_core/core.dart';

class ExpenseBadge extends StatelessWidget {
  ///A value of type [ExpenseBadgeSize] representing the size of the badge (small or large).
  ///The default value is [ExpenseBadgeSize.sm].
  final ExpenseBadgeSize size;

  ///A string value that provides a descriptive label for accessibility purposes.
  ///The default value is null
  final String? semanticsLabel;

  ///A string value that indicates additional accessibility information.
  ///The default value is null
  final String? semanticsHint;

  const ExpenseBadge({
    super.key,
    this.size = ExpenseBadgeSize.sm,
    this.semanticsLabel,
    this.semanticsHint,
  });

  @override
  Widget build(BuildContext context) {
    var tokens = Provider.of<ExpenseThemeManager>(context);
    var globalTokens = tokens.globals;
    var aliasTokens = tokens.alias;

    double getSize() {
      switch (size) {
        case ExpenseBadgeSize.sm:
          return globalTokens.shapes.size.s1x;
        case ExpenseBadgeSize.lg:
          return globalTokens.shapes.size.s2x;
      }
    }

    double containerSize = getSize();

    return Semantics(
      container: true,
      label: semanticsLabel,
      hint: semanticsHint,
      excludeSemantics: semanticsHint != null,
      child: Container(
        width: containerSize,
        height: containerSize,
        decoration: BoxDecoration(
          color: aliasTokens.color.elements.notificationColor,
          borderRadius: BorderRadius.circular(
            globalTokens.shapes.border.radiusCircular,
          ),
        ),
      ),
    );
  }
}
