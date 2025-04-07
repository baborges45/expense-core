import 'package:flutter/material.dart';
import 'package:mude_core/core.dart';
import 'package:provider/provider.dart';

class LabelDescriptionWidget extends StatelessWidget {
  final String description;

  const LabelDescriptionWidget(this.description, {super.key});

  @override
  Widget build(BuildContext context) {
    var globalTokens = Provider.of<MudeThemeManager>(context).globals;
    var aliasTokens = globalTokens.shapes.spacing;

    return Padding(
      padding: EdgeInsets.only(
        right: aliasTokens.s1_5x,
      ),
      child: MudeDescription(description),
    );
  }
}
