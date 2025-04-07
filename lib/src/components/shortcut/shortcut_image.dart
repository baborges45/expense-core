import 'package:flutter/material.dart';
import 'package:mude_core/core.dart';
import 'package:mude_core/src/utils/check_url_is_valid.dart';
import 'package:provider/provider.dart';

import 'mixins/properties_mixin.dart';

class MudeShortcutImage extends StatefulWidget {
  /// A String that represents the label of the shortcut.
  final String label;

  /// A String that represents the description of the shortcut.
  final String description;

  /// A [VoidCallback] that is called when the shortcut is pressed.
  final VoidCallback onPressed;

  ///A String that represents the source of the image for the shortcut.
  final String source;

  ///A [BoxFit] object that represents how the image should fit inside the container.
  final BoxFit fit;

  ///A boolean value that indicates whether the shortcut is disabled.
  ///The default value is false.
  final bool disabled;

  ///A string value that provides a descriptive label for accessibility purposes.
  ///The default value is null
  final String? semanticsLabel;

  ///A string value that indicates additional accessibility information.
  ///The default value is null
  final String? semanticsHint;

  const MudeShortcutImage({
    super.key,
    required this.label,
    required this.description,
    required this.onPressed,
    required this.source,
    this.fit = BoxFit.cover,
    this.disabled = false,
    this.semanticsLabel,
    this.semanticsHint,
  });

  @override
  State<MudeShortcutImage> createState() => _MudeShortcutImageState();
}

class _MudeShortcutImageState extends State<MudeShortcutImage> with PropertiesMixin {
  bool _isPressed = false;

  _onPressedDown(_) {
    if (widget.disabled) return null;
    setState(() => _isPressed = true);
  }

  _onPressedUp(_) {
    if (widget.disabled) return null;
    setState(() => _isPressed = false);
  }

  _onPressed() {
    if (widget.disabled) return null;

    return widget.onPressed();
  }

  @override
  Widget build(BuildContext context) {
    var tokens = Provider.of<MudeThemeManager>(context);
    var globalTokens = tokens.globals;
    var aliasTokens = tokens.alias;
    final spacing = globalTokens.shapes.spacing;
    final lineHeightSm = globalTokens.typographys.lineHeightSm;

    Color getTextColor() {
      return widget.disabled ? aliasTokens.color.disabled.labelColor : aliasTokens.color.text.labelColor;
    }

    Color getDescriptionColor() {
      return widget.disabled ? aliasTokens.color.disabled.descriptionColor : aliasTokens.color.text.descriptionColor;
    }

    final textStyle = aliasTokens.mixin.labelMd1.merge(
      TextStyle(
        height: lineHeightSm,
        letterSpacing: globalTokens.typographys.letterSpacingNegative,
      ),
    );

    return Semantics(
      button: true,
      enabled: !widget.disabled,
      label: widget.semanticsLabel,
      hint: widget.semanticsHint,
      excludeSemantics: widget.semanticsHint != null,
      child: AnimatedOpacity(
        duration: globalTokens.motions.durations.fast02,
        opacity: getOpacity(widget.disabled, _isPressed, context),
        child: GestureDetector(
          onTap: _onPressed,
          onTapDown: _onPressedDown,
          onTapUp: _onPressedUp,
          onTapCancel: () => _onPressedUp(null),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                constraints: BoxConstraints(
                  maxWidth: globalTokens.shapes.size.s15x,
                ),
                color: Colors.transparent,
                child: Column(
                  children: [
                    _ShortcutIconContainer(
                      source: widget.source,
                      fit: widget.fit,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: spacing.s2x,
                      ),
                      child: Text(
                        widget.label,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: textStyle.merge(
                          TextStyle(
                            fontWeight: globalTokens.typographys.fontWeightMedium,
                            color: getTextColor(),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: spacing.s1x,
                      ),
                      child: Text(
                        widget.description,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        style: textStyle.merge(
                          TextStyle(
                            color: getDescriptionColor(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ShortcutIconContainer extends StatelessWidget {
  final String source;
  final BoxFit fit;

  const _ShortcutIconContainer({
    required this.source,
    required this.fit,
  });

  @override
  Widget build(BuildContext context) {
    var tokens = Provider.of<MudeThemeManager>(context);
    var globalTokens = tokens.globals;
    var aliasTokens = tokens.alias;
    var size = globalTokens.shapes.size;

    Widget getImage() {
      bool isValid = urlIsvalid(source);
      var sourceLoad = isValid ? MudeImage.network : MudeImage.asset;

      return ClipRRect(
        borderRadius: BorderRadius.circular(
          globalTokens.shapes.border.radiusCircular,
        ),
        child: sourceLoad(
          source,
          width: size.s15x,
          fit: fit,
        ),
      );
    }

    return Container(
      width: size.s15x,
      height: size.s15x,
      decoration: BoxDecoration(
        color: aliasTokens.color.elements.bgColor02,
        borderRadius: BorderRadius.circular(
          globalTokens.shapes.border.radiusCircular,
        ),
      ),
      child: Center(
        child: getImage(),
      ),
    );
  }
}
