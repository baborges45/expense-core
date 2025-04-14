import 'dart:math';

import 'package:flutter/material.dart';
import 'package:expense_core/core.dart';
import 'package:provider/provider.dart';

part 'widgets/_progress_circular_painter.dart';

class ExpenseProgressCircular extends StatelessWidget {
  ///An integer value representing the progress percentage.
  final int progress;

  ///Indicates inverse property.
  final bool inverse;

  ///A [ExpenseProgressCircularSize] enum representing the size of the progress bar circular.
  ///The default value is [ExpenseProgressCircularSize.md].
  final ExpenseProgressCircularSize size;

  ///A string value that indicates if you add more information from accessibility
  ///The default value is null
  final String? semanticsLabel;

  ///A string value that indicates if you add more information from accessibility
  ///The default value is null
  final String? semanticsValue;

  final bool showLabel;

  const ExpenseProgressCircular({
    super.key,
    required this.progress,
    this.size = ExpenseProgressCircularSize.lg,
    this.showLabel = true,
    this.semanticsLabel,
    this.semanticsValue,
    this.inverse = false,
  });

  @override
  Widget build(BuildContext context) {
    var tokens = Provider.of<ExpenseThemeManager>(context, listen: false);
    var globalTokens = tokens.globals;
    var aliasTokens = tokens.alias;
    var sizes = globalTokens.shapes.size;

    final boxSize = switch (size) {
      ExpenseProgressCircularSize.xs => sizes.s2x,
      ExpenseProgressCircularSize.sm => sizes.s3x,
      ExpenseProgressCircularSize.lg => sizes.s6x,
      ExpenseProgressCircularSize.xl => sizes.s15x,
    };

    String getLabel() {
      if (size != ExpenseProgressCircularSize.sm && showLabel) {
        return progress < 100 ? "${(progress).toStringAsFixed(0)}%" : '100%';
      }

      return '';
    }

    String? getSemanticValue() {
      String? expandedSemanticsValue = semanticsValue;
      expandedSemanticsValue ??= '${(progress).round()}%';

      return expandedSemanticsValue;
    }

    double getStrokeWidth() {
      final border = globalTokens.shapes.border;

      return [
        ExpenseProgressCircularSize.xs,
        ExpenseProgressCircularSize.sm,
        ExpenseProgressCircularSize.lg,
      ].contains(size)
          ? border.widthSm
          : border.widthMd;
    }

    final label = Text(
      getLabel(),
      style: aliasTokens.mixin.labelMd1.merge(
        TextStyle(
          color: aliasTokens.color.text.labelColor,
        ),
      ),
    );

    return Semantics(
      label: semanticsLabel,
      value: getSemanticValue(),
      child: Row(
        children: [
          SizedBox(
            height: boxSize,
            width: boxSize,
            child: CustomPaint(
              painter: _ProgressCirclePainter(
                strokeWidth: getStrokeWidth(),
                progress: (progress * 360) / 100,
                inverse: inverse,
                context: context,
                radialSize: boxSize,
              ),
              child: Center(
                child: size == ExpenseProgressCircularSize.xs ? const SizedBox.shrink() : label,
              ),
            ),
          ),
          if (size == ExpenseProgressCircularSize.xs) ...[
            SizedBox(
              width: globalTokens.shapes.spacing.s1x,
            ),
            label,
          ],
        ],
      ),
    );
  }
}
