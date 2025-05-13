import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:expense_core/core.dart';
import 'package:provider/provider.dart';

part 'widgets/_currency_income.dart';
part 'widgets/_currency_outcome.dart';
part 'widgets/_currency_sale.dart';
part 'widgets/_currency_text.dart';
part 'widgets/_hide_dot.dart';

class ExpenseCurrency extends StatelessWidget {
  /// A doule value that will be displayed as the price.
  final double price;

  /// A doule value that represents the discount.
  /// It only will be displayed on [ExpenseCurrencyType.sale] type.
  /// The default value is 0.0
  final double priceOut;

  /// A [ExpenseCurrencyType] that represents the type of the widget.
  /// it can be currency, sale, income, or outcome.
  /// The default value is [ExpenseCurrencyType.currency].
  final ExpenseCurrencyType type;

  /// A [ExpenseCurrencySize] enum that represents how big should be the widget.
  /// The default value is [ExpenseCurrencySize.sm].
  final ExpenseCurrencySize size;

  /// Define if value is hide, this field is true or false.
  /// If you don't he will assume false.
  final bool hide;

  /// A boolean parameter that specifies whether the link should have an inverse color scheme.
  /// The default value is false.
  final bool inverse;

  ///A string value that provides a descriptive label for accessibility purposes.
  ///The default value is null
  final String? semanticsLabel;

  ///A string value that indicates additional accessibility information.
  ///The default value is null
  final String? semanticsHint;

  ///A boolean value that determines whether to ignore automatic accessibility settings for the widget.
  ///The default value is false
  final bool excludeSemantics;

  const ExpenseCurrency({
    super.key,
    required this.price,
    this.size = ExpenseCurrencySize.sm,
    this.type = ExpenseCurrencyType.currency,
    this.priceOut = 0.0,
    this.hide = false,
    this.semanticsLabel,
    this.semanticsHint,
    this.excludeSemantics = false,
    this.inverse = false,
  });

  @override
  Widget build(BuildContext context) {
    var tokens = Provider.of<ExpenseThemeManager>(context);
    var aliasTokens = tokens.alias;

    final formatCurrency = NumberFormat("#,##0.00", "pt_BR");

    String newPrice = formatCurrency.format(price);
    String newPriceOut = formatCurrency.format(priceOut);

    TextStyle getTextStyle() {
      switch (size) {
        case ExpenseCurrencySize.sm:
          return aliasTokens.mixin.labelLg2;
        case ExpenseCurrencySize.md:
          return aliasTokens.mixin.labelLg4;
        case ExpenseCurrencySize.lg:
          return aliasTokens.mixin.labelLg5;
      }
    }

    ExpenseIconSize getIconSize() {
      switch (size) {
        case ExpenseCurrencySize.sm:
          return ExpenseIconSize.sm;
        case ExpenseCurrencySize.md:
          return ExpenseIconSize.lg;
        case ExpenseCurrencySize.lg:
          return ExpenseIconSize.lg;
      }
    }

    Semantics getSemantic(child) {
      return Semantics(
        label: semanticsLabel,
        hint: semanticsHint,
        excludeSemantics: excludeSemantics,
        child: child,
      );
    }

    TextStyle defaultStyle = getTextStyle();

    switch (type) {
      case ExpenseCurrencyType.income:
        return getSemantic(
          _ExpenseCurrencyIncome(
            price: newPrice,
            defaultStyle: defaultStyle,
            hide: hide,
            iconSize: getIconSize(),
          ),
        );

      case ExpenseCurrencyType.outcome:
        return getSemantic(
          _ExpenseCurrencyOutcome(
            price: newPrice,
            defaultStyle: defaultStyle,
            hide: hide,
            iconSize: getIconSize(),
          ),
        );

      case ExpenseCurrencyType.sale:
        return getSemantic(
          _ExpenseCurrencySale(
            price: newPrice,
            priceOut: newPriceOut,
            defaultStyle: defaultStyle,
            hide: hide,
          ),
        );

      default:
        return getSemantic(
          _ExpensePriceText(
            price: newPrice,
            defaultStyle: defaultStyle,
            hide: hide,
            inverse: inverse,
          ),
        );
    }
  }
}
