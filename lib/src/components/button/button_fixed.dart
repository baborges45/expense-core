import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:mude_core/core.dart';

class MudeButtonFixed extends StatelessWidget {
  ///A [MudeButton] object that represents the button to be displayed.
  final MudeButton button;

  const MudeButtonFixed({
    super.key,
    required this.button,
  });

  @override
  Widget build(BuildContext context) {
    var globalTokens = Provider.of<MudeThemeManager>(context).globals;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        MudeDivider.thin(),
        Padding(
          padding: EdgeInsets.only(top: globalTokens.shapes.spacing.s3x),
          child: button,
        ),
      ],
    );
  }
}
