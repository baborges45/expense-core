import 'package:flutter/material.dart';
import 'package:mude_core/core.dart';
import 'package:provider/provider.dart';

class MudeAccordionJourney extends StatefulWidget {
  /// A [Widget] that will be the expanded child.
  final Widget child;

  /// A [Widget] that will be the trailing widget.
  final Widget trailing;

  // The text value of the tag
  final String tag;

  // The text value of the title
  final String title;

  // The text value of the description
  final String description;

  // The text value of the expanded paragraph
  final String paragraph;

  // The text value of the description
  final MudeIconData? leadingIcon;

  ///A string value that provides a descriptive label for accessibility purposes.
  ///The default value is null
  final String? semanticsLabel;

  ///A string value that indicates additional accessibility information.
  ///The default value is null
  final String? semanticsHint;

  const MudeAccordionJourney({
    super.key,
    required this.tag,
    this.semanticsLabel,
    this.semanticsHint,
    required this.child,
    required this.title,
    required this.description,
    this.leadingIcon,
    required this.trailing,
    required this.paragraph,
  });

  @override
  State<MudeAccordionJourney> createState() => _MudeAccordionJourneyState();
}

class _MudeAccordionJourneyState extends State<MudeAccordionJourney> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    var globalTokens = Provider.of<MudeThemeManager>(context).globals;
    var aliasTokens = Provider.of<MudeThemeManager>(context).alias;
    final curve = globalTokens.motions.curves;
    final spacing = globalTokens.shapes.spacing;

    return Semantics(
      expanded: expanded,
      label: widget.semanticsLabel,
      hint: widget.semanticsHint,
      excludeSemantics: widget.semanticsHint != null,
      child: AnimatedSize(
        alignment: Alignment.topCenter,
        duration: globalTokens.motions.durations.slow01,
        curve: expanded ? curve.produtiveExit : curve.productiveEntrance,
        clipBehavior: Clip.antiAlias,
        child: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(
            horizontal: spacing.s2x,
            vertical: spacing.s3x,
          ),
          decoration: BoxDecoration(
            color: aliasTokens.color.elements.bgColor02,
            borderRadius: BorderRadius.circular(
              aliasTokens.defaultt.borderRadius,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MudeTagContainer(widget.tag),
                  widget.trailing,
                ],
              ),
              SizedBox(
                height: spacing.s4x,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  if (widget.leadingIcon != null) ...[
                    MudeIcon(
                      icon: widget.leadingIcon!,
                    ),
                    SizedBox(
                      width: spacing.s2x,
                    ),
                  ],
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MudeParagraph(widget.title),
                        SizedBox(
                          height: spacing.s1x,
                        ),
                        MudeDescription(widget.description),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: spacing.s2x,
                  ),
                  MudeButtonIcon(
                    icon: expanded ? MudeIcons.dropdownCloseLine : MudeIcons.dropdownOpenLine,
                    onPressed: changeState,
                  ),
                ],
              ),
              if (expanded) ...[
                SizedBox(
                  height: spacing.s4x,
                ),
                MudeParagraph(
                  widget.paragraph,
                  size: MudeParagraphSize.sm,
                ),
                SizedBox(
                  height: spacing.s4x,
                ),
                widget.child,
              ],
            ],
          ),
        ),
      ),
    );
  }

  void changeState() {
    setState(() {
      expanded = !expanded;
    });
  }
}
