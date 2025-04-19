import 'package:flutter/material.dart';
import 'package:expense_core/core.dart';
import 'package:provider/provider.dart';

class ExpenseButtonGroup extends StatelessWidget {
  ///An object of type [ExpenseButton] that represents the primary button in the group.
  ///This button is displayed in normal size.
  final ExpenseButton buttonPrimary;

  ///An object of type ExpenseButtonMini that represents the tertiary button in the group.
  ///This button is displayed in a smaller size compared to the primary button.
  final ExpenseButtonMini buttonTertiary;

  ///A boolean value indicating whether the button group has a fixed width or should expand to occupy all available space.
  final bool fixed;

  ///An object of type [ExpenseButtonGrouType] that defines the display type of the button group.
  ///The possible values for this type are "blocked" and "group".
  final ExpenseButtonGrouType type;

  ///(Optional) A boolean parameter that specifies whether the link should have an inverse color scheme.
  ///The default value is false.
  final bool inverse;

  ///(Optional) A boolean indicating whether the button should have a negative color scheme.
  final bool negative;

  const ExpenseButtonGroup({
    super.key,
    required this.buttonPrimary,
    required this.buttonTertiary,
    this.type = ExpenseButtonGrouType.blocked,
    this.fixed = true,
    this.inverse = false,
    this.negative = false,
  });

  @override
  Widget build(BuildContext context) {
    var globalTokens = Provider.of<ExpenseThemeManager>(context).globals;

    if (type == ExpenseButtonGrouType.group) {
      return Row(
        children: [
          Expanded(
            flex: 1,
            child: Center(
              child: ExpenseButtonMini(
                label: buttonTertiary.label,
                onPressed: buttonTertiary.onPressed,
                disabled: buttonTertiary.disabled,
                inverse: inverse,
                semanticsLabel: buttonTertiary.semanticsLabel,
                semanticsHint: buttonTertiary.semanticsHint,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.only(left: globalTokens.shapes.spacing.s2x),
              child: ExpenseButton(
                label: buttonPrimary.label,
                onPressed: buttonPrimary.onPressed,
                icon: buttonPrimary.icon,
                disabled: buttonPrimary.disabled,
                loading: buttonPrimary.loading,
                type: ExpenseButtonType.blocked,
                inverse: inverse,
                negative: negative,
                semanticsLabel: buttonPrimary.semanticsLabel,
                semanticsHint: buttonPrimary.semanticsHint,
              ),
            ),
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ExpenseButton(
          label: buttonPrimary.label,
          onPressed: buttonPrimary.onPressed,
          icon: buttonPrimary.icon,
          disabled: buttonPrimary.disabled,
          loading: buttonPrimary.loading,
          type: ExpenseButtonType.blocked,
          inverse: inverse,
          negative: negative,
          semanticsLabel: buttonPrimary.semanticsLabel,
          semanticsHint: buttonPrimary.semanticsHint,
        ),
        Padding(
          padding: EdgeInsets.only(top: globalTokens.shapes.spacing.s2x),
          child: Center(
            child: ExpenseButtonMini(
              label: buttonTertiary.label,
              onPressed: buttonTertiary.onPressed,
              disabled: buttonTertiary.disabled,
              inverse: inverse,
              semanticsLabel: buttonTertiary.semanticsLabel,
              semanticsHint: buttonTertiary.semanticsHint,
            ),
          ),
        ),
      ],
    );
  }
}
