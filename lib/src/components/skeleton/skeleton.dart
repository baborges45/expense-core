import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mude_core/core.dart';
import 'package:provider/provider.dart';

part './widgets/_shimmer.dart';

class MudeSkeleton extends StatefulWidget {
  ///(Optional) A double representing the height of the skeleton widget.
  final double? height;

  ///(Optional) A double representing the width of the skeleton widget.
  final double? width;

  ///(Optional) A BorderRadius object representing the border radius of the skeleton widget.
  final BorderRadius? borderRadius;

  ///A [MudeSkeletonType] enum object representing the shape of the skeleton widget.
  ///The default value is [MudeSkeletonType.retangle].
  final MudeSkeletonType type;

  ///A [Duration] object representing the duration of the shimmering animation.
  ///The default value is 1500 milliseconds.
  final Duration duration;

  ///(Optional) A [MudeSkeletonDirection] representing animation direction.
  ///The default value is [MudeSkeletonDirection.ltr]
  final MudeSkeletonDirection direction;

  ///A string value that provides a descriptive label for accessibility purposes.
  ///The default value is null
  final String? semanticsLabel;

  ///A string value that indicates additional accessibility information.
  ///The default value is null
  final String? semanticsHint;

  const MudeSkeleton({
    super.key,
    this.height,
    this.width,
    this.borderRadius,
    this.type = MudeSkeletonType.retangle,
    this.direction = MudeSkeletonDirection.ltr,
    this.duration = const Duration(milliseconds: 1500),
    this.semanticsLabel,
    this.semanticsHint,
  });

  @override
  State<MudeSkeleton> createState() => _MudeSkeletonState();
}

class _MudeSkeletonState extends State<MudeSkeleton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..addStatusListener((AnimationStatus status) {
        try {
          _controller.repeat();
        } catch (e) {
          debugPrint('');
        }
      });

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    var tokens = Provider.of<MudeThemeManager>(context);
    var globalTokens = tokens.globals;
    var aliasTokens = tokens.alias;
    var elements = aliasTokens.color.elements;

    List<Color> getGradientColors() {
      Color baseColor = elements.bgColor02;
      Color highlightColor = elements.bgColor03;

      return [
        baseColor,
        baseColor,
        highlightColor,
        baseColor,
        baseColor,
      ];
    }

    double getHeight() {
      if (widget.type == MudeSkeletonType.circle) {
        return widget.height ?? widget.width ?? globalTokens.shapes.size.s8x;
      }

      return widget.height ?? globalTokens.shapes.size.s20x;
    }

    double getWidth() {
      if (widget.type == MudeSkeletonType.circle) {
        return widget.width ?? widget.height ?? globalTokens.shapes.size.s8x;
      }

      return widget.width ?? double.maxFinite;
    }

    BorderRadius getBorderRadius() {
      if (widget.type == MudeSkeletonType.circle) {
        return BorderRadius.circular(globalTokens.shapes.border.radiusCircular);
      }

      return widget.borderRadius ??
          BorderRadius.circular(globalTokens.shapes.border.radiusXs);
    }

    return Semantics(
      container: true,
      label: widget.semanticsLabel,
      hint: widget.semanticsHint,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (BuildContext context, Widget? child) => _Shimmer(
          direction: widget.direction,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.centerRight,
            colors: getGradientColors(),
            stops: const [0.0, 0.35, 0.5, 0.65, 1.0],
          ),
          percent: _controller.value,
          child: Container(
            height: getHeight(),
            width: getWidth(),
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: getBorderRadius(),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
