part of '../super_drawer.dart';

class _BodyCustom extends StatefulWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;

  const _BodyCustom({
    required this.child,
    this.padding,
    this.backgroundColor,
  });

  @override
  State<_BodyCustom> createState() => _BodyCustomState();
}

class _BodyCustomState extends State<_BodyCustom> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

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
      begin: const Offset(0.0, 1.0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: curves.expressiveEntrance,
        reverseCurve: curves.expressiveExit,
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
    var tokens = Provider.of<ExpenseThemeManager>(context);
    var globalTokens = tokens.globals;
    var aliasTokens = tokens.alias;

    double getSpacingTop() {
      return MediaQuery.of(context).size.height * 0.9;
    }

    EdgeInsetsGeometry getPadding() {
      return widget.padding != null ? widget.padding! : EdgeInsets.all(globalTokens.shapes.spacing.s3x);
    }

    return SlideTransition(
      position: _offsetAnimation,
      child: Container(
        padding: getPadding(),
        height: getSpacingTop(),
        decoration: BoxDecoration(
          color: widget.backgroundColor ?? aliasTokens.color.elements.bgColor01,
        ),
        child: widget.child,
      ),
    );
  }
}
