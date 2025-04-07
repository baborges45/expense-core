import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:mude_core/core.dart';

class ContainerPressed extends StatelessWidget {
  final bool isPressed;

  const ContainerPressed({
    super.key,
    required this.isPressed,
  });

  @override
  Widget build(BuildContext context) {
    var tokens = Provider.of<MudeThemeManager>(context);
    var globalTokens = tokens.globals;
    var aliasTokens = tokens.alias;
    final size = globalTokens.shapes.size;

    if (!isPressed) {
      return const SizedBox.shrink();
    }

    return Container(
      key: const Key('button-icon.container-pressed'),
      width: size.s6x,
      height: size.s6x,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: aliasTokens.mixin.pressedOutline,
        borderRadius: BorderRadius.circular(
          globalTokens.shapes.border.radiusCircular,
        ),
      ),
    );
  }
}
