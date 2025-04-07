// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:mude_core/core.dart';

class MudeDivider extends StatelessWidget {
  ///An enumeration representing the size of the divider.
  ///It has two values: [MudeDividerSize.thin] and [MudeDividerSize.thick].
  late MudeDividerSize size;

  MudeDivider.thin({super.key}) {
    size = MudeDividerSize.thin;
  }

  @override
  Widget build(BuildContext context) {
    var tokens = Provider.of<MudeThemeManager>(context);
    var aliasTokens = tokens.alias;
    double getSizes = 1.0;

    return Container(
      height: getSizes,
      color: aliasTokens.color.elements.borderColor,
    );
  }
}
