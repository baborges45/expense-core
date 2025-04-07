part of '../drawer.dart';

class _BodyCustom extends StatefulWidget {
  final Widget child;

  const _BodyCustom({required this.child});

  @override
  State<_BodyCustom> createState() => _BodyCustomState();
}

class _BodyCustomState extends State<_BodyCustom>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();

    final motions = context.read<MudeThemeManager>().globals.motions;
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
    var tokens = Provider.of<MudeThemeManager>(context);
    var globalTokens = tokens.globals;
    var aliasTokens = tokens.alias;
    var spacing = globalTokens.shapes.spacing;

    return SlideTransition(
      position: _offsetAnimation,
      child: Container(
        padding: EdgeInsets.only(
          left: spacing.s3x,
          right: spacing.s3x,
          bottom: spacing.s3x,
          top: spacing.s1x,
        ),
        decoration: BoxDecoration(
          color: aliasTokens.color.elements.bgColor02,
        ),
        child: widget.child,
      ),
    );
  }
}
