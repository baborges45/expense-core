import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart' show DateFormat;
import 'package:mude_core/core.dart';
import 'package:provider/provider.dart';

class Content extends StatelessWidget {
  final List<DateTime?> value;
  final bool disabled;
  final bool hasError;
  final VoidCallback onPressed;
  final BoxDecoration decoration;
  final Color textColor;
  final Color iconColor;
  final Color? labelColor;
  final String? label;
  final EdgeInsetsGeometry? padding;
  final MudeInputDateType type;

  const Content({
    super.key,
    required this.value,
    required this.disabled,
    required this.hasError,
    required this.onPressed,
    required this.decoration,
    required this.textColor,
    required this.iconColor,
    this.labelColor,
    this.label,
    this.padding,
    this.type = MudeInputDateType.single,
  });

  @override
  Widget build(BuildContext context) {
    final tokens = Provider.of<MudeThemeManager>(context);
    final globalTokens = tokens.globals;
    final aliasTokens = tokens.alias;

    final size = globalTokens.shapes.size;
    final spacing = globalTokens.shapes.spacing;

    Widget getValue() {
      if (label != null && value.isEmpty) {
        return const SizedBox.shrink();
      }

      String valueSelected = type == MudeInputDateType.single
          ? '00/00/0000'
          : '00/00/0000 - 00/00/0000';

      var dateFormatter = DateFormat('dd/MM/yyyy');

      if (type == MudeInputDateType.single && value.isNotEmpty) {
        valueSelected = dateFormatter.format(value[0]!);
      } else if (type == MudeInputDateType.range && value.isNotEmpty) {
        final initialDate = dateFormatter.format(value[0]!);
        final finalDate =
            value.length > 1 ? dateFormatter.format(value[1]!) : '00/00/0000';
        valueSelected = '$initialDate - $finalDate';
      }

      return Text(
        valueSelected,
        style: aliasTokens.mixin.placeholder.apply(
          color: textColor,
        ),
      );
    }

    Widget getLabel() {
      if (label == null) {
        return const SizedBox.shrink();
      }

      TextStyle mixinChoice = value.isEmpty
          ? aliasTokens.mixin.labelLg2
          : aliasTokens.mixin.labelSm2;

      double spacingLabel = value.isEmpty ? 0 : globalTokens.shapes.spacing.s1x;

      return Padding(
        padding: EdgeInsets.only(bottom: spacingLabel),
        child: Text(
          label!,
          style: mixinChoice.apply(
            color: labelColor,
          ),
        ),
      );
    }

    EdgeInsetsGeometry getPadding() {
      return padding ?? EdgeInsets.only(left: spacing.s2x);
    }

    return Container(
      key: const Key('input-date.container'),
      height: size.s8x,
      padding: getPadding(),
      decoration: decoration,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getLabel(),
              getValue(),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (hasError)
                MudeIcon(
                  icon: MudeIcons.negativeLine,
                  color: iconColor,
                ),
              MudeButtonIcon(
                icon: MudeIcons.calendarLine,
                onPressed: onPressed,
                iconColor: iconColor,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
