part of '../progress_line.dart';

class _LineProgress extends StatelessWidget {
  final double value;

  const _LineProgress({
    super.key,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    var tokens = Provider.of<ExpenseThemeManager>(context);
    var globalTokens = tokens.globals;
    var aliasTokens = tokens.alias;
    var size = globalTokens.shapes.size;
    var elements = aliasTokens.color.elements;

    return Stack(
      children: [
        Container(
          height: size.half,
          color: elements.bgColor02,
        ),
        AnimatedContainer(
          duration: globalTokens.motions.durations.moderate02,
          curve: Curves.linear,
          width: value < 0 ? 0 : value,
          height: size.half,
          color: elements.bgColor06,
        ),
      ],
    );
  }
}
