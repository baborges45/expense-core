import 'package:flutter/material.dart';
import 'package:expense_core/core.dart';
import 'package:expense_core/src/components/avatar/widgets/avatar_container_widget.dart';
import 'package:provider/provider.dart';

part 'widgets/avatar.dart';
part 'widgets/icon.dart';

class ExpenseAvatarGroup extends StatelessWidget {
  /// List of image urls
  final List<String> imageList;

  /// Maximum number of visible avatars
  final int maxVisible;

  /// Size of the avatar group
  final ExpenseAvatarGroupSize size;

  /// Whether to show the description
  final bool isDescription;

  /// Color of the description
  final Color? descriptionColor;

  /// Description text
  final String? description;

  const ExpenseAvatarGroup({
    super.key,
    required this.imageList,
    this.maxVisible = 4,
    this.size = ExpenseAvatarGroupSize.sm,
    this.isDescription = false,
    this.descriptionColor,
    this.description,
  });

  @override
  Widget build(BuildContext context) {
    int extraCount = imageList.length - maxVisible;
    bool showExtra = extraCount > 0;
    final showCount = extraCount > 0 ? maxVisible : imageList.length;
    var tokens = Provider.of<ExpenseThemeManager>(context);
    var aliasTokens = tokens.alias;
    var globalTokens = tokens.globals;

    ExpenseAvatarSize getSpaceAvatar() {
      switch (size) {
        case ExpenseAvatarGroupSize.sm:
          return ExpenseAvatarSize.sm;
        case ExpenseAvatarGroupSize.lg:
          return ExpenseAvatarSize.lg;
      }
    }

    final sizes = tokens.globals.shapes.size;
    final border = globalTokens.shapes.border;

    double getBorder() {
      switch (size) {
        case ExpenseAvatarGroupSize.sm:
          return border.widthXs;

        case ExpenseAvatarGroupSize.lg:
          return border.widthSm;
      }
    }

    double getSizeAvatar() {
      switch (size) {
        case ExpenseAvatarGroupSize.sm:
          return sizes.s3x + 2 * getBorder();

        case ExpenseAvatarGroupSize.lg:
          return sizes.s12x + 2 * getBorder();
      }
    }

    double getSize() {
      return size == ExpenseAvatarGroupSize.sm && !isDescription ? sizes.s12x : MediaQuery.of(context).size.width;
    }

    double getSizeGap() {
      switch (size) {
        case ExpenseAvatarGroupSize.sm:
          return sizes.half;

        case ExpenseAvatarGroupSize.lg:
          return sizes.s4x;
      }
    }

    return SizedBox(
      width: getSize(),
      height: getSizeAvatar(),
      child: Stack(
        children: List.generate(
          showExtra ? maxVisible : imageList.length,
          (index) => Positioned(
            left: (index * getSizeAvatar()) - (index * getSizeGap()),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: aliasTokens.color.elements.borderColor,
                  width: getBorder(),
                ),
              ),
              child: _AvatarIcon(
                icon: ExpenseIcons.placeholderLine,
                size: getSpaceAvatar(),
                showNotification: false,
                inverse: false,
                source: imageList[index],
                sourceLoad: ExpenseAvatarSourceLoad.network,
              ),
            ),
          ),
        )..add(
            showExtra && size != ExpenseAvatarGroupSize.sm
                ? Positioned(
                    left: (showCount * getSizeAvatar()) - (showCount * getSizeGap()),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: aliasTokens.color.elements.borderColor,
                          width: border.widthSm,
                        ),
                      ),
                      child: Container(
                        height: sizes.s12x,
                        width: sizes.s12x,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: aliasTokens.color.elements.bgColor02,
                        ),
                        child: Center(
                          child: Text(
                            '+$extraCount',
                            style: aliasTokens.mixin.labelSm2.copyWith(
                              color: globalTokens.colors.grey300,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                : Visibility(
                    visible: isDescription,
                    child: Positioned(
                      left: (showCount * getSizeAvatar()) + sizes.s2x - (showCount * getSizeGap()),
                      top: (getSizeAvatar() / 2) - (tokens.globals.typographys.fontSize2xs / 2),
                      child: ExpenseDescription(
                        description ?? '',
                        color: descriptionColor,
                      ),
                    ),
                  ),
          ),
      ),
    );
  }
}
