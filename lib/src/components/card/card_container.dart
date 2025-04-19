import 'package:flutter/material.dart';
import 'package:expense_core/core.dart';
import 'package:provider/provider.dart';

import 'widgets/card_container.dart';

class ExpenseCardContainer extends StatelessWidget {
  /// A [Widget] that will be the child.
  final Widget? child;

  ///(Optional) A [VoidCallback] callback that is triggered when the banner is pressed.
  final VoidCallback? onPressed;

  ///A string value that provides a descriptive label for accessibility purposes.
  ///The default value is null
  final String? semanticsLabel;

  ///A string value that indicates additional accessibility information.
  ///The default value is null
  final String? semanticsHint;

  // Should it have the s35x fixed size or be blocked
  final bool fixedSize;

  ///An object of type [ExpenseCardContainerType] that defines the display type of the button group.
  ///The possible values for this type are "card", "active", "inverse" and "gradient". Default to card.
  final ExpenseCardContainerType type;

  const ExpenseCardContainer({
    super.key,
    this.child,
    this.onPressed,
    this.semanticsLabel,
    this.semanticsHint,
    this.fixedSize = false,
    this.type = ExpenseCardContainerType.card,
  });

  @override
  Widget build(BuildContext context) {
    var aliasTokens = Provider.of<ExpenseThemeManager>(context).alias;

    return Semantics(
      button: true,
      label: semanticsLabel,
      hint: semanticsHint,
      excludeSemantics: semanticsHint != null,
      child: CardContainer(
        type: type,
        onPressed: onPressed,
        opacity: aliasTokens.color.pressed.containerOpacity,
        noBorder: true,
        fixedSize: fixedSize,
        child: child,
      ),
    );
  }
}
