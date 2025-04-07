import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mude_core/core.dart';
import 'package:provider/provider.dart';

part 'widgets/_currency_income.dart';
part 'widgets/_currency_outcome.dart';
part 'widgets/_currency_sale.dart';
part 'widgets/_currency_text.dart';
part 'widgets/_hide_dot.dart';

class MudeCurrency extends StatelessWidget {
  /// A doule value that will be displayed as the price.
  final double price;

  /// A doule value that represents the discount.
  /// It only will be displayed on [MudeCurrencyType.sale] type.
  /// The default value is 0.0
  final double priceOut;

  /// A [MudeCurrencyType] that represents the type of the widget.
  /// it can be currency, sale, income, or outcome.
  /// The default value is [MudeCurrencyType.currency].
  final MudeCurrencyType type;

  /// A [MudeCurrencySize] enum that represents how big should be the widget.
  /// The default value is [MudeCurrencySize.sm].
  final MudeCurrencySize size;

  /// Define if value is hide, this field is true or false.
  /// If you don't he will assume false.
  final bool hide;

  ///A string value that provides a descriptive label for accessibility purposes.
  ///The default value is null
  final String? semanticsLabel;

  ///A string value that indicates additional accessibility information.
  ///The default value is null
  final String? semanticsHint;

  ///A boolean value that determines whether to ignore automatic accessibility settings for the widget.
  ///The default value is false
  final bool excludeSemantics;

  const MudeCurrency({
    super.key,
    required this.price,
    this.size = MudeCurrencySize.sm,
    this.type = MudeCurrencyType.currency,
    this.priceOut = 0.0,
    this.hide = false,
    this.semanticsLabel,
    this.semanticsHint,
    this.excludeSemantics = false,
  });

  @override
  Widget build(BuildContext context) {
    var tokens = Provider.of<MudeThemeManager>(context);
    var aliasTokens = tokens.alias;

    final formatCurrency = NumberFormat("#,##0.00", "pt_BR");

    String newPrice = formatCurrency.format(price);
    String newPriceOut = formatCurrency.format(priceOut);

    TextStyle getTextStyle() {
      switch (size) {
        case MudeCurrencySize.sm:
          return aliasTokens.mixin.labelMd2;
        case MudeCurrencySize.lg:
          return aliasTokens.mixin.labelLg2;
      }
    }

    MudeIconSize getIconSize() {
      switch (size) {
        case MudeCurrencySize.sm:
          return MudeIconSize.sm;
        case MudeCurrencySize.lg:
          return MudeIconSize.lg;
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
      case MudeCurrencyType.income:
        return getSemantic(
          _MudeCurrencyIncome(
            price: newPrice,
            defaultStyle: defaultStyle,
            hide: hide,
            iconSize: getIconSize(),
          ),
        );

      case MudeCurrencyType.outcome:
        return getSemantic(
          _MudeCurrencyOutcome(
            price: newPrice,
            defaultStyle: defaultStyle,
            hide: hide,
            iconSize: getIconSize(),
          ),
        );

      case MudeCurrencyType.sale:
        return getSemantic(
          _MudeCurrencySale(
            price: newPrice,
            priceOut: newPriceOut,
            defaultStyle: defaultStyle,
            hide: hide,
          ),
        );

      default:
        return getSemantic(
          _MudePriceText(
            price: newPrice,
            defaultStyle: defaultStyle,
            hide: hide,
          ),
        );
    }
  }
}
