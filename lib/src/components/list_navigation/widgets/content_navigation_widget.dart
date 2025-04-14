import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:expense_core/core.dart';
import 'package:expense_core/src/components/list_navigation/widgets/tag_widget.dart';

import 'leading_nav_widget.dart';

class ContentNavigationWidget extends StatelessWidget {
  final String label;
  final String? description;
  final dynamic leading;
  final ExpenseTagContainer? tag;
  final bool inverse;

  const ContentNavigationWidget({
    super.key,
    required this.label,
    this.description,
    this.leading,
    this.tag,
    this.inverse = false,
  });

  @override
  Widget build(BuildContext context) {
    var tokens = Provider.of<ExpenseThemeManager>(context);
    var globalTokens = tokens.globals;
    var aliasTokens = tokens.alias;
    var spacing = globalTokens.shapes.spacing;

    Widget getDescription() {
      if (description == null) {
        return const SizedBox.shrink();
      }

      return Semantics(
        label: description,
        child: Column(
          children: [
            ExpenseDescription(description!),
          ],
        ),
      );
    }

    return !(leading is ExpenseAvatarGroup || leading is ExpenseIconData)
        ? _buildNormalContent(getDescription, aliasTokens, spacing)
        : _buildContent(aliasTokens, spacing);
  }

  Row _buildNormalContent(getDescription, aliasTokens, spacing) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Leading widget
        LeadingNavWidget(
          child: leading,
          inverse: inverse,
        ),

        // Content
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: spacing.s1x),
                child: getDescription(),
              ),
              Text(
                label,
                style: aliasTokens.mixin.labelMd2.merge(TextStyle(
                  color: aliasTokens.color.text.labelColor,
                )),
              ),
            ],
          ),
        ),

        // Tag
        TagWidget(
          tag: tag,
        ),

        // Icon
        ExcludeSemantics(
          child: Padding(
            padding: EdgeInsets.only(left: spacing.s2x),
            child: ExpenseIcon(
              icon: ExpenseIcons.navigationRightLine,
              size: ExpenseIconSize.lg,
              color: aliasTokens.color.elements.iconColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContent(aliasTokens, spacing) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: spacing.s1x),
              child: ExpenseDescription(description!),
            ),
            Row(
              children: [
                // Leading widget
                LeadingNavWidget(
                  child: leading,
                  inverse: inverse,
                ),

                // Content
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      label,
                      style: aliasTokens.mixin.labelMd2.merge(TextStyle(
                        color: aliasTokens.color.text.labelColor,
                      )),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        ExcludeSemantics(
          child: Padding(
            padding: EdgeInsets.only(left: spacing.s2x),
            child: ExpenseIcon(
              icon: ExpenseIcons.navigationRightLine,
              size: ExpenseIconSize.lg,
              color: aliasTokens.color.elements.iconColor,
            ),
          ),
        ),
      ],
    );
  }
}
