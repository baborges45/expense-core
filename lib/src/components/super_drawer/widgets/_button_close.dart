part of '../super_drawer.dart';

class _ButtonClose extends StatelessWidget {
  final EdgeInsetsGeometry? padding;
  const _ButtonClose(this.padding);

  @override
  Widget build(BuildContext context) {
    final tokens = context.read<ExpenseThemeManager>();
    final globalTokens = tokens.globals;

    double getPosition() {
      return padding != null ? 12 : -12;
    }

    double position = getPosition();

    return Container(
      height: globalTokens.shapes.size.s6x,
      width: double.maxFinite,
      color: Colors.transparent,
      alignment: Alignment.centerRight,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            right: position,
            top: position,
            child: ExpenseButtonIcon(
              icon: ExpenseIcons.closeLine,
              onPressed: () => Navigator.pop(context),
              semanticsLabel: 'Fechar Drawer',
            ),
          ),
        ],
      ),
    );
  }
}
