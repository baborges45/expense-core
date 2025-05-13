// ignore_for_file: unused_element

part of '../currency.dart';

class _ExpensePriceText extends StatelessWidget {
  final String price;
  final TextStyle defaultStyle;
  final bool hide;
  final bool inverse;

  const _ExpensePriceText({
    required this.price,
    required this.defaultStyle,
    required this.hide,
    required this.inverse,
  });

  @override
  Widget build(BuildContext context) {
    var tokens = Provider.of<ExpenseThemeManager>(context);
    var aliasTokens = tokens.alias;

    String priceShowValidation = hide ? 'R\$' : 'R\$$price';

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          priceShowValidation,
          style: defaultStyle.merge(TextStyle(
            color: inverse ? aliasTokens.color.selected.onBgColor : aliasTokens.color.text.labelColor,
          )),
        ),
        _ExpenseHideDot(
          price: price,
          hide: hide,
        ),
      ],
    );
  }
}
