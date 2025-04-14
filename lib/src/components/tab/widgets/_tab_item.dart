part of '../tab.dart';

class _TabItem extends StatelessWidget {
  final String label;
  final ExpenseIconData? icon;
  final bool actived;
  final bool isScrollable;
  final bool inverse;

  const _TabItem({
    required this.label,
    required this.actived,
    required this.isScrollable,
    required this.inverse,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    var tokens = Provider.of<ExpenseThemeManager>(context);
    var globalTokens = tokens.globals;
    var aliasTokens = tokens.alias;

    Widget getIcon() {
      if (icon == null) return const SizedBox.shrink();
      Color iconColor = aliasTokens.color.elements.iconColor;

      if (inverse) {
        iconColor = aliasTokens.color.inverse.onLabelColor;
      } else if (actived) {
        iconColor = aliasTokens.color.selected.labelColor;
      }

      return Padding(
        padding: EdgeInsets.only(right: globalTokens.shapes.spacing.half),
        child: ExpenseIcon(
          icon: icon!,
          size: ExpenseIconSize.sm,
          color: iconColor,
        ),
      );
    }

    double getTabHeight() {
      return globalTokens.shapes.size.s6x - globalTokens.shapes.border.widthMd;
    }

    TextStyle getTextStyle(bool active) {
      return active ? aliasTokens.mixin.labelMd2 : aliasTokens.mixin.labelMd1;
    }

    Color getTextColor() {
      if (inverse) {
        return aliasTokens.color.inverse.labelColor;
      }

      return actived ? aliasTokens.color.selected.labelColor : aliasTokens.color.text.labelColor;
    }

    return Tab(
      height: getTabHeight(),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          getIcon(),
          Text(
            label,
            style: getTextStyle(actived).merge(TextStyle(
              color: getTextColor(),
            )),
          ),
        ],
      ),
    );
  }
}
