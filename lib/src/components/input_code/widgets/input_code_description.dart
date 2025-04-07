import 'package:flutter/material.dart';
import 'package:mude_core/core.dart';

class InputCodeDescription extends StatelessWidget {
  final String description;

  const InputCodeDescription({
    super.key,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    if (description.isEmpty) return const SizedBox.shrink();

    return MudeDescription(description);
  }
}
