// ignore_for_file: unused_element

part of '../header_navigation.dart';

class _ExpenseHeader extends StatelessWidget {
  final String? title;
  final VoidCallback onBack;
  final List<ExpenseButtonIcon>? trailingButtons;
  final String? semanticsHeaderLabel;
  final String? semanticsButtonBackLabel;

  const _ExpenseHeader({
    required this.title,
    required this.onBack,
    this.trailingButtons,
    this.semanticsHeaderLabel,
    this.semanticsButtonBackLabel,
  });

  @override
  Widget build(BuildContext context) {
    var globalTokens = Provider.of<ExpenseThemeManager>(context).globals;

    Widget getButtons() {
      if (trailingButtons == null) {
        return const SizedBox(width: 24);
      }

      return Row(
        children: [
          ...trailingButtons!.map((button) {
            return Padding(
              padding: EdgeInsets.only(
                left: globalTokens.shapes.spacing.half,
              ),
              child: ExpenseButtonIcon(
                icon: button.icon,
                onPressed: button.onPressed,
                disabled: button.disabled,
                showNotification: button.showNotification,
                size: ExpenseButtonIconSize.lg,
                semanticsLabel: button.semanticsLabel,
                semanticsHint: button.semanticsHint,
              ),
            );
          }),
        ],
      );
    }

    double getSpacingHeading() {
      if (trailingButtons == null) return 0;

      double spacing = 0;
      for (var _ in trailingButtons!) {
        spacing = spacing + 24;
      }

      return spacing;
    }

    Widget getHeading() {
      if (title == null) {
        return const ExcludeSemantics(child: SizedBox.shrink());
      }

      return ExpenseHeading(
        title!,
        size: ExpenseHeadingSize.xs,
        semanticsLabel: semanticsHeaderLabel,
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: globalTokens.shapes.spacing.s1x,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: globalTokens.shapes.spacing.s9x,
          ),
          Row(
            children: [
              ExpenseButtonIcon(
                icon: ExpenseIcons.backLine,
                onPressed: onBack,
                semanticsLabel: semanticsButtonBackLabel ?? 'Voltar',
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: getSpacingHeading()),
                  child: Center(
                    child: getHeading(),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [getButtons()],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
