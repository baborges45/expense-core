import 'dart:async';

import 'package:flutter/material.dart';
import 'package:expense_core/core.dart';
import 'package:provider/provider.dart';

part 'widgets/_line_progress.dart';
part 'widgets/_percentual_progress.dart';

class ExpenseProgressLine extends StatefulWidget {
  ///An integer value representing the progress percentage.
  final int progress;

  ///A boolean value indicating whether to show the percentage text or not.
  ///The default value is false.
  final bool showPercentual;

  ///A string value that provides a descriptive label for accessibility purposes.
  ///The default value is null
  final String? semanticsLabel;

  const ExpenseProgressLine({
    super.key,
    required this.progress,
    this.showPercentual = false,
    this.semanticsLabel,
  });

  @override
  State<ExpenseProgressLine> createState() => ExpenseProgressLineState();
}

class ExpenseProgressLineState extends State<ExpenseProgressLine> {
  double sizeWidth = 0;
  int progressLoad = 0;

  late Timer _timer;

  late GlobalKey sizekey;

  @override
  void initState() {
    super.initState();
    sizekey = GlobalKey();

    _timer = Timer(const Duration(milliseconds: 1), () {
      double width = sizekey.currentContext?.size?.width ?? 1;
      setState(() => sizeWidth = width);
    });

    progressLoad = widget.progress;
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double getPositionText() {
      if (widget.progress <= 0) return 20;

      return ((widget.progress * sizeWidth) / 100) + 16;
    }

    double getPercentual() {
      if (sizeWidth == 0 && widget.progress == 0) return 0;

      return double.parse((sizeWidth * widget.progress / 100).toString());
    }

    return Semantics(
      label: widget.semanticsLabel ?? '${widget.progress}%',
      liveRegion: true,
      excludeSemantics: true,
      child: Stack(
        children: [
          _PercentualProgress(
            position: getPositionText(),
            progress: widget.progress,
            show: widget.showPercentual,
          ),
          _LineProgress(
            key: sizekey,
            value: getPercentual(),
          ),
        ],
      ),
    );
  }
}
