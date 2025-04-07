import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:mude_core/core.dart';

class ContainerPressed extends StatelessWidget {
  final bool isPressed;
  final bool inverse;

  const ContainerPressed({
    super.key,
    required this.isPressed,
    this.inverse = false,
  });

  @override
  Widget build(BuildContext context) {
    var tokens = Provider.of<MudeThemeManager>(context);
    var globalTokens = tokens.globals;
    var aliasTokens = tokens.alias;
    var durations = globalTokens.motions.durations;

    if (!isPressed) {
      return const SizedBox.shrink();
    }

    Color getColorBoxShadow() {
      return inverse
          ? aliasTokens.mixin.pressedOutlineInverse
          : aliasTokens.mixin.pressedOutline;
    }

    return AnimatedPositioned(
      duration: durations.moderate02,
      right: 1,
      left: 1,
      top: 1,
      bottom: 1,
      child: AnimatedContainer(
        duration: durations.moderate02,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            globalTokens.shapes.border.radiusSm,
          ),
          boxShadow: [
            BoxShadow(
              spreadRadius: 10,
              color: getColorBoxShadow(),
            ),
          ],
        ),
      ),
    );
  }
}
