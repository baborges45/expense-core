import 'package:flutter/material.dart';
import 'package:expense_core/core.dart';
import 'package:provider/provider.dart';

part 'widgets/_body_custom.dart';
part 'widgets/_button_close.dart';

class ExpenseSuperDrawer {
  // coverage:ignore-start
  const ExpenseSuperDrawer._();
  // coverage:ignore-end

  static Future<void> show(
    BuildContext context, {
    ///A list of Widgets that will be displayed in the drawer.
    required List<Widget> children,
    EdgeInsetsGeometry? padding,

    ///The custom backgroundColor
    Color? backgroundColor,

    ///The vertical alignment of the Column that contains the children.
    ///The default value is [MainAxisAlignment.start].
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,

    ///the horizontal alignment of the Column that contains the children.
    ///The default to [CrossAxisAlignment.start].
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.start,
  }) async {
    var tokens = context.read<ExpenseThemeManager>();
    var aliasTokens = tokens.alias;

    Color getBarrierColor() {
      return aliasTokens.mixin.overlayDefault;
    }

    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: getBarrierColor(),
      isScrollControlled: true,
      useRootNavigator: true,
      enableDrag: false,
      builder: (BuildContext context) {
        return Semantics(
          container: true,
          child: _BodyCustom(
            backgroundColor: backgroundColor,
            padding: padding,
            child: Column(
              children: [
                _ButtonClose(padding),
                Expanded(
                  child: Column(
                    mainAxisAlignment: mainAxisAlignment,
                    crossAxisAlignment: crossAxisAlignment,
                    children: children,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
