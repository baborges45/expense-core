import 'package:flutter/material.dart';

import 'package:mude_core/core.dart';

class TrailingWidget extends StatelessWidget {
  final MudeButtonIcon? trailingButton;

  const TrailingWidget({
    super.key,
    this.trailingButton,
  });

  @override
  Widget build(BuildContext context) {
    if (trailingButton == null) {
      return const SizedBox.shrink();
    }

    return trailingButton!;
  }
}
