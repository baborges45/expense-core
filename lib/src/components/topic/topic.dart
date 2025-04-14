import 'package:flutter/material.dart';
import 'package:expense_core/core.dart';
import 'package:provider/provider.dart';

class ExpenseTopic extends StatelessWidget {
  ///A String representing the text of the topic.
  final String text;

  ///A [ExpenseIconData] object representing the icon associated with the topic.
  final ExpenseIconData icon;

  ///A string value that provides a descriptive label for accessibility purposes.
  ///The default value is null
  final String? semanticsLabel;

  ///A string value that indicates additional accessibility information.
  ///The default value is null
  final String? semanticsHint;

  const ExpenseTopic({
    super.key,
    required this.text,
    required this.icon,
    this.semanticsLabel,
    this.semanticsHint,
  });

  @override
  Widget build(BuildContext context) {
    var tokens = Provider.of<ExpenseThemeManager>(context);
    var globalTokens = tokens.globals;
    var aliasTokens = tokens.alias;

    return Semantics(
      label: semanticsLabel ?? text,
      hint: semanticsHint,
      excludeSemantics: true,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: ExpenseIcon(
              icon: icon,
              size: ExpenseIconSize.lg,
              color: aliasTokens.color.elements.iconColor,
            ),
          ),
          SizedBox(width: globalTokens.shapes.spacing.s2x),
          Expanded(
            child: ExpenseParagraph(
              text,
              size: ExpenseParagraphSize.sm,
            ),
          ),
        ],
      ),
    );
  }
}
