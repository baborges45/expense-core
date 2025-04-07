import 'package:flutter/material.dart';
import 'package:mude_core/core.dart';
import 'package:provider/provider.dart';

class MudeButtonGroup extends StatelessWidget {
  ///An object of type [MudeButton] that represents the primary button in the group.
  ///This button is displayed in normal size.
  final MudeButton buttonPrimary;

  ///An object of type MudeButtonMini that represents the tertiary button in the group.
  ///This button is displayed in a smaller size compared to the primary button.
  final MudeButtonMini buttonTertiary;

  ///A boolean value indicating whether the button group has a fixed width or should expand to occupy all available space.
  final bool fixed;

  ///An object of type [MudeButtonGrouType] that defines the display type of the button group.
  ///The possible values for this type are "blocked" and "group".
  final MudeButtonGrouType type;

  ///(Optional) A boolean parameter that specifies whether the link should have an inverse color scheme.
  ///The default value is false.
  final bool inverse;

  ///(Optional) A boolean indicating whether the button should have a negative color scheme.
  final bool negative;

  const MudeButtonGroup({
    super.key,
    required this.buttonPrimary,
    required this.buttonTertiary,
    this.type = MudeButtonGrouType.blocked,
    this.fixed = true,
    this.inverse = false,
    this.negative = false,
  });

  @override
  Widget build(BuildContext context) {
    var globalTokens = Provider.of<MudeThemeManager>(context).globals;

    if (type == MudeButtonGrouType.group) {
      return Row(
        children: [
          Expanded(
            flex: 1,
            child: Center(
              child: MudeButtonMini(
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
              child: MudeButton(
                label: buttonPrimary.label,
                onPressed: buttonPrimary.onPressed,
                icon: buttonPrimary.icon,
                disabled: buttonPrimary.disabled,
                loading: buttonPrimary.loading,
                type: MudeButtonType.blocked,
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
        MudeButton(
          label: buttonPrimary.label,
          onPressed: buttonPrimary.onPressed,
          icon: buttonPrimary.icon,
          disabled: buttonPrimary.disabled,
          loading: buttonPrimary.loading,
          type: MudeButtonType.blocked,
          inverse: inverse,
          negative: negative,
          semanticsLabel: buttonPrimary.semanticsLabel,
          semanticsHint: buttonPrimary.semanticsHint,
        ),
        Padding(
          padding: EdgeInsets.only(top: globalTokens.shapes.spacing.s2x),
          child: Center(
            child: MudeButtonMini(
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
