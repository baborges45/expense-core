import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mude_core/core.dart';
import 'package:provider/provider.dart';

part 'widgets/_progress_circular_painter.dart';

class MudeProgressCircular extends StatelessWidget {
  ///An integer value representing the progress percentage.
  final int progress;

  ///Indicates inverse property.
  final bool inverse;

  ///A [MudeProgressCircularSize] enum representing the size of the progress bar circular.
  ///The default value is [MudeProgressCircularSize.md].
  final MudeProgressCircularSize size;

  ///A string value that indicates if you add more information from accessibility
  ///The default value is null
  final String? semanticsLabel;

  ///A string value that indicates if you add more information from accessibility
  ///The default value is null
  final String? semanticsValue;

  final bool showLabel;

  const MudeProgressCircular({
    super.key,
    required this.progress,
    this.size = MudeProgressCircularSize.lg,
    this.showLabel = true,
    this.semanticsLabel,
    this.semanticsValue,
    this.inverse = false,
  });

  @override
  Widget build(BuildContext context) {
    var tokens = Provider.of<MudeThemeManager>(context, listen: false);
    var globalTokens = tokens.globals;
    var aliasTokens = tokens.alias;
    var sizes = globalTokens.shapes.size;

    final boxSize = switch (size) {
      MudeProgressCircularSize.xs => sizes.s2x,
      MudeProgressCircularSize.sm => sizes.s3x,
      MudeProgressCircularSize.lg => sizes.s6x,
      MudeProgressCircularSize.xl => sizes.s15x,
    };

    String getLabel() {
      if (size != MudeProgressCircularSize.sm && showLabel) {
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
        MudeProgressCircularSize.xs,
        MudeProgressCircularSize.sm,
        MudeProgressCircularSize.lg,
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
                child: size == MudeProgressCircularSize.xs ? const SizedBox.shrink() : label,
              ),
            ),
          ),
          if (size == MudeProgressCircularSize.xs) ...[
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
