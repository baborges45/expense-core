import 'package:flutter/material.dart';
import 'package:mude_core/core.dart';
import 'package:provider/provider.dart';

import 'widgets/container_widget.dart';

class MudeButton extends StatelessWidget {
  ///A string representing the label or text of the button.
  final String label;

  ///A required callback that will be called when the button is pressed.
  final VoidCallback onPressed;

  ///(Optional) A MudeButtonType enum value representing the type of the button.
  final MudeButtonType? type;

  ///(Optional) A MudeButtonSyze enum value representing the size of the button.
  final MudeButtonSize? size;

  ///(Optional) A MudeIconData object representing the icon to be displayed on the button.
  final MudeIconData? icon;

  ///(Optional) A boolean indicating whether the button should be disabled.
  ///The default value is false.
  final bool disabled;

  ///(Optional) A boolean indicating whether the button should display a loading indicator.
  ///The default value is false.
  final bool loading;

  ///(Optional) A boolean parameter that specifies whether the link should have an inverse color scheme.
  ///The default value is false.
  final bool inverse;

  ///A string value that indicates if you add more information from accessibility
  ///The default value is null
  final String? semanticsLabel;

  ///A string value that indicates if you add more information from accessibility
  ///The default value is null
  final String? semanticsHint;

  ///A boolean value can be utilized to determine whether child semantics will be taken into consideration or not.
  ///The default value is false.
  final bool excludeSemantics;

  ///(Optional) A boolean indicating whether the button should have a negative color scheme.
  final bool negative;

  const MudeButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.type = MudeButtonType.minwidth,
    this.size = MudeButtonSize.lg,
    this.disabled = false,
    this.loading = false,
    this.inverse = false,
    this.semanticsLabel,
    this.semanticsHint,
    this.excludeSemantics = false,
    this.negative = false,
  });

  @override
  Widget build(BuildContext context) {
    var globalTokens = Provider.of<MudeThemeManager>(context).globals;
    var aliasTokens = Provider.of<MudeThemeManager>(context).alias;

    final globalSize = globalTokens.shapes.size;

    double? typeChoice;
    typeChoice = type == MudeButtonType.minwidth ? null : double.maxFinite;

    return Semantics(
      child: SizedBox(
        height: size == MudeButtonSize.sm ? globalSize.s5x : null,
        child: ContainerButtonWidget(
          label: label,
          labelStyle: size == MudeButtonSize.sm ? aliasTokens.mixin.labelSm2 : null,
          onPressed: onPressed,
          width: typeChoice,
          minWidth: size == MudeButtonSize.sm ? globalSize.s8x : null,
          icon: icon,
          disabled: disabled,
          loading: loading,
          inverse: inverse,
          negative: negative,
          semanticsLabel: semanticsLabel,
          semanticsHint: semanticsHint,
          excludeSemantics: excludeSemantics,
        ),
      ),
    );
  }
}
