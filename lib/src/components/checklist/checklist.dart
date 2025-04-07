import 'package:flutter/material.dart';
import 'package:mude_core/core.dart';
import 'package:provider/provider.dart';

class MudeChecklist extends StatelessWidget {
  final List<MudeCheckbox> checkboxList;

  ///A string value that indicates if you add more information from accessibility
  ///The default value is null
  final String? semanticsLabel;

  ///A string value that indicates if you add more information from accessibility
  ///The default value is null
  final String? semanticsHint;

  ///A boolean value that indicates if you want ignore auto accessibility from widget
  ///The default value is false
  final bool excludeSemantics;

  const MudeChecklist({
    super.key,
    required this.checkboxList,
    this.semanticsLabel,
    this.semanticsHint,
    this.excludeSemantics = false,
  });

  @override
  Widget build(BuildContext context) {
    var tokens = Provider.of<MudeThemeManager>(context);
    var globalTokens = tokens.globals;
    var size = globalTokens.shapes.size.s2_5x;

    return Semantics(
      label: semanticsLabel,
      hint: semanticsHint,
      excludeSemantics: excludeSemantics,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: checkboxList.map((checkbox) {
          return Padding(
            padding: EdgeInsets.only(bottom: size),
            child: checkbox,
          );
        }).toList(),
      ),
    );
  }
}
