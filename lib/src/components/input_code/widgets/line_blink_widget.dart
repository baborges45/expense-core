import 'dart:async';

import 'package:expense_core/core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LineBlinkWidget extends StatefulWidget {
  const LineBlinkWidget({
    super.key,
  });

  @override
  State<LineBlinkWidget> createState() => _LoadingButtonState();
}

class _LoadingButtonState extends State<LineBlinkWidget> {
  late Timer _timer;
  int index = 0;

  @override
  void initState() {
    super.initState();
    initAnimation();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void initAnimation() {
    _timer = Timer.periodic(const Duration(milliseconds: 500), (_) {
      setState(() => index = index == 0 ? 1 : 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    var tokens = Provider.of<ExpenseThemeManager>(context);

    var aliasTokens = tokens.alias;
    var globalTokens = tokens.globals;
    Color getColor() {
      return index == 0 ? Colors.transparent : aliasTokens.color.active.placeholderColor;
    }

    Widget containerCircleAnimate(Color color) {
      return AnimatedContainer(
        curve: Curves.linear,
        duration: globalTokens.motions.durations.moderate02,
        height: 24,
        width: 2,
        decoration: BoxDecoration(
          color: color,
        ),
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        containerCircleAnimate(getColor()),
      ],
    );
  }
}
