import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:mude_core/core.dart';
import 'package:provider/provider.dart';

part './widgets/bottom_bar_item_widget.dart';

class MudeBottomBarFloat extends StatefulWidget {
  /// A list of [MudeBottomBarFloatItem] objects to be displayed in the bottom bar.
  final List<MudeBottomBarFloatItem> items;

  /// A [ValueChanged] type int callback triggered when the tab index is changed.
  final ValueChanged<int> onChanged;

  /// An integer representing the current index of the displayed tab.
  final int currentIndex;

  /// The width size.
  final double? width;

  const MudeBottomBarFloat({
    super.key,
    required this.items,
    required this.onChanged,
    required this.currentIndex,
    this.width,
  });

  @override
  State<MudeBottomBarFloat> createState() => _MudeBottomBarFloatState();
}

class _MudeBottomBarFloatState extends State<MudeBottomBarFloat> {
  _onChanged(int index) {
    String autoHint = 'Tab ${index + 1} de ${widget.items.length} ativado';
    SemanticsService.announce(autoHint, TextDirection.ltr);

    widget.onChanged(index);
  }

  @override
  Widget build(BuildContext context) {
    var tokens = Provider.of<MudeThemeManager>(context);
    var globalTokens = tokens.globals;
    var aliasTokens = tokens.alias;
    final size = globalTokens.shapes.size;
    final circularRadius = globalTokens.shapes.border.radiusCircular;

    return Container(
      constraints: BoxConstraints(
        maxWidth: size.s40x,
      ),
      width: widget.width ?? size.s40x,
      height: size.s10x,
      padding: EdgeInsets.symmetric(horizontal: size.s2x),
      decoration: BoxDecoration(
        color: aliasTokens.color.elements.bgColor02,
        borderRadius: BorderRadius.circular(
          circularRadius,
        ),
      ),
      child: Stack(
        children: [
          AnimatedAlign(
            alignment: FractionalOffset(
              1 / (widget.items.length - 1) * widget.currentIndex,
              0.5,
            ),
            curve: globalTokens.motions.curves.productiveEntrance,
            duration: globalTokens.motions.durations.slow01,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: size.s7x,
                  decoration: BoxDecoration(
                    color: aliasTokens.color.selected.bgColor,
                    borderRadius: BorderRadius.circular(
                      circularRadius,
                    ),
                  ),
                  child: Builder(
                    builder: (c) {
                      final item = widget.items[widget.currentIndex];

                      return Opacity(
                        opacity: 0,
                        child: _FakeBottomBarWidget(
                          key: Key(item.label),
                          label: item.label,
                          icon: item.icon,
                          textSize: aliasTokens.mixin.labelMd2,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: widget.items.asMap().entries.map<Widget>(
                (tab) {
                  String label = tab.value.label;
                  String autoHint =
                      'Tab ${tab.key + 1} de ${widget.items.length}';

                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(
                        circularRadius,
                      ),
                    ),
                    child: BottomBarItemWidget(
                      label: label,
                      icon: tab.value.icon,
                      active: tab.key == widget.currentIndex,
                      value: tab.key,
                      onPressed: (v) => _onChanged(v),
                      showNotification: tab.value.showNotification,
                      inverse: true,
                      semanticsLabel: tab.value.semanticsLabel,
                      semanticsHint: tab.value.semanticsHint ?? autoHint,
                      textSize: aliasTokens.mixin.labelMd2,
                    ),
                  );
                },
              ).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
