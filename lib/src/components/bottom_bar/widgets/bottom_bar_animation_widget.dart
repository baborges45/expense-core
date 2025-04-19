import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:expense_core/core.dart';

class BottomBarAnimationWidget extends StatelessWidget {
  /// Set how much left side spacing is applied
  final double spacing;

  /// Set size width in container is apply
  final double size;

  /// Set a child that will be displayed
  final Widget child;

  const BottomBarAnimationWidget({
    super.key,
    required this.spacing,
    required this.size,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    var globalTokens = Provider.of<ExpenseThemeManager>(context).globals;

    return AnimatedPositioned(
      duration: globalTokens.motions.durations.fast02,
      curve: globalTokens.motions.curves.expressiveEntrance,
      left: spacing,
      child: SizedBox(
        width: size,
        height: globalTokens.shapes.size.s10x,
        child: child,
      ),
    );
  }
}
