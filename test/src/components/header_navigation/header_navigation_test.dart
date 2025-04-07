import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mude_core/core.dart';

import '../../../wrapper.dart';

void main() {
  group(
    'Header Navigation',
    () {
      testWidgets(
        'Should render header navigation',
        (widgetTester) async {
          final key = UniqueKey();

          await widgetTester.pumpWidget(
            Wrapper(
              child: MudeHeaderNavigation(
                key: key,
                onBack: () => debugPrint(''),
              ),
            ),
          );

          expect(find.byKey(key), findsOneWidget);
        },
      );

      testWidgets(
        'Should header navigation showing title',
        (widgetTester) async {
          final key = UniqueKey();
          const title = 'Title';

          await widgetTester.pumpWidget(
            Wrapper(
              child: MudeHeaderNavigation(
                key: key,
                title: title,
                onBack: () => debugPrint(''),
              ),
            ),
          );

          expect(find.text(title), findsOneWidget);
        },
      );

      testWidgets(
        'Should header navigation showing subtitle',
        (widgetTester) async {
          final key = UniqueKey();
          const title = 'Title';
          const subtitle = 'Subtitle';

          await widgetTester.pumpWidget(
            Wrapper(
              child: MudeHeaderNavigation(
                key: key,
                title: title,
                subtitle: subtitle,
                type: MudeHeaderNavigationType.jumbo,
                onBack: () => debugPrint(''),
              ),
            ),
          );

          expect(find.text(subtitle), findsOneWidget);
        },
      );

      testWidgets(
        'Should header navigation showing description',
        (widgetTester) async {
          final key = UniqueKey();
          const title = 'Title';
          const subtitle = 'Subtitle';
          const description = 'Description';

          await widgetTester.pumpWidget(
            Wrapper(
              child: MudeHeaderNavigation(
                key: key,
                title: title,
                subtitle: subtitle,
                description: description,
                type: MudeHeaderNavigationType.jumbo,
                onBack: () => debugPrint(''),
              ),
            ),
          );

          expect(find.text(subtitle), findsOneWidget);
        },
      );

      testWidgets(
        'Should header navigation tap back',
        (widgetTester) async {
          final key = UniqueKey();
          const title = 'Title';
          const subtitle = 'Subtitle';
          const description = 'Description';

          bool press = false;

          await widgetTester.pumpWidget(
            Wrapper(
              child: MudeHeaderNavigation(
                key: key,
                title: title,
                subtitle: subtitle,
                description: description,
                type: MudeHeaderNavigationType.jumbo,
                onBack: () => press = true,
              ),
            ),
          );

          final button = find.byType(MudeButtonIcon);
          await widgetTester.tap(button.first);
          await widgetTester.pumpAndSettle();

          expect(press, isTrue);
        },
      );

      testWidgets(
        'Should header navigation tap back',
        (widgetTester) async {
          final key = UniqueKey();

          const title = 'Title';
          const subtitle = 'Subtitle';
          const description = 'Description';

          await widgetTester.pumpWidget(
            Wrapper(
              child: MudeHeaderNavigation(
                key: key,
                title: title,
                subtitle: subtitle,
                description: description,
                type: MudeHeaderNavigationType.jumbo,
                onBack: () => debugPrint(''),
                trailingButtons: [
                  MudeButtonIcon(
                    icon: MudeIcons.placeholderLine,
                    onPressed: () => debugPrint(''),
                  ),
                ],
              ),
            ),
          );

          final buttons = find.byType(MudeButtonIcon);
          final button = widgetTester.widget<MudeButtonIcon>(buttons.last);

          expect(button.icon.name, MudeIcons.placeholderLine.name);
        },
      );
    },
  );

  group('Header Navigation Accessibility', () {
    testWidgets(
      'Should verify accessibility',
      (widgetTester) async {
        final SemanticsHandle handle = widgetTester.ensureSemantics();

        await widgetTester.pumpWidget(
          Wrapper(
            child: MudeHeaderNavigation(
              onBack: () => debugPrint(''),
              semanticsHeaderLabel: 'Label text',
              semanticsHeaderHint: 'Hint Text',
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
