import 'package:flutter/material.dart';
import 'package:expense_core/core.dart';
import 'package:expense_core/src/utils/check_url_is_valid.dart';
import 'package:provider/provider.dart';

import 'widgets/card_container.dart';

class ExpenseCardImageContainer extends StatelessWidget {
  /// Set a local or web path to load an image
  final String src;

  /// Set the heroTag value
  final String? heroTag;

  /// Set a new [Widget] to displayed.
  final Widget? child;

  ///(Optional) A [VoidCallback] callback that is triggered when the banner is pressed.
  final VoidCallback? onPressed;

  /// A [BoxFit] value that determines how the image should be fitted within its container.
  /// The default value is [BoxFit.cover].
  final BoxFit fit;

  ///A string value that provides a descriptive label for accessibility purposes.
  ///The default value is null
  final String? semanticsLabel;

  ///A string value that indicates additional accessibility information.
  ///The default value is null
  final String? semanticsHint;

  const ExpenseCardImageContainer({
    super.key,
    required this.src,
    this.child,
    this.heroTag,
    this.onPressed,
    this.fit = BoxFit.cover,
    this.semanticsLabel,
    this.semanticsHint,
  });

  @override
  Widget build(BuildContext context) {
    var tokens = Provider.of<ExpenseThemeManager>(context);
    var globalTokens = tokens.globals;
    final spacing = globalTokens.shapes.spacing;
    var aliasTokens = tokens.alias;
    var border = aliasTokens.defaultt.borderRadius;

    Widget getImage() {
      var sourceLoad = urlIsvalid(src) ? ExpenseImage.network : ExpenseImage.asset;

      BorderRadius? defineBorderRadius = BorderRadius.only(
        topLeft: Radius.circular(border),
        topRight: Radius.circular(border),
        bottomLeft: Radius.zero,
        bottomRight: Radius.zero,
      );

      return Hero(
        tag: heroTag ?? UniqueKey(),
        child: sourceLoad(
          src,
          fit: fit,
          width: double.maxFinite,
          aspectRatio: ExpenseImageAspectRatio.ratio_3x2,
          borderRadius: defineBorderRadius,
        ),
      );
    }

    return Semantics(
      button: onPressed != null,
      label: semanticsLabel,
      hint: semanticsHint,
      onTap: onPressed,
      excludeSemantics: semanticsHint != null,
      child: SizedBox(
        width: globalTokens.shapes.size.s30x,
        child: CardContainer(
          noPadding: true,
          type: ExpenseCardContainerType.card,
          onPressed: onPressed,
          opacity: aliasTokens.color.pressed.containerOpacity,
          noBorder: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getImage(),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: spacing.s2x,
                    vertical: spacing.s3x,
                  ),
                  child: child,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
