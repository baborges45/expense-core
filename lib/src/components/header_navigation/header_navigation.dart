import 'package:flutter/material.dart';
import 'package:expense_core/core.dart';
import 'package:expense_core/src/utils/check_url_is_valid.dart';
import 'package:provider/provider.dart';

part 'widgets/_header.dart';
part 'widgets/_header_animation.dart';
part 'widgets/_header_image.dart';
part 'widgets/_subtitle.dart';

class ExpenseHeaderNavigation extends StatelessWidget {
  ///(Optional) A string representing the title of the header.
  final String? title;

  ///A required VoidCallback that will be called when the back button is pressed.
  final VoidCallback onBack;

  ///(Optional) A string representing the subtitle of the header.
  final String? subtitle;

  ///(Optional) A string representing the description of the header.
  final String? description;

  ///A [List] of [ExpenseButtonIcon] objects representing the trailing buttons to be displayed in the header.
  final List<ExpenseButtonIcon>? trailingButtons;

  ///A [ExpenseHeaderNavigationType] object representing the type of the header,
  ///such as compact or jumbo.
  final ExpenseHeaderNavigationType type;

  ///A string value that provides a descriptive label for accessibility purposes.
  ///The default value is null
  final String? semanticsHeaderLabel;

  ///A string value that provides a descriptive subtitle for accessibility purposes.
  ///The default value is null
  final String? semanticsSubtitleLabel;

  ///A string value that indicates additional accessibility information.
  ///The default value is null
  final String? semanticsHeaderHint;

  ///A string value that indicates additional accessibility information.
  ///The default value is null in button back
  final String? semanticsButtonBackLabel;

  /// Set a local or web path to load an image
  final String? source;

  /// Set a new [Widget] to displayed in the type image.
  final Widget? tag;

  ///A string value that provides a descriptive label for the heading text in the type image
  final String? headingText;

  ///A [Widget] object representing the child widget to be displayed in the header.
  final Widget? child;

  /// Set the heroTag value
  final String? heroTag;

  const ExpenseHeaderNavigation({
    super.key,
    this.title,
    required this.onBack,
    this.subtitle,
    this.description,
    this.trailingButtons,
    this.type = ExpenseHeaderNavigationType.compact,
    this.semanticsHeaderLabel,
    this.semanticsSubtitleLabel,
    this.semanticsHeaderHint,
    this.semanticsButtonBackLabel,
    this.source,
    this.tag,
    this.headingText,
    this.child,
    this.heroTag,
  });

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double dynamicHeight = screenHeight * 0.6;

    var aliasTokens = Provider.of<ExpenseThemeManager>(context).alias;

    Widget getImage(String source) {
      var sourceLoad = urlIsvalid(source) ? ExpenseImage.network : ExpenseImage.asset;

      return Hero(
        tag: heroTag ?? UniqueKey(),
        child: sourceLoad(
          source,
          fit: BoxFit.cover,
          width: double.maxFinite,
        ),
      );
    }

    return Semantics(
      explicitChildNodes: true,
      child: type == ExpenseHeaderNavigationType.image
          ? SizedBox(
              height: dynamicHeight,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: _ExpenseHeaderAnimation(
                      getImage(source ?? ''),
                    ),
                  ),
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: aliasTokens.mixin.overlayGradient,
                        ),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _ExpenseHeaderAnimation(
                        _ExpenseHeader(
                          title: title,
                          onBack: onBack,
                          trailingButtons: trailingButtons,
                          semanticsHeaderLabel: semanticsHeaderLabel,
                          semanticsButtonBackLabel: semanticsButtonBackLabel,
                        ),
                      ),
                      _ExpenseHeaderImage(
                        type: type,
                        source: source ?? '',
                        tag: tag,
                        headingText: headingText,
                        semanticsSubtitleLabel: semanticsSubtitleLabel,
                        child: child,
                      ),
                    ],
                  ),
                ],
              ),
            )
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _ExpenseHeader(
                  title: title,
                  onBack: onBack,
                  trailingButtons: trailingButtons,
                  semanticsHeaderLabel: semanticsHeaderLabel,
                  semanticsButtonBackLabel: semanticsButtonBackLabel,
                ),
                _ExpenseSubtitle(
                  subtitle: subtitle,
                  description: description,
                  type: type,
                  semanticsSubtitleLabel: semanticsSubtitleLabel,
                ),
              ],
            ),
    );
  }
}
