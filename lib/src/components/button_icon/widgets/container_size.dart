import 'package:expense_core/core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContainerSize extends StatelessWidget {
  final Widget child;

  const ContainerSize({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final tokens = Provider.of<ExpenseThemeManager>(context);
    final globalTokens = tokens.globals;

    final size = globalTokens.shapes.size.s6x;

    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(
          globalTokens.shapes.border.radiusCircular,
        ),
      ),
      alignment: Alignment.center,
      child: child,
    );
  }
}
