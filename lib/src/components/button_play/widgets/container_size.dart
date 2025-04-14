import 'package:flutter/material.dart';
import 'package:expense_core/core.dart';
import 'package:provider/provider.dart';

class ContainerSize extends StatelessWidget {
  final Widget child;
  final bool isPressed;
  final bool inverse;

  const ContainerSize({
    super.key,
    required this.child,
    required this.isPressed,
    required this.inverse,
  });

  @override
  Widget build(BuildContext context) {
    final tokens = Provider.of<ExpenseThemeManager>(context);
    final globalTokens = tokens.globals;
    final aliasTokens = tokens.alias;

    final size = globalTokens.shapes.size.s6x;
    final border = globalTokens.shapes.border;

    Color getBorderColor() {
      return inverse ? aliasTokens.color.inverse.borderColor : aliasTokens.color.action.borderPrimaryColor;
    }

    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(
          border.radiusCircular,
        ),
        border: Border.all(
          color: getBorderColor(),
          width: border.widthXs,
        ),
      ),
      alignment: Alignment.center,
      child: child,
    );
  }
}
