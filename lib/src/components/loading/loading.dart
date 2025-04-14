import 'dart:async';

import 'package:flutter/material.dart';
import 'package:expense_core/core.dart';
import 'package:provider/provider.dart';

class ExpenseLoading extends StatefulWidget {
  final bool inverse;
  final ExpenseLoadingSize size;
  const ExpenseLoading({
    super.key,
    this.inverse = false,
    this.size = ExpenseLoadingSize.sm,
  });

  @override
  State<ExpenseLoading> createState() => _ExpenseLoadingState();
}

class _ExpenseLoadingState extends State<ExpenseLoading> {
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
    final motions = context.read<ExpenseThemeManager>().globals.motions;
    const totalTransitions = 4;

    setState(() => index = 0);

    _timer = Timer.periodic(
      Duration(
        milliseconds: motions.durations.slow02.inMilliseconds ~/ totalTransitions,
      ),
      (_) {
        setState(() => index == 7 ? index = 0 : index += 1);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var globalTokens = Provider.of<ExpenseThemeManager>(context).globals;
    var aliasTokens = Provider.of<ExpenseThemeManager>(context).alias;
    var size = globalTokens.shapes.size;
    var opacity = globalTokens.shapes.opacity;

    double sizeBody = widget.size == ExpenseLoadingSize.sm ? size.s2x : size.s3x;

    Color getColor() => widget.inverse ? aliasTokens.color.inverse.bgColor : aliasTokens.color.elements.bgColor01;

    Color getBackgroundColor() => aliasTokens.color.elements.bgColor03.withOpacity(widget.inverse ? opacity.superHigh : opacity.superLow);

    return Semantics(
      key: const Key('button-loading'),
      child: SizedBox(
        width: sizeBody,
        height: sizeBody,
        child: CircularProgressIndicator(
          strokeWidth: globalTokens.shapes.border.widthSm,
          backgroundColor: getBackgroundColor(),
          color: getColor(),
        ),
      ),
    );
  }
}
