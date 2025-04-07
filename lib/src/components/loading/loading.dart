import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mude_core/core.dart';
import 'package:provider/provider.dart';

class MudeLoading extends StatefulWidget {
  final bool inverse;
  final MudeLoadingSize size;
  const MudeLoading({
    super.key,
    this.inverse = false,
    this.size = MudeLoadingSize.sm,
  });

  @override
  State<MudeLoading> createState() => _MudeLoadingState();
}

class _MudeLoadingState extends State<MudeLoading> {
  late Timer _timer;
  int index = 0;

  @override
  void initState() {
    super.initState();

    initAnimation();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void initAnimation() {
    final motions = context.read<MudeThemeManager>().globals.motions;
    const totalTransitions = 4;

    setState(() => index = 0);

    _timer = Timer.periodic(
      Duration(
        milliseconds:
            motions.durations.slow02.inMilliseconds ~/ totalTransitions,
      ),
      (_) {
        setState(() => index == 7 ? index = 0 : index += 1);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var globalTokens = Provider.of<MudeThemeManager>(context).globals;
    var aliasTokens = Provider.of<MudeThemeManager>(context).alias;
    var size = globalTokens.shapes.size;
    var opacity = globalTokens.shapes.opacity;

    double sizeBody = widget.size == MudeLoadingSize.sm ? size.s2x : size.s3x;

    Color getColor() => widget.inverse
        ? aliasTokens.color.inverse.bgColor
        : aliasTokens.color.elements.bgColor01;

    Color getBackgroundColor() => aliasTokens.color.elements.bgColor03
        .withOpacity(widget.inverse ? opacity.superHigh : opacity.superLow);

    return Semantics(
      key: const Key('button-loading'),
      child: SizedBox(
        width: sizeBody,
        height: sizeBody,
        child: CircularProgressIndicator(
          strokeWidth: globalTokens.shapes.border.widthSm,
          backgroundColor: getBackgroundColor(),
          color: getColor(),
        ),
      ),
    );
  }
}
