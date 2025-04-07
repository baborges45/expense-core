// ignore_for_file: unused_element

part of '../currency.dart';

class _MudeCurrencyOutcome extends StatelessWidget {
  final String price;
  final TextStyle defaultStyle;
  final bool hide;
  final MudeIconSize iconSize;

  const _MudeCurrencyOutcome({
    super.key,
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
    var negativeColor = aliasTokens.color.negative;

    String priceShowValidation = hide ? 'R\$' : 'R\$$price';

    Widget priceText = Text(
      priceShowValidation,
      style: defaultStyle.merge(TextStyle(
        color: negativeColor.labelColor,
      )),
    );

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ExcludeSemantics(
          excluding: true,
          child: MudeIcon(
            icon: MudeIcons.downLine,
            size: iconSize,
            color: negativeColor.labelColor,
          ),
        ),
        SizedBox(width: globalTokens.shapes.spacing.half),
        priceText,
        _MudeHideDot(
          price: price,
          hide: hide,
          color: negativeColor.iconColor,
        ),
      ],
    );
  }
}
