import 'package:flutter/material.dart';
import 'package:mude_core/core.dart';
import 'package:provider/provider.dart';

mixin SizesMixin {
  double getSize(MudeButtonIconSize size, BuildContext context) {
    var globalTokens = Provider.of<MudeThemeManager>(context).globals;

    switch (size) {
      case MudeButtonIconSize.sm:
        return globalTokens.shapes.size.s4x;
      case MudeButtonIconSize.lg:
        return globalTokens.shapes.size.s6x;
    }
  }

  MudeIconSize getSizeIcon(MudeButtonIconSize size) {
    switch (size) {
      case MudeButtonIconSize.sm:
        return MudeIconSize.sm;
      case MudeButtonIconSize.lg:
        return MudeIconSize.lg;
    }
  }

  Widget getNotificationDot({
    required MudeButtonIconSize size,
    required double opacity,
    required bool show,
    double positionDotSM = 5,
    double positionDotLG = 12,
  }) {
    if (!show) {
      return const SizedBox.shrink();
    }

    double getPositionDot() {
      switch (size) {
        case MudeButtonIconSize.sm:
          return positionDotSM;
        case MudeButtonIconSize.lg:
          return positionDotLG;
      }
    }

    double positionDot = getPositionDot();

    return Positioned(
      top: positionDot,
      right: positionDot,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 200),
        opacity: opacity,
        child: const MudeBadge(
          key: Key('badge.notification'),
          size: MudeBadgeSize.sm,
        ),
      ),
    );
  }
}
