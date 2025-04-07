// ignore_for_file: unused_element

part of '../currency.dart';

class _MudePriceText extends StatelessWidget {
  final String price;
  final TextStyle defaultStyle;
  final bool hide;

  const _MudePriceText({
    required this.price,
    required this.defaultStyle,
    required this.hide,
  });

  @override
  Widget build(BuildContext context) {
    var tokens = Provider.of<MudeThemeManager>(context);
    var aliasTokens = tokens.alias;

    String priceShowValidation = hide ? 'R\$' : 'R\$$price';

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          priceShowValidation,
          style: defaultStyle.merge(TextStyle(
            color: aliasTokens.color.text.labelColor,
          )),
        ),
        _MudeHideDot(
          price: price,
          hide: hide,
        ),
      ],
    );
  }
}
