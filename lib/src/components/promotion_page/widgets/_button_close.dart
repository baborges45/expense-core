part of '../promotion_page.dart';

class _ButtonClose extends StatelessWidget {
  const _ButtonClose();

  @override
  Widget build(BuildContext context) {
    var globalTokens = Provider.of<ExpenseThemeManager>(context).globals;
    var spacing = globalTokens.shapes.spacing;

    return Padding(
      padding: EdgeInsets.only(
        right: spacing.s3x,
        top: spacing.s6x,
      ),
      child: Align(
        alignment: Alignment.topRight,
        child: ExpenseButtonIcon(
          key: const Key('promotion-page.button-close'),
          icon: ExpenseIcons.closeLine,
          onPressed: () {
            Navigator.pop(context);
          },
          semanticsLabel: 'Botão de fechar',
        ),
      ),
    );
  }
}
