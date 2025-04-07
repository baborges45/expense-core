import 'package:mude_core/core.dart';
import 'package:flutter/material.dart';

class DescriptionWidget extends StatelessWidget {
  final String? description;
  final String? semanticsDescription;

  const DescriptionWidget({
    super.key,
    required this.description,
    this.semanticsDescription,
  });

  @override
  Widget build(BuildContext context) {
    if (description == null) return const SizedBox.shrink();

    return MudeDescription(
      description!,
      semanticsLabel: semanticsDescription ?? description!,
    );
  }
}
