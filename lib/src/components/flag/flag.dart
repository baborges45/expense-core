import 'package:flutter/material.dart';
import 'package:mude_core/core.dart';
import 'package:provider/provider.dart';

import 'widgets/description.dart';

class MudeFlag extends StatelessWidget {
  ///A string representing the label or text of the button.
  final String message;

  ///(Optional) An [AlertHyperLink] object that represents a hyperlink in the widget.
  ///It will be displayed in the end of the text.
  final MudeFlagHyperLink? hyperLink;

  ///A MudeFlagType type that represents the type or category of the flag,
  ///It can be positive, informative, negative, promote, or warning.
  final MudeFlagType type;

  ///A string value that provides a descriptive label for accessibility purposes.
  ///The default value is null
  final String? semanticsLabel;

  ///A string value that indicates additional accessibility information.
  ///The default value is null
  final String? semanticsHint;

  const MudeFlag({
    super.key,
    required this.type,
    this.hyperLink,
    this.semanticsLabel,
    this.semanticsHint,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    final tokens = Provider.of<MudeThemeManager>(context);
    final globalTokens = tokens.globals;
    final aliasTokens = tokens.alias;
    final spacing = globalTokens.shapes.spacing;

    Color getBackgroundColor() {
      switch (type) {
        case MudeFlagType.positive:
          return aliasTokens.color.positive.bgColor;
        case MudeFlagType.informative:
          return aliasTokens.color.informative.bgColor;
        case MudeFlagType.negative:
          return aliasTokens.color.negative.bgColor;
        case MudeFlagType.promote:
          return aliasTokens.color.promote.bgColor;
        case MudeFlagType.warning:
          return aliasTokens.color.warning.bgColor;
      }
    }

    MudeIconData getIcon() {
      switch (type) {
        case MudeFlagType.positive:
          return MudeIcons.positiveLine;
        case MudeFlagType.informative:
          return MudeIcons.informationLine;
        case MudeFlagType.negative:
          return MudeIcons.negativeLine;
        case MudeFlagType.promote:
          return MudeIcons.promoteLine;
        case MudeFlagType.warning:
          return MudeIcons.warningLine;
      }
    }

    Color getIconColor() {
      switch (type) {
        case MudeFlagType.positive:
          return aliasTokens.color.positive.onIconColor;
        case MudeFlagType.informative:
          return aliasTokens.color.informative.onIconColor;
        case MudeFlagType.negative:
          return aliasTokens.color.negative.onIconColor;
        case MudeFlagType.promote:
          return aliasTokens.color.promote.onIconColor;
        case MudeFlagType.warning:
          return aliasTokens.color.warning.onIconColor;
      }
    }

    String getSemanticsLabel() {
      final labelSemantics = semanticsLabel ?? message;
      final linkSemantics = hyperLink != null ? hyperLink!.text : '';

      switch (type) {
        case MudeFlagType.positive:
          return 'positivo: $labelSemantics $linkSemantics';
        case MudeFlagType.informative:
          return 'informativo: $labelSemantics $linkSemantics';
        case MudeFlagType.negative:
          return 'negativo: $labelSemantics $linkSemantics';
        case MudeFlagType.promote:
          return 'promoção: $labelSemantics $linkSemantics';
        case MudeFlagType.warning:
          return 'atenção: $labelSemantics $linkSemantics';
      }
    }

    return Semantics(
      container: true,
      label: getSemanticsLabel(),
      hint: semanticsHint,
      excludeSemantics: true,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: spacing.s3x,
        ),
        constraints: BoxConstraints(minHeight: globalTokens.shapes.size.s7x),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            aliasTokens.defaultt.borderRadius,
          ),
          color: getBackgroundColor(),
        ),
        child: Row(
          children: [
            ExcludeSemantics(
              child: MudeIcon(
                icon: getIcon(),
                color: getIconColor(),
              ),
            ),
            SizedBox(
              width: spacing.s1x,
            ),
            Expanded(
              child: FlagDescription(
                type: type,
                message: message,
                hyperLink: hyperLink,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
