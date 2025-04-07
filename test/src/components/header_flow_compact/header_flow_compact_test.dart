import 'package:mude_core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../wrapper.dart';

void main() {
  group(
    'Header Flow Compact',
    () {
      testWidgets(
        'Should render header flow compact',
        (widgetTester) async {
          final key = UniqueKey();
          const title = 'Title';

          await widgetTester.pumpWidget(
            Wrapper(
              child: MudeHeaderFlowCompact(
                key: key,
                title: title,
              ),
            ),
          );

          expect(find.byKey(key), findsOneWidget);
        },
      );

      testWidgets(
        'Should header flow compact showing progress',
        (widgetTester) async {
          final key = UniqueKey();
          const title = 'Title';

          await widgetTester.pumpWidget(
            Wrapper(
              child: MudeHeaderFlowCompact(
                key: key,
                title: title,
                showProgress: true,
                totalStep: 5,
                currentStep: 1,
              ),
            ),
          );

          expect(find.byType(MudeProgressLine), findsOneWidget);
        },
      );

      testWidgets(
        'Should header flow compact showing steps',
        (widgetTester) async {
          final key = UniqueKey();
          const title = 'Title';

          await widgetTester.pumpWidget(
            Wrapper(
              child: MudeHeaderFlowCompact(
                key: key,
                title: title,
                showProgress: true,
                showSteps: true,
                totalStep: 5,
                currentStep: 1,
              ),
            ),
          );

          expect(find.text('Passo 1 de 5'), findsOneWidget);
        },
      );

      testWidgets(
        'Should header flow compact showing steps',
        (widgetTester) async {
          final key = UniqueKey();
          const title = 'Title';

          await widgetTester.pumpWidget(
            Wrapper(
              child: MudeHeaderFlowCompact(
                key: key,
                title: title,
                showProgress: true,
                showSteps: true,
                totalStep: 3,
                currentStep: 5,
              ),
            ),
          );

          expect(find.byType(MudeProgressLine), findsOneWidget);
        },
      );

      testWidgets(
        'Should header flow compact tap back',
        (widgetTester) async {
          final key = UniqueKey();
          const title = 'Title';
          bool press = false;

          await widgetTester.pumpWidget(
            Wrapper(
              child: MudeHeaderFlowCompact(
                key: key,
                title: title,
                showProgress: true,
                showSteps: true,
                totalStep: 3,
                currentStep: 5,
                onBack: () => press = true,
              ),
            ),
          );

          final buttons = find.byType(MudeButtonIcon);
          await widgetTester.tap(buttons.first);
          await widgetTester.pumpAndSettle();

          expect(press, isTrue);
        },
      );

      testWidgets(
        'Should header flow compact tap close',
        (widgetTester) async {
          final key = UniqueKey();
          const title = 'Title';
          bool press = false;

          await widgetTester.pumpWidget(
            Wrapper(
              child: MudeHeaderFlowCompact(
                key: key,
                title: title,
                showProgress: true,
                showSteps: true,
                totalStep: 3,
                currentStep: 5,
                onBack: () => press = false,
                onClose: () => press = true,
              ),
            ),
          );

          final buttons = find.byType(MudeButtonIcon);
          await widgetTester.tap(buttons.last);
          await widgetTester.pumpAndSettle();

          expect(press, isTrue);
        },
      );
    },
  );

  group('Header Flow Compact Accessibility', () {
    testWidgets(
      'Should verify accessibility',
      (widgetTester) async {
        final SemanticsHandle handle = widgetTester.ensureSemantics();

        const title = 'Title';

        await widgetTester.pumpWidget(
          const Wrapper(
            child: MudeHeaderFlowCompact(title: title),
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
