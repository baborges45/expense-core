import 'package:flutter/material.dart';
import 'package:expense_core/core.dart';
import 'package:provider/provider.dart';

part 'widgets/_tab_item.dart';
part 'widgets/tab_bar_controller.dart';

class ExpenseTab extends StatefulWidget {
  ///A  list of [ExpenseTabItem] objects.
  ///Each ExpenseTabItem represents a tab in the [ExpenseTab] widget.
  final List<ExpenseTabItem> tabs;

  //A list of widgets that will be displayed in the content area of the [ExpenseTab] widget.
  // One widget per tab.
  // Its length must match the length of the [TabBar.tabs] list, as well as the [controller]'s [TabController.length].
  final List<Widget>? children;

  ///An  boolean parameter that specifies whether the tabs should be scrollable or not.
  ///The default value is true.
  final bool isScrollable;

  ///An callback function that will be called when a tab is pressed.
  ///The function will return an integer that represents the index of the tab that was pressed.
  final ValueChanged<int>? onPressed;

  ///(Optional) A boolean parameter that specifies whether the link should have an inverse color scheme.
  ///The default value is false.
  final bool inverse;

  final ExpenseTabBarController? controller;

  const ExpenseTab({
    super.key,
    required this.tabs,
    this.children,
    this.isScrollable = true,
    this.inverse = false,
    this.onPressed,
    this.controller,
  });

  @override
  State<ExpenseTab> createState() => _TabState();
}

class _TabState extends State<ExpenseTab> with SingleTickerProviderStateMixin {
  final List<TabItemModel> _listTabs = [];
  int indexSelected = 0;
  ExpenseTabBarController? controller;

  @override
  void initState() {
    super.initState();

    controller = widget.controller;

    remapItemsTab();
  }

  void remapItemsTab() {
    for (var i = 0; i < widget.tabs.length; i++) {
      String label = widget.tabs[i].label;
      ExpenseIconData? icon = widget.tabs[i].icon;

      _listTabs.add(
        TabItemModel(
          index: i,
          label: label,
          icon: icon,
          isScrollable: widget.isScrollable,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var tokens = Provider.of<ExpenseThemeManager>(context);
    var globalTokens = tokens.globals;
    var aliasTokens = tokens.alias;
    var size = globalTokens.shapes.size.s2x;
    bool actived = false;

    controller ??= ExpenseTabBarController(
      length: widget.tabs.length,
      vsync: this,
      duration: globalTokens.motions.durations.slow01,
      curve: globalTokens.motions.curves.productiveEntrance,
    );

    void onPressed(int index) {
      setState(() => indexSelected = index);

      if (widget.onPressed != null) {
        widget.onPressed!(index);
      }
    }

    final radiusCircular = globalTokens.shapes.border.radiusCircular;
    final spacing = globalTokens.shapes.spacing;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Semantics(
          explicitChildNodes: true,
          child: TabBar(
            splashBorderRadius: BorderRadius.circular(
              radiusCircular,
            ),
            automaticIndicatorColorAdjustment: false,
            overlayColor: WidgetStatePropertyAll<Color>(
              aliasTokens.mixin.pressedOutline,
            ),
            controller: controller,
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(
                radiusCircular,
              ),
              color: aliasTokens.color.selected.bgColor,
            ),
            key: const Key('tab.tab_bar'),
            tabs: [
              ...widget.tabs.asMap().entries.map((tab) {
                actived = tab.key == indexSelected;
                String label = tab.value.label;

                return Semantics(
                  button: true,
                  label: tab.value.semanticsLabel ?? label,
                  hint: tab.value.semanticsHint,
                  focused: actived,
                  excludeSemantics: true,
                  child: Container(
                    color: Colors.transparent,
                    padding: EdgeInsets.fromLTRB(
                      spacing.s2_5x,
                      spacing.half,
                      spacing.half,
                      spacing.half,
                    ),
                    child: _TabItem(
                      label: label,
                      actived: actived,
                      isScrollable: widget.isScrollable,
                      inverse: widget.inverse,
                      icon: tab.value.icon,
                    ),
                  ),
                );
              }),
            ],
            onTap: onPressed,
            isScrollable: widget.isScrollable,
            dividerColor: Colors.transparent,
            indicatorColor: Colors.transparent,
            labelPadding: EdgeInsets.only(right: size),
            tabAlignment: TabAlignment.start,
          ),
        ),
        if (widget.children != null)
          Expanded(
            flex: 1,
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              children: widget.children ?? [],
            ),
          ),
      ],
    );
  }
}
