import 'package:flutter/material.dart';
import 'package:expense_core/core.dart';
import 'package:provider/provider.dart';

mixin PropertiesMixin {
  Color getIconColor(
    bool isFocussed,
    bool isFilled,
    BuildContext context,
  ) {
    var aliasTokens = Provider.of<ExpenseThemeManager>(context).alias;

    return isFocussed || isFilled ? aliasTokens.color.active.placeholderColor : aliasTokens.color.elements.iconColor;
  }

  Widget getSuffix({
    required bool isFocussed,
    required bool isFilled,
    required TextEditingController controller,
    required VoidCallback onClear,
    required bool noIconSearch,
    required BuildContext context,
  }) {
    if (isFocussed || isFilled || noIconSearch) {
      return ExpenseButtonIcon(
        semanticsLabel: 'Apagar',
        key: const Key('input-search.clear'),
        icon: ExpenseIcons.closeLine,
        onPressed: () {
          controller.text = '';
          onClear();
        },
        size: ExpenseButtonIconSize.sm,
      );
    }

    return SizedBox(
      width: 48,
      height: 48,
      child: Center(
        child: ExpenseIcon(
          icon: ExpenseIcons.searchLine,
          size: ExpenseIconSize.sm,
          color: getIconColor(isFocussed, isFilled, context),
        ),
      ),
    );
  }

  String getPlaceholderText({
    required String placeholder,
    required bool isFocussed,
    required bool noPlaceholderText,
  }) {
    return isFocussed || noPlaceholderText ? '' : placeholder;
  }

  Color getPlaceholderColor(
    bool isFocussed,
    BuildContext context,
  ) {
    var aliasTokens = Provider.of<ExpenseThemeManager>(context).alias;

    return isFocussed ? aliasTokens.color.active.placeholderColor : aliasTokens.color.text.placeholderColor;
  }
}
