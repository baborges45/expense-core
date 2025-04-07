import 'package:mude_core/core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FlagDescription extends StatelessWidget {
  final MudeFlagType type;
  final String message;
  final MudeFlagHyperLink? hyperLink;

  const FlagDescription({
    super.key,
    required this.type,
    required this.message,
    this.hyperLink,
  });

  @override
  Widget build(BuildContext context) {
    var tokens = Provider.of<MudeThemeManager>(context);
    var globalTokens = tokens.globals;
    var aliasTokens = tokens.alias;

    Color getFontColor() {
      switch (type) {
        case MudeFlagType.positive:
          return aliasTokens.color.positive.onDescriptionColor;
        case MudeFlagType.informative:
          return aliasTokens.color.informative.onDescriptionColor;
        case MudeFlagType.negative:
          return aliasTokens.color.negative.onDescriptionColor;
        case MudeFlagType.promote:
          return aliasTokens.color.promote.onDescriptionColor;
        case MudeFlagType.warning:
          return aliasTokens.color.warning.onDescriptionColor;
      }
    }

    final color = getFontColor();

    TextStyle descriptionStyle = TextStyle(
      color: color,
      fontFamily: globalTokens.typographys.fontFamilyBase,
      fontWeight: globalTokens.typographys.fontWeightRegular,
      fontSize: globalTokens.typographys.fontSize3xs,
      height: globalTokens.typographys.lineHeightLg,
      letterSpacing: globalTokens.typographys.letterSpacingDefault,
    );

    List<InlineSpan> textSpans() {
      List<InlineSpan> newSpans = [];

      newSpans.add(
        TextSpan(
          text: message,
        ),
      );

      if (hyperLink != null) {
        newSpans.add(
          WidgetSpan(
            baseline: TextBaseline.alphabetic,
            alignment: PlaceholderAlignment.middle,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 0.5),
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 1,
                      color: color,
                    ),
                  ),
                ),
                child: GestureDetector(
                  onTap: hyperLink!.onPressed,
                  child: Text(
                    hyperLink!.text,
                    style: descriptionStyle,
                  ),
                ),
              ),
            ),
          ),
        );
      }

      return newSpans;
    }

    return RichText(
      text: TextSpan(style: descriptionStyle, children: textSpans()),
    );
  }
}
