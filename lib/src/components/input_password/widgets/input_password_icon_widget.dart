import 'package:flutter/material.dart';
import 'package:mude_core/core.dart';
import 'package:provider/provider.dart';

class InputPasswordIconWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final bool hide;
  final bool disabled;
  final bool hasError;
  final Color? errorColor;
  final bool hasPaddingAll;

  const InputPasswordIconWidget({
    super.key,
    required this.onPressed,
    required this.hide,
    required this.disabled,
    required this.hasError,
    this.errorColor,
    this.hasPaddingAll = true,
  });

  @override
  Widget build(BuildContext context) {
    var tokens = Provider.of<MudeThemeManager>(context);
    var globalTokens = tokens.globals;
    var aliasTokens = tokens.alias;
    var spacing = globalTokens.shapes.spacing;

    Color getIconColor() {
      if (disabled) {
        return aliasTokens.color.disabled.iconColor;
      }

      return hasError
          ? errorColor ?? aliasTokens.color.negative.iconColor
          : aliasTokens.color.elements.iconColor;
    }

    return Semantics(
      label: hide ? 'Mostrar Senha' : 'Ocultar senha',
      enabled: !disabled,
      child: Container(
        margin: EdgeInsets.only(right: spacing.s1x),
        child: MudeButtonIcon(
          key: const Key('input-password.icon'),
          icon: hide ? MudeIcons.hideOffLine : MudeIcons.hideLine,
          onPressed: onPressed,
          iconColor: getIconColor(),
          disabled: disabled,
        ),
      ),
    );
  }
}
