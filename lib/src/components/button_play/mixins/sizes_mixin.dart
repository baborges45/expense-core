import 'package:flutter/material.dart';
import 'package:expense_core/core.dart';
import 'package:provider/provider.dart';

mixin SizesMixin {
  double getSize(ExpenseButtonIconSize size, BuildContext context) {
    var globalTokens = Provider.of<ExpenseThemeManager>(context).globals;

    switch (size) {
      case ExpenseButtonIconSize.sm:
        return globalTokens.shapes.size.s4x;
      case ExpenseButtonIconSize.lg:
        return globalTokens.shapes.size.s6x;
    }
  }

  ExpenseIconSize getSizeIcon(ExpenseButtonIconSize size) {
    switch (size) {
      case ExpenseButtonIconSize.sm:
        return ExpenseIconSize.sm;
      case ExpenseButtonIconSize.lg:
        return ExpenseIconSize.lg;
    }
  }

  Widget getNotificationDot({
    required ExpenseButtonIconSize size,
    required double opacity,
    required bool show,
    double positionDotSM = 5,
    double positionDotLG = 12,
  }) {
    if (!show) {
      return const SizedBox.shrink();
    }

    double getPositionDot() {
      switch (size) {
        case ExpenseButtonIconSize.sm:
          return positionDotSM;
        case ExpenseButtonIconSize.lg:
          return positionDotLG;
      }
    }

    double positionDot = getPositionDot();

    return Positioned(
      top: positionDot,
      right: positionDot,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 200),
        opacity: opacity,
        child: const ExpenseBadge(
          key: Key('badge.notification'),
          size: ExpenseBadgeSize.sm,
        ),
      ),
    );
  }
}
