part of '../progress_line.dart';

class _PercentualProgress extends StatelessWidget {
  final double position;
  final int progress;
  final bool show;

  const _PercentualProgress({
    required this.position,
    required this.progress,
    required this.show,
  });

  @override
  Widget build(BuildContext context) {
    if (!show) return const SizedBox.shrink();

    var tokens = Provider.of<ExpenseThemeManager>(context);
    var globalTokens = tokens.globals;
    var aliasTokens = tokens.alias;

    String getProgressText() {
      if (progress >= 100) {
        return '100';
      } else if (progress <= 0) {
        return '0';
      }

      return progress.toString();
    }

    double getMinPosition() {
      double minWidthContainer = 25;

      return position < minWidthContainer ? minWidthContainer : position;
    }

    return AnimatedContainer(
      duration: globalTokens.motions.durations.moderate02,
      curve: globalTokens.motions.curves.expressiveEntrance,
      width: getMinPosition(),
      padding: EdgeInsets.only(top: globalTokens.shapes.spacing.s1x),
      color: Colors.transparent,
      child: Text(
        '${getProgressText()}%',
        textAlign: TextAlign.end,
        style: aliasTokens.mixin.labelSm1.merge(
          TextStyle(
            color: aliasTokens.color.text.labelColor,
          ),
        ),
      ),
    );
  }
}
