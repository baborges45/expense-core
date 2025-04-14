part of '../header_navigation.dart';

class _ExpenseHeaderAnimation extends StatelessWidget {
  final Widget? child;

  const _ExpenseHeaderAnimation(this.child);

  @override
  Widget build(BuildContext context) {
    return _BodyAnimation(child!);
  }
}

class _BodyAnimation extends StatefulWidget {
  final Widget child;

  const _BodyAnimation(this.child);

  @override
  State<_BodyAnimation> createState() => _BodyAnimationState();
}

class _BodyAnimationState extends State<_BodyAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    final motions = context.read<ExpenseThemeManager>().globals.motions;
    final duration = motions.durations.slow02;
    final curves = motions.curves;

    _controller = AnimationController(
      duration: duration,
      reverseDuration: duration,
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, -1.0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: curves.productiveEntrance,
        reverseCurve: curves.produtiveExit,
      ),
    );

    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: curves.productiveEntrance,
        reverseCurve: curves.produtiveExit,
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: FadeTransition(
        opacity: _opacityAnimation,
        child: widget.child,
      ),
    );
  }
}
