import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:expense_core/core.dart';

import 'label_text_widget.dart';

class LabelWidget extends StatelessWidget {
  final String label;

  const LabelWidget(this.label, {super.key});

  @override
  Widget build(BuildContext context) {
    var globalTokens = Provider.of<ExpenseThemeManager>(context).globals;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.only(bottom: globalTokens.shapes.spacing.s2_5x),
          child: LabelText(label),
        ),
      ],
    );
  }
}
