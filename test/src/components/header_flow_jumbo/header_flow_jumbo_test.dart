import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mude_core/core.dart';

import '../../../wrapper.dart';

void main() {
  group(
    'Header Flow',
    () {
      testWidgets(
        'Should render header flow jumbo',
        (widgetTester) async {
          final key = UniqueKey();
          const title = 'Title';
          const description = 'Description';

          await widgetTester.pumpWidget(
            Wrapper(
              child: MudeHeaderFlowJumbo(
                key: key,
                title: title,
                description: description,
                onClose: () => debugPrint(''),
              ),
            ),
          );

          expect(find.byType(MudeHeaderFlowJumbo), findsOneWidget);
        },
      );

      testWidgets(
        'Should header flow jumbo tap on close',
        (widgetTester) async {
          final key = UniqueKey();
          const title = 'Title';
          const description = 'Description';
          bool press = false;

          await widgetTester.pumpWidget(
            Wrapper(
              child: MudeHeaderFlowJumbo(
                key: key,
                title: title,
                description: description,
                onClose: () => press = true,
              ),
            ),
          );

          final buttonClose = find.byType(MudeButtonIcon);
          await widgetTester.tap(buttonClose.first);
          await widgetTester.pumpAndSettle();

          expect(press, isTrue);
        },
      );

      testWidgets(
        'Should header flow jumbo tap on close',
        (widgetTester) async {
          final key = UniqueKey();
          const title = 'Title';
          const description = 'Description';
          bool press = false;

          await widgetTester.pumpWidget(
            Wrapper(
              child: MudeHeaderFlowJumbo(
                key: key,
                title: title,
                description: description,
                onClose: () => debugPrint(''),
                onBack: () => press = true,
              ),
            ),
          );

          final buttonBack = find.byKey(
            const Key('header-flow-jumbo.button-back'),
          );

          await widgetTester.tap(buttonBack);
          await widgetTester.pumpAndSettle();

          expect(press, isTrue);
        },
      );

      testWidgets(
        'Should header flow jumbo show progress',
        (widgetTester) async {
          final key = UniqueKey();
          const title = 'Title';
          const description = 'Description';

          await widgetTester.pumpWidget(
            Wrapper(
              child: MudeHeaderFlowJumbo(
                key: key,
                title: title,
                description: description,
                onClose: () => debugPrint(''),
                showProgress: true,
                totalStep: 5,
                currentStep: 2,
              ),
            ),
          );

          expect(find.byType(MudeProgressLine), findsOneWidget);
        },
      );

      testWidgets(
        'Should header flow jumbo currentStep is big to total step',
        (widgetTester) async {
          final key = UniqueKey();
          const title = 'Title';
          const description = 'Description';

          await widgetTester.pumpWidget(
            Wrapper(
              child: MudeHeaderFlowJumbo(
                key: key,
                title: title,
                description: description,
                onClose: () => debugPrint(''),
                showProgress: true,
                totalStep: 2,
                currentStep: 3,
              ),
            ),
          );

          expect(find.byType(MudeProgressLine), findsOneWidget);
        },
      );

      testWidgets(
        'Should header flow jumbo showing text step',
        (widgetTester) async {
          final key = UniqueKey();
          const title = 'Title';
          const description = 'Description';

          await widgetTester.pumpWidget(
            Wrapper(
              child: MudeHeaderFlowJumbo(
                key: key,
                title: title,
                description: description,
                onClose: () => debugPrint(''),
                showSteps: true,
                showProgress: true,
                totalStep: 3,
                currentStep: 1,
              ),
            ),
          );

          expect(find.text('Passo 1 de 3'), findsOneWidget);
        },
      );
    },
  );

  group('Header Flow Accessibility', () {
    testWidgets(
      'Should verify accessibility',
      (widgetTester) async {
        final SemanticsHandle handle = widgetTester.ensureSemantics();

        const title = 'Title';
        const description = 'Description';

        await widgetTester.pumpWidget(
          Wrapper(
            child: MudeHeaderFlowJumbo(
              title: title,
              description: description,
              onClose: () => debugPrint(''),
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
