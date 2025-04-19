import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:expense_core/core.dart';

import '../../../wrapper.dart';

void main() {
  group(
    'Progress',
    () {
      testWidgets(
        'Should render progress bar',
        (widgetTester) async {
          final key = UniqueKey();
          int progress = 10;

          await widgetTester.pumpWidget(
            Wrapper(
              child: ExpenseProgressLine(
                key: key,
                progress: progress,
              ),
            ),
          );

          expect(find.byKey(key), findsOneWidget);
        },
      );

      testWidgets(
        'Should progress bar showing label',
        (widgetTester) async {
          final key = UniqueKey();
          int progress = 10;

          await widgetTester.pumpWidget(
            Wrapper(
              child: ExpenseProgressLine(
                key: key,
                progress: progress,
                showPercentual: true,
              ),
            ),
          );

          expect(find.text('${progress.toString()}%'), findsOneWidget);
        },
      );

      testWidgets(
        'Should progress bar check percentual width',
        (widgetTester) async {
          final key = UniqueKey();
          int progress = 10;
          BuildContext? context;

          await widgetTester.pumpWidget(
            Wrapper(
              onContext: (c) => context = c,
              child: ExpenseProgressLine(
                key: key,
                progress: progress,
                showPercentual: true,
              ),
            ),
          );

          await widgetTester.pumpAndSettle();

          final state = widgetTester.state<ExpenseProgressLineState>(
            find.byType(ExpenseProgressLine),
          );

          expect(state.sizeWidth, MediaQuery.of(context!).size.width);
        },
      );
    },
  );

  group('Progress Accessibility', () {
    testWidgets(
      'Should verify accessibility',
      (widgetTester) async {
        final SemanticsHandle handle = widgetTester.ensureSemantics();

        await widgetTester.pumpWidget(
          const Wrapper(
            child: ExpenseProgressLine(
              progress: 10,
              semanticsLabel: 'Progress line',
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
