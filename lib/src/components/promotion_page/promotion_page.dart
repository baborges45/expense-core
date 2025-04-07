import 'package:flutter/material.dart';
import 'package:mude_core/core.dart';
import 'package:mude_core/src/utils/check_url_is_valid.dart';
import 'package:provider/provider.dart';

part 'widgets/_button_close.dart';

class MudePromotionPage {
  // coverage:ignore-start
  const MudePromotionPage._();

  /// Showing a MudePromotionPage
  ///
  /// [child] => Set a new [Widget] to displayed.
  /// [sourceBanner] => A string value that refers to the local or web path to load an image.
  /// [fit] => Set a fit displayed image. You get all options in [BoxFit]
  /// [aspectRatio] => Set a aspect ratio in image. You get all options in [MudeImageAspectRatio]
  /// [type] => An object of type [PromotionPageType] that defines the display type of the PromotionPage.
  static Future<void> show(
    BuildContext context, {
    required Widget child,
    required String sourceBanner,
    PromotionPageType type = PromotionPageType.slotContainer,
    BoxFit fit = BoxFit.cover,
  }) async {
    var tokens = context.read<MudeThemeManager>();
    var aliasTokens = tokens.alias;

    Widget getImage() {
      var sourceLoad =
          urlIsvalid(sourceBanner) ? MudeImage.network : MudeImage.asset;

      return sourceLoad(
        sourceBanner,
        fit: fit,
        fillContainer: true,
        borderRadius: BorderRadius.zero,
      );
    }

    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: aliasTokens.mixin.overlayDefault,
      isScrollControlled: true,
      useRootNavigator: true,
      enableDrag: false,
      builder: (BuildContext context) {
        return _Body(
          image: getImage(),
          type: type,
          child: child,
        );
      },
    );
  }
}

class _Body extends StatefulWidget {
  final Widget child;
  final Widget image;
  final PromotionPageType type;

  const _Body({
    required this.child,
    required this.image,
    required this.type,
  });

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 700),
      reverseDuration: const Duration(milliseconds: 700),
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutQuart,
        reverseCurve: Curves.easeInExpo,
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
    final size = MediaQuery.of(context).size;
    final s3x = globalTokens.shapes.spacing.s3x;

    return Semantics(
      container: true,
      child: SlideTransition(
        position: _offsetAnimation,
        child: Container(
          width: size.width,
          height: size.height,
          color: aliasTokens.color.elements.bgColor01,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Flexible(
                    fit: FlexFit.tight,
                    child: widget.image,
                  ),
                  if (widget.type == PromotionPageType.slotContainer)
                    Padding(
                      padding: EdgeInsets.all(s3x),
                      child: widget.child,
                    ),
                ],
              ),
              if (widget.type == PromotionPageType.imageFull)
                Container(
                  margin: EdgeInsets.all(s3x),
                  child: widget.child,
                ),
              const _ButtonClose(),
            ],
          ),
        ),
      ),
    );
  }
}
