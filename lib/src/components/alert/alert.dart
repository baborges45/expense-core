import 'dart:async';

import 'package:flutter/material.dart';
import 'package:expense_core/core.dart';
import 'package:provider/provider.dart';

import './mixins/properties_mixin.dart';
import './widgets/alert_description.dart';

class ExpenseAlert extends StatefulWidget {
  ///A string that represents the text inside the alert.
  final String message;

  ///A value of type [ExpenseAlertType] indicating the type of alert (informative, positive, negative, etc.).
  final ExpenseAlertType type;

  ///(Optional) An object of type [AlertHyperLink] that represents a hyperlink in the widget.
  ///It will be displayed in the end of the text.
  final AlertHyperLink? hyperlink;

  ///A boolean indicating whether the alert is open or not.
  final bool open;

  ///(Optional) A VoidCallback callback triggered when the alert is closed.
  final VoidCallback? onClose;

  ///A string value that provides a descriptive label for accessibility purposes.
  ///The default value is null
  final String? semanticsLabel;

  ///A string value that indicates additional accessibility information.
  ///The default value is null
  final String? semanticsHint;

  const ExpenseAlert({
    super.key,
    required this.message,
    this.type = ExpenseAlertType.informative,
    this.open = true,
    this.hyperlink,
    this.onClose,
    this.semanticsLabel,
    this.semanticsHint,
  });

  @override
  State<ExpenseAlert> createState() => ExpenseAlertState();
}

class ExpenseAlertState extends State<ExpenseAlert> with PropertiesMixin {
  late double _height;
  late Timer _timer;

  @override
  void initState() {
    super.initState();

    _openAlert();
  }

  _openAlert() {
    var globalTokens = context.read<ExpenseThemeManager>().globals;
    setState(() => _height = 0);

    _timer = Timer(const Duration(milliseconds: 1), () {
      double size = widget.open ? globalTokens.shapes.size.s10x : 0;
      setState(() => _height = size);
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var tokens = Provider.of<ExpenseThemeManager>(context);
    var globalTokens = tokens.globals;
    var aliasTokens = tokens.alias;
    var spacing = globalTokens.shapes.spacing;

    Color backgroundColor = getBackgroundColor(
      context: context,
      alertColor: widget.type,
    );

    Color iconColor = getIconColor(
      context: context,
      alertColor: widget.type,
    );

    ExpenseIcon getExpenseIcon() {
      switch (widget.type) {
        case ExpenseAlertType.positive:
          return ExpenseIcon(
            icon: ExpenseIcons.positiveLine,
            color: iconColor,
          );

        case ExpenseAlertType.negative:
          return ExpenseIcon(
            icon: ExpenseIcons.negativeLine,
            color: iconColor,
          );

        case ExpenseAlertType.informative:
          return ExpenseIcon(
            icon: ExpenseIcons.informationLine,
            color: iconColor,
          );

        case ExpenseAlertType.warning:
          return ExpenseIcon(
            icon: ExpenseIcons.warningLine,
            color: iconColor,
          );

        case ExpenseAlertType.promote:
          return ExpenseIcon(
            icon: ExpenseIcons.promoteLine,
            color: iconColor,
          );
      }
    }

    void onCloseAlert() {
      setState(() => _height = 0);

      if (widget.onClose != null) {
        widget.onClose!();
      }
    }

    String getSemanticsLabel() {
      final labelSemantics = widget.semanticsLabel ?? widget.message;

      switch (widget.type) {
        case ExpenseAlertType.positive:
          return 'positivo: $labelSemantics';
        case ExpenseAlertType.negative:
          return 'negativo: $labelSemantics';
        case ExpenseAlertType.informative:
          return 'informativo: $labelSemantics';
        case ExpenseAlertType.warning:
          return 'atenção: $labelSemantics';
        case ExpenseAlertType.promote:
          return 'promoção: $labelSemantics';
      }
    }

    final semanticLabel = getSemanticsLabel();

    return AnimatedContainer(
      duration: globalTokens.motions.durations.moderate02,
      curve: globalTokens.motions.curves.produtiveExit,
      color: backgroundColor,
      width: MediaQuery.of(context).size.width,
      height: _height,
      padding: EdgeInsets.only(
        left: spacing.s3x,
        right: spacing.s1x,
      ),
      child: Row(
        children: [
          ExcludeSemantics(
            child: getExpenseIcon(),
          ),
          SizedBox(
            width: spacing.s1x,
          ),
          Expanded(
            child: Semantics(
              label: semanticLabel,
              hint: widget.semanticsHint,
              excludeSemantics: true,
              child: AlertDescription(
                description: widget.message,
                type: widget.type,
                hiperLink: widget.hyperlink,
              ),
            ),
          ),
          SizedBox(
            width: spacing.s1x,
          ),
          ExpenseButtonIcon(
            icon: ExpenseIcons.closeLine,
            iconColor: iconColor,
            onPressed: onCloseAlert,
            backgroundColor: aliasTokens.mixin.onPressedOutline,
            size: ExpenseButtonIconSize.sm,
            semanticsLabel: 'Fechar alert',
          ),
        ],
      ),
    );
  }
}
