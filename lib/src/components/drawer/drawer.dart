import 'package:flutter/material.dart';
import 'package:expense_core/core.dart';
import 'package:provider/provider.dart';

part 'widgets/_body_custom.dart';
part 'widgets/_line_drawer.dart';

class ExpenseDrawer {
  // coverage:ignore-start
  const ExpenseDrawer._();
  // coverage:ignore-end

  static Future<void> show(
    BuildContext context, {
    required List<Widget> children,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.start,
    double maxHeight = double.infinity,
  }) async {
    var tokens = context.read<ExpenseThemeManager>();
    var globalTokens = tokens.globals;
    var aliasTokens = tokens.alias;

    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      useRootNavigator: true,
      barrierColor: aliasTokens.mixin.overlayDefault,
      isScrollControlled: true,
      builder: (BuildContext context) {
        double minH = 320;
        double maxH = maxHeight < minH ? minH : maxHeight;

        return _BodyCustom(
          child: Wrap(
            children: [
              SingleChildScrollView(
                child: Container(
                  constraints: BoxConstraints(
                    minHeight: minH,
                    maxHeight: maxH,
                  ),
                  child: Column(
                    mainAxisAlignment: mainAxisAlignment,
                    crossAxisAlignment: crossAxisAlignment,
                    children: [
                      const _LineDrawer(),
                      SizedBox(height: globalTokens.shapes.spacing.s3x),
                      ...children,
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
