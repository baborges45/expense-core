import 'package:mude_core/core.dart';
import 'package:flutter/material.dart';

class LabelText extends StatelessWidget {
  final String label;

  const LabelText(this.label, {super.key});

  @override
  Widget build(BuildContext context) {
    return MudeHeading(
      label,
      size: MudeHeadingSize.xs,
    );
  }
}
