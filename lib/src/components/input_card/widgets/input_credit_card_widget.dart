import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:mude_core/core.dart';

class InputCreditCardWidget extends StatelessWidget {
  final MudeFlagData? flag;
  final bool isPressed;

  const InputCreditCardWidget({
    super.key,
    required this.flag,
    required this.isPressed,
  });

  @override
  Widget build(BuildContext context) {
    var tokens = Provider.of<MudeThemeManager>(context);
    var globalTokens = tokens.globals;

    return Padding(
      padding: EdgeInsets.only(
        right: globalTokens.shapes.spacing.s2x,
      ),
      child: MudeCreditCard(
        flag: flag,
        inverse: isPressed,
      ),
    );
  }
}
