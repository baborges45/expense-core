part of '../promotion_page.dart';

class _ButtonClose extends StatelessWidget {
  const _ButtonClose();

  @override
  Widget build(BuildContext context) {
    var globalTokens = Provider.of<MudeThemeManager>(context).globals;
    var spacing = globalTokens.shapes.spacing;

    return Padding(
      padding: EdgeInsets.only(
        right: spacing.s3x,
        top: spacing.s6x,
      ),
      child: Align(
        alignment: Alignment.topRight,
        child: MudeButtonIcon(
          key: const Key('promotion-page.button-close'),
          icon: MudeIcons.closeLine,
          onPressed: () {
            Navigator.pop(context);
          },
          semanticsLabel: 'Botão de fechar',
        ),
      ),
    );
  }
}
