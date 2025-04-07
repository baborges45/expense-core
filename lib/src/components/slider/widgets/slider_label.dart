import 'package:mude_core/core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SliderLabel extends StatelessWidget {
  final String initialValue;
  final String finalValue;

  const SliderLabel({
    super.key,
    required this.initialValue,
    required this.finalValue,
  });

  @override
  Widget build(BuildContext context) {
    var tokens = Provider.of<MudeThemeManager>(context);
    var aliasTokens = tokens.alias;
    var labelMd1 = aliasTokens.mixin.labelMd1.copyWith(
      color: aliasTokens.color.text.labelColor,
    );

    return Row(
      key: const Key('slider.label'),
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          initialValue,
          style: labelMd1,
        ),
        Text(
          finalValue,
          style: labelMd1,
        ),
      ],
    );
  }
}
