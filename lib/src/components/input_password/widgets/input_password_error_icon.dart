import 'package:flutter/material.dart';
import 'package:mude_core/core.dart';
import 'package:provider/provider.dart';

class InputPasswordErrorIcon extends StatelessWidget {
  final bool show;
  final Color? iconColor;

  const InputPasswordErrorIcon({
    super.key,
    required this.show,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    if (!show) return const SizedBox.shrink();

    var tokens = Provider.of<MudeThemeManager>(context);
    var globalTokens = tokens.globals;
    var aliasTokens = tokens.alias;

    return ExcludeSemantics(
      child: Padding(
        padding: EdgeInsets.only(left: globalTokens.shapes.spacing.s2x),
        child: MudeIcon(
          icon: MudeIcons.negativeLine,
          size: MudeIconSize.lg,
          color: iconColor ?? aliasTokens.color.negative.iconColor,
        ),
      ),
    );
  }
}
