part of '../progress_circular.dart';

class _ProgressCirclePainter extends CustomPainter {
  final double progress;
  final BuildContext context;
  final double radialSize;
  final bool inverse;
  final double strokeWidth;

  _ProgressCirclePainter({
    required this.radialSize,
    required this.inverse,
    required this.context,
    required this.progress,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    var tokens = Provider.of<ExpenseThemeManager>(context, listen: false);
    var globalTokens = tokens.globals;
    var aliasTokens = tokens.alias;
    var elements = aliasTokens.color.elements;

    const startAngle = -90 * pi / 180;
    final sweepAngle = ((-progress) * pi) / 180;

    final c = Offset(size.width / 2, size.height / 2);

    final rect = Rect.fromCenter(
      center: c,
      width: radialSize,
      height: radialSize,
    );

    // // Define o Paint para a borda branca
    final progressColor = Paint()
      ..color = inverse ? aliasTokens.color.inverse.bgColor : elements.bgColor06
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final remainColor = Paint()
      ..color = elements.bgColor05.withOpacity(
        globalTokens.shapes.opacity.superLow,
      )
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    canvas.drawArc(rect, startAngle, 360, false, remainColor);

    canvas.drawArc(rect, startAngle, -sweepAngle, false, progressColor);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
