// ignore_for_file: unused_element, unused_element_parameter

part of '../heading.dart';

class _ExpenseHeadingIcon extends StatelessWidget {
  final String category;

  final ExpenseIconSize iconSize;
  final ExpenseIconData icon;
  final Color iconColor;

  const _ExpenseHeadingIcon({
    super.key,
    required this.category,
    required this.iconSize,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ExcludeSemantics(
          excluding: true,
          child: ExpenseIcon(
            icon: icon,
            size: iconSize,
            color: iconColor,
          ),
        ),
      ],
    );
  }
}
