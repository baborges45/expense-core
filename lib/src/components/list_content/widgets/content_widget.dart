import 'package:flutter/material.dart';

import 'package:mude_core/core.dart';
import 'package:provider/provider.dart';

import 'leading_widget.dart';
import 'trailing_widget.dart';

class ContentWidget extends StatelessWidget {
  final String label;
  final String? description;
  final String? labelRight;
  final String? descriptionRight;
  final dynamic leading;
  final MudeButtonIcon? trailingButton;
  final bool isLayoutContainer;
  final bool inverse;

  const ContentWidget({
    super.key,
    required this.label,
    this.description,
    this.labelRight,
    this.descriptionRight,
    this.leading,
    this.trailingButton,
    this.isLayoutContainer = false,
    this.inverse = false,
  });

  @override
  Widget build(BuildContext context) {
    var tokens = Provider.of<MudeThemeManager>(context);
    var globalTokens = tokens.globals;
    var aliasTokens = tokens.alias;
    var spacing = globalTokens.shapes.spacing;

    Widget getLabelRight() {
      if (descriptionRight == null) {
        return const SizedBox.shrink();
      }

      return Semantics(
        label: descriptionRight,
        child: Padding(
          padding: EdgeInsets.only(left: spacing.s1x),
          child: MudeDescription(descriptionRight!),
        ),
      );
    }

    Widget getDescription() {
      if (description == null) {
        return const SizedBox.shrink();
      }

      return Semantics(
        label: description,
        child: Column(
          children: [
            MudeDescription(description!),
          ],
        ),
      );
    }

    return !(leading is MudeAvatarGroup || leading is MudeIconData)
        ? _buildNormalContent(
            getDescription,
            spacing,
            getLabelRight,
            aliasTokens,
          )
        : _buildContent(
            aliasTokens,
            getLabelRight,
            spacing,
          );
  }

  Row _buildNormalContent(getDescription, spacing, getLabelRight, aliasTokens) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Leading widget
        LeadingWidget(
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
              Row(
                children: [
                  Text(
                    label,
                    style: aliasTokens.mixin.labelMd2.merge(
                      TextStyle(
                        color: aliasTokens.color.text.labelColor,
                      ),
                    ),
                  ),
                  getLabelRight(),
                ],
              ),
            ],
          ),
        ),

        // Icon
        TrailingWidget(trailingButton: trailingButton),
      ],
    );
  }

  Widget _buildContent(aliasTokens, getLabelRight, spacing) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: spacing.s1x),
              child: MudeDescription(description!),
            ),
            Row(
              children: [
                // Leading widget
                LeadingWidget(
                  child: leading,
                  inverse: inverse,
                ),

                // Content
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Text(
                          label,
                          style: aliasTokens.mixin.labelMd2.merge(
                            TextStyle(
                              color: aliasTokens.color.text.labelColor,
                            ),
                          ),
                        ),
                        getLabelRight(),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        TrailingWidget(trailingButton: trailingButton),
      ],
    );
  }
}
