part of '../currency.dart';

class _MudeCurrencyIncome extends StatelessWidget {
  final String price;
  final TextStyle defaultStyle;
  final bool hide;
  final MudeIconSize iconSize;

  const _MudeCurrencyIncome({
    required this.price,
    required this.defaultStyle,
    required this.hide,
    required this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    var tokens = Provider.of<MudeThemeManager>(context);
    var globalTokens = tokens.globals;
    var aliasTokens = tokens.alias;
    var positiveColor = aliasTokens.color.positive;

    String priceShowValidation = hide ? 'R\$' : 'R\$$price';

    Widget priceText = Text(
      priceShowValidation,
      style: defaultStyle.merge(TextStyle(
        color: positiveColor.labelColor,
      )),
    );

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ExcludeSemantics(
          excluding: true,
          child: MudeIcon(
            icon: MudeIcons.upLine,
            size: iconSize,
            color: positiveColor.iconColor,
          ),
        ),
        SizedBox(width: globalTokens.shapes.spacing.half),
        priceText,
        _MudeHideDot(
          price: price,
          hide: hide,
          color: positiveColor.labelColor,
        ),
      ],
    );
  }
}
