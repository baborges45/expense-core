import 'package:mude_core/core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SupportText extends StatelessWidget {
  final String? supportText;
  final bool disabled;
  final bool hasError;

  const SupportText({
    super.key,
    this.supportText,
    required this.disabled,
    required this.hasError,
  });

  @override
  Widget build(BuildContext context) {
    if (supportText == null) return const SizedBox.shrink();

    final tokens = Provider.of<MudeThemeManager>(context);
    final aliasTokens = tokens.alias;

    Color getTextColor() {
      if (disabled) {
        return aliasTokens.color.disabled.supportTextColor;
      }

      if (hasError) {
        return aliasTokens.color.negative.supportTextColor;
      }

      return aliasTokens.color.text.supportTextColor;
    }

    return Text(
      supportText!,
      style: aliasTokens.mixin.supportText.apply(
        color: getTextColor(),
      ),
    );
  }
}
