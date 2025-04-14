import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:expense_core/core.dart';
import 'package:provider/provider.dart';

import 'bottom_bar_animation_widget.dart';

class BottomBarContainerWidget extends StatefulWidget {
  /// Set a list items [ExpenseBottomBarItem] to displayed.
  final List<ExpenseBottomBarItem> items;

  /// Get index ever tab changed.
  final ValueChanged<int> onChanged;

  /// Set a current index to displayed.
  final int currentIndex;

  /// Set a child to displayed.
  final Widget child;

  final bool onlyIcon;
  final bool onlyIconActive;
  final bool activeInverse;

  const BottomBarContainerWidget({
    super.key,
    required this.currentIndex,
    required this.onChanged,
    required this.items,
    required this.child,
    this.onlyIcon = false,
    this.onlyIconActive = false,
    this.activeInverse = false,
  });

  @override
  State<BottomBarContainerWidget> createState() => _ExpenseBottomBarContainerWidgetCircleState();
}

class _ExpenseBottomBarContainerWidgetCircleState extends State<BottomBarContainerWidget> {
  double sizeTab = 0;

  GlobalKey tabKey = GlobalKey();

  late Timer _timer;

  @override
  void initState() {
    super.initState();

    _timer = Timer(const Duration(milliseconds: 1), () {
      setState(() {
        sizeTab = tabKey.currentContext!.size!.width;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  _onChanged(int index) {
    String autoHint = 'Tab ${index + 1} de ${widget.items.length} ativado';
    SemanticsService.announce(autoHint, TextDirection.ltr);

    widget.onChanged(index);
  }

  @override
  Widget build(BuildContext context) {
    var tokens = Provider.of<ExpenseThemeManager>(context);
    var globalTokens = tokens.globals;
    var aliasTokens = tokens.alias;
    var elements = aliasTokens.color.elements;

    return Container(
      height: globalTokens.shapes.size.s10x,
      decoration: BoxDecoration(
        color: elements.bgColor01,
        border: Border(
          top: BorderSide(
            width: aliasTokens.defaultt.borderWidth,
            color: elements.borderColor,
          ),
        ),
      ),
      child: Stack(
        children: [
          BottomBarAnimationWidget(
            spacing: (sizeTab * widget.currentIndex),
            size: sizeTab,
            child: widget.child,
          ),
          Row(
            children: [
              ...widget.items.asMap().entries.map(
                (tab) {
                  String isActived = widget.currentIndex == tab.key ? 'ativado' : '';

                  String autoHint = '$isActived Tab ${tab.key + 1} de ${widget.items.length}';

                  return BottomBarItemWidget(
                    key: tab.key == 0 ? tabKey : null,
                    label: tab.value.label,
                    icon: tab.value.icon,
                    active: widget.currentIndex == tab.key,
                    activeInverse: widget.activeInverse,
                    value: tab.key,
                    onPressed: (v) => _onChanged(v),
                    onlyIcon: widget.onlyIcon,
                    onlyIconActive: widget.onlyIconActive,
                    semanticsLabel: tab.value.semanticsLabel,
                    semanticsHint: tab.value.semanticsHint ?? autoHint,
                    textSize: aliasTokens.mixin.labelSm1,
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
