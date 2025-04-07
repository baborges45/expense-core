// ignore_for_file: unused_element

part of '../header_flow_jumbo.dart';

class _Header extends StatelessWidget {
  final bool showProgress;
  final int totalStep;
  final int currentStep;
  final VoidCallback? onClose;
  final VoidCallback? onBack;
  final String? semanticsButtonBackHint;
  final String? semanticsButtonCloseHint;

  const _Header({
    required this.showProgress,
    required this.totalStep,
    required this.currentStep,
    this.onClose,
    this.onBack,
    this.semanticsButtonBackHint,
    this.semanticsButtonCloseHint,
  });

  @override
  Widget build(BuildContext context) {
    var globalTokens = Provider.of<MudeThemeManager>(context).globals;
    var spacing = globalTokens.shapes.spacing;

    Widget getButtonBack() {
      if (onBack == null) {
        return const ExcludeSemantics(
          child: SizedBox(width: 48),
        );
      }

      return MudeButtonIcon(
        key: const Key('header-flow-jumbo.button-back'),
        icon: MudeIcons.backLine,
        size: MudeButtonIconSize.lg,
        onPressed: onBack!,
        semanticsHint: semanticsButtonBackHint ?? 'Voltar',
      );
    }

    Widget getButtonClose() {
      if (onClose == null) {
        return const ExcludeSemantics(
          child: SizedBox(width: 48),
        );
      }

      return MudeButtonIcon(
        icon: MudeIcons.closeLine,
        size: MudeButtonIconSize.lg,
        onPressed: onClose!,
        semanticsLabel: semanticsButtonCloseHint ?? 'Fechar',
      );
    }

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: spacing.s1x,
      ),
      height: globalTokens.shapes.size.s11x,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          getButtonBack(),
          getButtonClose(),
        ],
      ),
    );
  }
}
