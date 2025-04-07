import 'package:mude_core/core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThumbSlider extends StatelessWidget {
  final bool isPressed;

  const ThumbSlider({
    super.key,
    required this.isPressed,
  });

  @override
  Widget build(BuildContext context) {
    var tokens = Provider.of<MudeThemeManager>(context);
    var globalTokens = tokens.globals;
    var aliasTokens = tokens.alias;
    final size = globalTokens.shapes.size;
    final border = globalTokens.shapes.border;

    Color pressedColor() {
      return isPressed ? aliasTokens.mixin.pressedOutline : Colors.transparent;
    }

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          top: -(size.s6x / 2) + size.s2x / 2,
          left: -(size.s6x / 2) + size.s2x / 2,
          child: Container(
            width: size.s6x,
            height: size.s6x,
            decoration: BoxDecoration(
              color: pressedColor(),
              borderRadius: BorderRadius.circular(
                border.radiusCircular,
              ),
            ),
          ),
        ),
        Positioned(
          child: Container(
            width: size.s2x,
            height: size.s2x,
            decoration: BoxDecoration(
              color: aliasTokens.color.elements.bgColor03,
              borderRadius: BorderRadius.circular(
                border.radiusCircular,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
