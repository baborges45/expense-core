part of '../header_flow_compact.dart';

class _Header extends StatelessWidget {
  final String title;
  final String? description;
  final int totalStep;
  final int currentStep;
  final bool show;
  final VoidCallback? onBack;
  final VoidCallback? onClose;
  final String? semanticsButtonBackHint;
  final String? semanticsButtonCloseHint;

  const _Header({
    required this.title,
    required this.description,
    required this.totalStep,
    required this.currentStep,
    required this.show,
    this.onBack,
    this.onClose,
    this.semanticsButtonBackHint,
    this.semanticsButtonCloseHint,
  });

  @override
  Widget build(BuildContext context) {
    var tokens = Provider.of<ExpenseThemeManager>(context);
    var globalTokens = tokens.globals;
    var aliasTokens = tokens.alias;

    Widget getOnBack() {
      if (onBack == null) return const SizedBox(width: 48);

      return ExpenseButtonIcon(
        icon: ExpenseIcons.backLine,
        onPressed: onBack!,
        semanticsHint: semanticsButtonBackHint ?? 'Voltar',
      );
    }

    Widget getOnClose() {
      if (onClose == null) return const SizedBox(width: 48);

      return ExpenseButtonIcon(
        icon: ExpenseIcons.closeLine,
        onPressed: onClose!,
        semanticsHint: semanticsButtonCloseHint ?? 'Fechar',
      );
    }

    final shapes = globalTokens.shapes;

    return Container(
      height: shapes.size.s10x,
      color: aliasTokens.color.elements.bgColor01,
      padding: EdgeInsets.symmetric(
        horizontal: shapes.spacing.s1x,
      ),
      child: Row(
        children: [
          getOnBack(),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ExpenseHeading(title, size: ExpenseHeadingSize.xs),
                if (description != null && description!.isNotEmpty) ...[
                  SizedBox(height: shapes.spacing.half),
                  ExpenseDescription(description!),
                ],
              ],
            ),
          ),
          getOnClose(),
        ],
      ),
    );
  }
}
