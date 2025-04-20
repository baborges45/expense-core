// ignore_for_file: unused_element, unused_element_parameter

part of '../currency.dart';

class _ExpenseCurrencySale extends StatelessWidget {
  final String price;
  final String priceOut;
  final TextStyle defaultStyle;
  final bool hide;

  const _ExpenseCurrencySale({
    super.key,
    required this.price,
    required this.priceOut,
    required this.defaultStyle,
    required this.hide,
  });

  @override
  Widget build(BuildContext context) {
    var tokens = Provider.of<ExpenseThemeManager>(context);
    var globalTokens = tokens.globals;
    var aliasTokens = tokens.alias;

    String priceShowValidation = hide ? 'R\$' : 'R\$$price';

    Widget priceText = Text(
      priceShowValidation,
      style: defaultStyle.merge(TextStyle(
        color: aliasTokens.color.text.labelColor,
      )),
    );

    Widget priceOutText = Text(
      'R\$$priceOut',
      style: defaultStyle.merge(
        TextStyle(
          color: aliasTokens.color.negative.labelColor,
          fontSize: globalTokens.typographys.fontSize3xs,
          decoration: TextDecoration.lineThrough,
        ),
      ),
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        hide ? const SizedBox.shrink() : priceOutText,
        SizedBox(height: globalTokens.shapes.spacing.half),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            priceText,
            _ExpenseHideDot(
              price: price,
              hide: hide,
            ),
          ],
        ),
      ],
    );
  }
}
