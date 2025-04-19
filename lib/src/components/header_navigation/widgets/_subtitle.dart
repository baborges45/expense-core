part of '../header_navigation.dart';

class _ExpenseSubtitle extends StatelessWidget {
  final String? subtitle;
  final String? description;
  final ExpenseHeaderNavigationType type;
  final String? semanticsSubtitleLabel;

  const _ExpenseSubtitle({
    required this.subtitle,
    required this.description,
    required this.type,
    this.semanticsSubtitleLabel,
  });

  @override
  Widget build(BuildContext context) {
    var tokens = Provider.of<ExpenseThemeManager>(context);
    var globalTokens = tokens.globals;
    var aliasTokens = tokens.alias;

    if (type == ExpenseHeaderNavigationType.compact || type == ExpenseHeaderNavigationType.image || subtitle == null) {
      return const SizedBox.shrink();
    }

    Widget getDescription() {
      if (description == null) {
        return const SizedBox.shrink();
      }

      return Padding(
        padding: EdgeInsets.only(top: globalTokens.shapes.spacing.s1x),
        child: ExpenseDescription(
          description!,
          semanticsLabel: description!,
        ),
      );
    }

    Widget getSubtitle() {
      if (subtitle == null) {
        return const SizedBox.shrink();
      }

      return ExpenseHeading(
        subtitle!,
        semanticsLabel: semanticsSubtitleLabel,
        size: ExpenseHeadingSize.lg,
      );
    }

    final s3x = globalTokens.shapes.spacing.s3x;

    return Container(
      color: aliasTokens.color.elements.bgColor01,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(
              s3x,
              0,
              s3x,
              globalTokens.shapes.spacing.s2x,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [getSubtitle(), getDescription()],
            ),
          ),
        ],
      ),
    );
  }
}
