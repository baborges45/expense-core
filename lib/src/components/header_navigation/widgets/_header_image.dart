part of '../header_navigation.dart';

class _MudeHeaderImage extends StatelessWidget {
  final MudeHeaderNavigationType type;
  final String? semanticsSubtitleLabel;
  final String source;
  final Widget? tag;
  final String? headingText;
  final Widget? child;

  const _MudeHeaderImage({
    required this.type,
    required this.source,
    required this.tag,
    required this.headingText,
    required this.child,
    this.semanticsSubtitleLabel,
  });

  @override
  Widget build(BuildContext context) {
    final Widget headingWidget = headingText != null
        ? MudeHeading(
            headingText!,
            semanticsLabel: semanticsSubtitleLabel,
            size: MudeHeadingSize.xl,
          )
        : const SizedBox.shrink();

    final Widget tagWidget = tag ?? const SizedBox.shrink();
    final Widget childWidget = child ?? const SizedBox.shrink();

    return type == MudeHeaderNavigationType.image
        ? _buildBody(tagWidget, headingWidget, childWidget)
        : const SizedBox.shrink();
  }

  Widget _buildBody(
    Widget tagWidget,
    Widget headingWidget,
    Widget childWidget,
  ) {
    return Stack(
      children: [
        _Body(
          tagWidget,
          headingWidget,
          childWidget,
        ),
      ],
    );
  }
}

class _Body extends StatefulWidget {
  final Widget getTag;
  final Widget getHeading;
  final Widget child;

  const _Body(this.getTag, this.getHeading, this.child);

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  late Animation<double> _opacityAnimation;

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
    var tokens = Provider.of<MudeThemeManager>(context);
    var globalTokens = tokens.globals;
    final spacing = globalTokens.shapes.spacing;
    final s3x = spacing.s3x;
    final s4x = spacing.s4x;

    return Semantics(
      container: true,
      child: SlideTransition(
        position: _offsetAnimation,
        child: FadeTransition(
          opacity: _opacityAnimation,
          child: Padding(
            padding: EdgeInsets.only(left: s3x, bottom: s4x),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                widget.getTag,
                SizedBox(height: s3x),
                Align(
                  alignment: Alignment.centerLeft,
                  child: widget.getHeading,
                ),
                SizedBox(height: s3x),
                widget.child,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
