import 'dart:async';
import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:expense_core/core.dart';
import 'package:provider/provider.dart';

import '../mixins/properties_mixin.dart';

class ExpenseToastWidget extends StatefulWidget {
  final String message;
  final ExpenseToastType? type;
  final ExpenseToastColor color;
  final String? semanticsHint;

  const ExpenseToastWidget({
    super.key,
    required this.message,
    required this.color,
    required this.type,
    this.semanticsHint,
  });

  @override
  State<ExpenseToastWidget> createState() => _ExpenseToastWidgetState();
}

class _ExpenseToastWidgetState extends State<ExpenseToastWidget> with PropertiesMixin {
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      _timer = Timer(const Duration(milliseconds: 100), () {
        SemanticsService.announce(
          widget.semanticsHint ?? widget.message,
          TextDirection.ltr,
        );
      });
    }
  }

  @override
  void dispose() {
    if (Platform.isAndroid) {
      _timer.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var tokens = Provider.of<ExpenseThemeManager>(context);
    var globalTokens = tokens.globals;
    var aliasTokens = tokens.alias;
    var spacing = globalTokens.shapes.spacing;

    Color bgColor = getBackgroundColor(
      context: context,
      toastColor: widget.color,
    );

    Color fontColor = getFontColor(
      context: context,
      toastColor: widget.color,
    );

    Color iconColor = getIconColor(
      context: context,
      toastColor: widget.color,
    );

    getIcon() {
      return ExpenseIcon(
        icon: widget.type == ExpenseToastType.negative ? ExpenseIcons.negativeLine : ExpenseIcons.positiveLine,
        color: iconColor,
        size: ExpenseIconSize.lg,
      );
    }

    return Material(
      color: Colors.transparent,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Container(
          constraints: BoxConstraints(
            minHeight: globalTokens.shapes.size.s9x,
          ),
          margin: EdgeInsets.all(
            spacing.s3x,
          ),
          padding: EdgeInsets.symmetric(
            vertical: spacing.s1x,
            horizontal: spacing.s3x,
          ),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(
              aliasTokens.defaultt.borderRadius,
            ),
            boxShadow: globalTokens.shapes.shadow.level2,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              getIcon(),
              SizedBox(
                width: spacing.s1x,
              ),
              Expanded(
                child: ExpenseDescription(
                  widget.message,
                  color: fontColor,
                ),
              ),
              SizedBox(
                width: spacing.s1x,
              ),
              ExpenseIcon(
                icon: ExpenseIcons.closeLine,
                color: iconColor,
                size: ExpenseIconSize.sm,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
