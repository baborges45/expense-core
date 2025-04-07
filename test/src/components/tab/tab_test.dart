import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mude_core/core.dart';

import '../../../wrapper.dart';

void main() {
  group(
    'Tab',
    () {
      testWidgets(
        'Should display correct number of tabs',
        (widgetTester) async {
          final key = UniqueKey();
          final List<MudeTabItem> tabs = [
            MudeTabItem(label: 'Tab 1'),
            MudeTabItem(label: 'Tab 2'),
            MudeTabItem(label: 'Tab 3'),
          ];
          await widgetTester.pumpWidget(
            Wrapper(
              child: DefaultTabController(
                length: 3,
                child: MudeTab(
                  key: key,
                  tabs: tabs,
                  children: [
                    Container(),
                    Container(),
                    Container(),
                  ],
                ),
              ),
            ),
          );
          expect(find.text('Tab 1'), findsOneWidget);
          expect(find.text('Tab 2'), findsOneWidget);
          expect(find.text('Tab 3'), findsOneWidget);
        },
      );

      testWidgets(
        'Should call onPressed when a tab is pressed',
        (widgetTester) async {
          final key = UniqueKey();
          final List<MudeTabItem> tabs = [
            MudeTabItem(label: 'Tab 1'),
            MudeTabItem(label: 'Tab 2'),
            MudeTabItem(label: 'Tab 3'),
          ];

          int selectedIndex = -1;
          await widgetTester.pumpWidget(
            Wrapper(
              child: DefaultTabController(
                length: 3,
                child: MudeTab(
                  key: key,
                  tabs: tabs,
                  children: [
                    Container(),
                    Container(),
                    Container(),
                  ],
                  onPressed: (value) {
                    selectedIndex = value;
                  },
                ),
              ),
            ),
          );

          await widgetTester.tap(find.text('Tab 1'));
          await widgetTester.pump();
          expect(selectedIndex, 0);

          await widgetTester.tap(find.text('Tab 2'));
          await widgetTester.pump();
          expect(selectedIndex, 1);
        },
      );

      testWidgets(
        'Should have a notification badge',
        (widgetTester) async {
          final key = UniqueKey();
          final List<MudeTabItem> tabs = [
            MudeTabItem(
              label: 'Tab 1',
            ),
            MudeTabItem(
              label: 'Tab 2',
            ),
            MudeTabItem(
              label: 'Tab 3',
            ),
          ];

          await widgetTester.pumpWidget(
            Wrapper(
              child: DefaultTabController(
                length: 3,
                child: MudeTab(
                  key: key,
                  tabs: tabs,
                  children: [
                    Container(),
                    Container(),
                    Container(),
                  ],
                ),
              ),
            ),
          );
          expect(find.byType(MudeBadge), findsNWidgets(2));
        },
      );

      testWidgets(
        'Should have a tabline',
        (widgetTester) async {
          final key = UniqueKey();
          final List<MudeTabItem> tabs = [
            MudeTabItem(
              label: 'Tab 1',
            ),
            MudeTabItem(
              label: 'Tab 2',
            ),
            MudeTabItem(
              label: 'Tab 3',
            ),
          ];

          await widgetTester.pumpWidget(
            Wrapper(
              child: DefaultTabController(
                length: 3,
                child: MudeTab(
                  key: key,
                  tabs: tabs,
                  children: [
                    Container(),
                    Container(),
                    Container(),
                  ],
                ),
              ),
            ),
          );
          expect(find.byKey(const Key('tab.line')), findsOneWidget);
        },
      );

      testWidgets(
        'Should have an icon',
        (widgetTester) async {
          final key = UniqueKey();
          final List<MudeTabItem> tabs = [
            MudeTabItem(
              label: 'Tab 1',
            ),
            MudeTabItem(
              label: 'Tab 2',
            ),
            MudeTabItem(
              label: 'Tab 3',
              icon: MudeIcons.calendarLine,
            ),
          ];

          await widgetTester.pumpWidget(
            Wrapper(
              child: DefaultTabController(
                length: 3,
                child: MudeTab(
                  key: key,
                  tabs: tabs,
                  children: [
                    Container(),
                    Container(),
                    Container(),
                  ],
                ),
              ),
            ),
          );
          expect(find.byType(MudeIcon), findsOneWidget);
        },
      );

      testWidgets(
        'Should be inverse',
        (widgetTester) async {
          final key = UniqueKey();
          MudeThemeManager? tokens;
          final List<MudeTabItem> tabs = [
            MudeTabItem(
              label: 'Tab 1',
            ),
            MudeTabItem(
              label: 'Tab 2',
            ),
            MudeTabItem(
              label: 'Tab 3',
              icon: MudeIcons.calendarLine,
            ),
          ];

          await widgetTester.pumpWidget(
            Wrapper(
              onTokens: (t) => tokens = t,
              child: DefaultTabController(
                length: 3,
                child: MudeTab(
                  key: key,
                  tabs: tabs,
                  inverse: true,
                  children: [
                    Container(),
                    Container(),
                    Container(),
                  ],
                ),
              ),
            ),
          );

          final widget = find.byKey(const Key('tab.tab_bar'));
          final container = widgetTester.widget<TabBar>(widget);

          expect(
            container.indicatorColor,
            tokens!.alias.color.inverse.borderColor,
          );
        },
      );

      testWidgets(
        'Should change icon color if active',
        (widgetTester) async {
          final key = UniqueKey();
          MudeThemeManager? tokens;
          final List<MudeTabItem> tabs = [
            MudeTabItem(
              label: 'Tab 1',
              icon: MudeIcons.calendarLine,
            ),
            MudeTabItem(
              label: 'Tab 2',
            ),
            MudeTabItem(
              label: 'Tab 3',
            ),
          ];

          await widgetTester.pumpWidget(
            Wrapper(
              onTokens: (t) => tokens = t,
              child: DefaultTabController(
                length: 3,
                child: MudeTab(
                  key: key,
                  tabs: tabs,
                  children: [
                    Container(),
                    Container(),
                    Container(),
                  ],
                ),
              ),
            ),
          );

          final iconFinder = find.byType(MudeIcon);
          final icon = widgetTester.widget<MudeIcon>(iconFinder);
          expect(icon.color, tokens!.alias.color.selected.iconColor);
        },
      );
    },
  );

  group('Tab Accessibility', () {
    testWidgets(
      'Should verify accessibility',
      (widgetTester) async {
        final SemanticsHandle handle = widgetTester.ensureSemantics();

        final List<MudeTabItem> tabs = [
          MudeTabItem(
            label: 'Tab 1',
            semanticsLabel: 'Tab 1',
          ),
          MudeTabItem(
            label: 'Tab 2',
            semanticsLabel: 'Tab 2',
          ),
          MudeTabItem(
            label: 'Tab 3',
            semanticsLabel: 'Tab 3',
          ),
        ];

        await widgetTester.pumpWidget(
          Wrapper(
            child: DefaultTabController(
              length: 3,
              child: MudeTab(
                tabs: tabs,
                children: [
                  Container(),
                  Container(),
                  Container(),
                ],
                onPressed: (value) => debugPrint(''),
              ),
            ),
          ),
        );

        // Checks that tappable nodes have a minimum size of 48 by 48 pixels
        // for Android.
        await expectLater(
          widgetTester,
          meetsGuideline(androidTapTargetGuideline),
        );

        // Checks that tappable nodes have a minimum size of 44 by 44 pixels
        // for iOS.
        await expectLater(
          widgetTester,
          meetsGuideline(iOSTapTargetGuideline),
        );

        // Checks that touch targets with a tap or long press action are labeled.
        await expectLater(
          widgetTester,
          meetsGuideline(labeledTapTargetGuideline),
        );

        // Checks whether semantic nodes meet the minimum text contrast levels.
        // The recommended text contrast is 3:1 for larger text
        // (18 point and above regular).
        await expectLater(
          widgetTester,
          meetsGuideline(textContrastGuideline),
        );

        handle.dispose();
      },
    );
  });
}
