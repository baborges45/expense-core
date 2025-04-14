import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:expense_core/core.dart';

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
              child: ExpenseHeaderNavigation(
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
              child: ExpenseHeaderNavigation(
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
              child: ExpenseHeaderNavigation(
                key: key,
                title: title,
                subtitle: subtitle,
                type: ExpenseHeaderNavigationType.jumbo,
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
              child: ExpenseHeaderNavigation(
                key: key,
                title: title,
                subtitle: subtitle,
                description: description,
                type: ExpenseHeaderNavigationType.jumbo,
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
              child: ExpenseHeaderNavigation(
                key: key,
                title: title,
                subtitle: subtitle,
                description: description,
                type: ExpenseHeaderNavigationType.jumbo,
                onBack: () => press = true,
              ),
            ),
          );

          final button = find.byType(ExpenseButtonIcon);
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
              child: ExpenseHeaderNavigation(
                key: key,
                title: title,
                subtitle: subtitle,
                description: description,
                type: ExpenseHeaderNavigationType.jumbo,
                onBack: () => debugPrint(''),
                trailingButtons: [
                  ExpenseButtonIcon(
                    icon: ExpenseIcons.placeholderLine,
                    onPressed: () => debugPrint(''),
                  ),
                ],
              ),
            ),
          );

          final buttons = find.byType(ExpenseButtonIcon);
          final button = widgetTester.widget<ExpenseButtonIcon>(buttons.last);

          expect(button.icon.name, ExpenseIcons.placeholderLine.name);
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
            child: ExpenseHeaderNavigation(
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
