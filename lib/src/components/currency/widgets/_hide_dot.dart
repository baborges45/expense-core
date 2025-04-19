// ignore_for_file: unused_element

part of '../currency.dart';

class _ExpenseHideDot extends StatelessWidget {
  final String price;
  final bool hide;
  final Color? color;

  const _ExpenseHideDot({
    required this.price,
    required this.hide,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    var tokens = Provider.of<ExpenseThemeManager>(context);
    var globalTokens = tokens.globals;
    var aliasTokens = tokens.alias;
    var size = globalTokens.shapes.size;

    List<String> numbersHideDots = price.replaceAll('', '').split('');

    Widget dots = Padding(
      padding: EdgeInsets.only(left: globalTokens.shapes.spacing.half),
      child: Container(
        key: const Key('currency-dot'),
        width: size.half,
        height: size.half,
        decoration: BoxDecoration(
          color: color ?? aliasTokens.color.text.labelColor,
          borderRadius: BorderRadius.circular(
            globalTokens.shapes.border.radiusCircular,
          ),
        ),
      ),
    );

    return hide ? Row(children: [...numbersHideDots.map((e) => dots)]) : const SizedBox.shrink();
  }
}
