part of '../drawer.dart';

class _LineDrawer extends StatelessWidget {
  const _LineDrawer();

  @override
  Widget build(BuildContext context) {
    var tokens = Provider.of<MudeThemeManager>(context);
    var globalTokens = tokens.globals;
    var aliasTokens = tokens.alias;
    var border = globalTokens.shapes.border;

    return Container(
      alignment: Alignment.center,
      child: Container(
        height: border.widthMd,
        width: globalTokens.shapes.size.s5x,
        decoration: BoxDecoration(
          color: aliasTokens.color.elements.bgColor03,
          borderRadius: BorderRadius.circular(
            border.radiusCircular,
          ),
        ),
      ),
    );
  }
}
