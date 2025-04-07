import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:mude_core/core.dart';

import 'widgets/container_widget.dart';

class MudeButtonFloat extends StatelessWidget {
  ///A string representing the label or text of the button.
  final String label;

  ///A callback function that will be invoked when the button is pressed.
  final VoidCallback onPressed;

  /// (Optional) A [MudeIconData] object representing the icon to be displayed on the button.
  final MudeIconData? icon;

  ///(Optional) A boolean indicating whether the button should be disabled. The default value is false.
  final bool disabled;

  ///(Optional) A boolean indicating whether the button should display a loading indicator. The default value is false.
  final bool loading;

  ///A string value that indicates if you add more information from accessibility
  ///The default value is null
  final String? semanticsLabel;

  ///A string value that indicates if you add more information from accessibility
  ///The default value is null
  final String? semanticsHint;

  ///A boolean value can be utilized to determine whether child semantics will be taken into consideration or not.
  ///The default value is false.
  final bool excludeSemantics;

  ///A boolean value that indicates whether the button should be displayed as a floating button.
  final bool isFloat;

  const MudeButtonFloat({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.disabled = false,
    this.loading = false,
    this.semanticsLabel,
    this.semanticsHint,
    this.excludeSemantics = false,
    this.isFloat = false,
  });

  @override
  Widget build(BuildContext context) {
    var globalTokens = Provider.of<MudeThemeManager>(context).globals;

    return ContainerButtonWidget(
      label: label,
      onPressed: onPressed,
      width: double.maxFinite,
      boxShadow: globalTokens.shapes.shadow.level3,
      icon: icon,
      disabled: disabled,
      loading: loading,
      isFloat: isFloat,
      semanticsLabel: semanticsLabel,
      semanticsHint: semanticsHint,
      excludeSemantics: excludeSemantics,
    );
  }
}
