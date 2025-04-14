import 'package:flutter/material.dart';
import 'package:expense_core/core.dart';
import 'package:provider/provider.dart';

import 'widgets/container_widget.dart';

class ExpenseButton extends StatelessWidget {
  ///A string representing the label or text of the button.
  final String label;

  ///A required callback that will be called when the button is pressed.
  final VoidCallback onPressed;

  ///(Optional) A ExpenseButtonType enum value representing the type of the button.
  final ExpenseButtonType? type;

  ///(Optional) A ExpenseButtonSyze enum value representing the size of the button.
  final ExpenseButtonSize? size;

  ///(Optional) A ExpenseIconData object representing the icon to be displayed on the button.
  final ExpenseIconData? icon;

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

  const ExpenseButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.type = ExpenseButtonType.minwidth,
    this.size = ExpenseButtonSize.lg,
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
    var globalTokens = Provider.of<ExpenseThemeManager>(context).globals;
    var aliasTokens = Provider.of<ExpenseThemeManager>(context).alias;

    final globalSize = globalTokens.shapes.size;

    double? typeChoice;
    typeChoice = type == ExpenseButtonType.minwidth ? null : double.maxFinite;

    return Semantics(
      child: SizedBox(
        height: size == ExpenseButtonSize.sm ? globalSize.s5x : null,
        child: ContainerButtonWidget(
          label: label,
          labelStyle: size == ExpenseButtonSize.sm ? aliasTokens.mixin.labelSm2 : null,
          onPressed: onPressed,
          width: typeChoice,
          minWidth: size == ExpenseButtonSize.sm ? globalSize.s8x : null,
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
