import 'dart:async';
import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mude_core/core.dart';
import 'package:provider/provider.dart';

import '../mixins/properties_mixin.dart';

class MudeToastWidget extends StatefulWidget {
  final String message;
  final MudeToastType? type;
  final MudeToastColor color;
  final String? semanticsHint;

  const MudeToastWidget({
    super.key,
    required this.message,
    required this.color,
    required this.type,
    this.semanticsHint,
  });

  @override
  State<MudeToastWidget> createState() => _MudeToastWidgetState();
}

class _MudeToastWidgetState extends State<MudeToastWidget>
    with PropertiesMixin {
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
    var tokens = Provider.of<MudeThemeManager>(context);
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
      return MudeIcon(
        icon: widget.type == MudeToastType.negative
            ? MudeIcons.negativeLine
            : MudeIcons.positiveLine,
        color: iconColor,
        size: MudeIconSize.lg,
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
                child: MudeDescription(
                  widget.message,
                  color: fontColor,
                ),
              ),
              SizedBox(
                width: spacing.s1x,
              ),
              MudeIcon(
                icon: MudeIcons.closeLine,
                color: iconColor,
                size: MudeIconSize.sm,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
