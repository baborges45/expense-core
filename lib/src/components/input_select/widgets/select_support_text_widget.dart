import 'package:flutter/material.dart';
import 'package:mude_core/core.dart';
import 'package:provider/provider.dart';

class SelectSupportTextWidget extends StatelessWidget {
  final String? text;
  final bool disabled;
  final bool hasError;

  const SelectSupportTextWidget({
    super.key,
    required this.text,
    required this.disabled,
    required this.hasError,
  });

  @override
  Widget build(BuildContext context) {
    if (text == null) return const SizedBox.shrink();

    var tokens = Provider.of<MudeThemeManager>(context);
    var globalTokens = tokens.globals;
    var aliasTokens = tokens.alias;

    Color getTextColor() {
      if (disabled) {
        return aliasTokens.color.disabled.supportTextColor;
      }

      return hasError
          ? aliasTokens.color.negative.supportTextColor
          : aliasTokens.color.text.supportTextColor;
    }

    return Column(
      children: [
        SizedBox(height: globalTokens.shapes.spacing.s1x),
        Text(
          key: const Key('select_support_text.label'),
          text!,
          style: aliasTokens.mixin.supportText.merge(TextStyle(
            color: getTextColor(),
          )),
        ),
      ],
    );
  }
}
