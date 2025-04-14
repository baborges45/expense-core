import 'package:expense_core/core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FlagDescription extends StatelessWidget {
  final ExpenseFlagType type;
  final String message;
  final ExpenseFlagHyperLink? hyperLink;

  const FlagDescription({
    super.key,
    required this.type,
    required this.message,
    this.hyperLink,
  });

  @override
  Widget build(BuildContext context) {
    var tokens = Provider.of<ExpenseThemeManager>(context);
    var globalTokens = tokens.globals;
    var aliasTokens = tokens.alias;

    Color getFontColor() {
      switch (type) {
        case ExpenseFlagType.positive:
          return aliasTokens.color.positive.onDescriptionColor;
        case ExpenseFlagType.informative:
          return aliasTokens.color.informative.onDescriptionColor;
        case ExpenseFlagType.negative:
          return aliasTokens.color.negative.onDescriptionColor;
        case ExpenseFlagType.promote:
          return aliasTokens.color.promote.onDescriptionColor;
        case ExpenseFlagType.warning:
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
