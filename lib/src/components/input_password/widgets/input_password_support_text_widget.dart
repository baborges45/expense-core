import 'package:flutter/material.dart';
import 'package:mude_core/core.dart';
import 'package:provider/provider.dart';

class InputPasswordSupportTextWidget extends StatelessWidget {
  final String? text;
  final bool disabled;
  final bool hasError;

  const InputPasswordSupportTextWidget({
    super.key,
    required this.text,
    required this.disabled,
    required this.hasError,
  });

  @override
  Widget build(BuildContext context) {
    if (text == null || text!.isEmpty) return const SizedBox(height: 20);

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

    final newText = hasError ? 'Erro, ${text!}' : text!;

    return Semantics(
      label: newText,
      excludeSemantics: true,
      child: Column(
        children: [
          SizedBox(height: globalTokens.shapes.spacing.s1x),
          Text(
            text!,
            style: aliasTokens.mixin.supportText.merge(
              TextStyle(color: getTextColor()),
            ),
          ),
        ],
      ),
    );
  }
}
