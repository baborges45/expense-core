import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:expense_core/core.dart';

import '../../../wrapper.dart';

void main() {
  group(
    'Promotion Page',
    () {
      testWidgets(
        'Should render promotion page',
        (widgetTester) async {
          await widgetTester.pumpWidget(
            Wrapper(
              onTap: (context) {
                return ExpensePromotionPage.show(
                  context,
                  child: const Text('Promotion Page'),
                  sourceBanner: 'test/assets/image.png',
                );
              },
              child: Container(),
            ),
          );

          final button = find.byKey(const Key('wrapper-tap'));
          await widgetTester.tap(button);
          await widgetTester.pumpAndSettle();

          expect(find.byType(ExpenseImage), findsOneWidget);
        },
      );

      testWidgets(
        'Should promotion page child',
        (widgetTester) async {
          const chilText = 'Promotion Page';

          await widgetTester.pumpWidget(
            Wrapper(
              onTap: (context) {
                return ExpensePromotionPage.show(
                  context,
                  child: const Text(chilText),
                  sourceBanner: 'test/assets/image.png',
                );
              },
              child: Container(),
            ),
          );

          final button = find.byKey(const Key('wrapper-tap'));
          await widgetTester.tap(button);
          await widgetTester.pumpAndSettle();

          expect(find.text(chilText), findsOneWidget);
        },
      );

      testWidgets(
        'Should promotion page fit option',
        (widgetTester) async {
          const chilText = 'Promotion Page';

          await widgetTester.pumpWidget(
            Wrapper(
              onTap: (context) {
                return ExpensePromotionPage.show(
                  context,
                  child: const Text(chilText),
                  sourceBanner: 'test/assets/image.png',
                  fit: BoxFit.fill,
                );
              },
              child: Container(),
            ),
          );

          final button = find.byKey(const Key('wrapper-tap'));
          await widgetTester.tap(button);
          await widgetTester.pumpAndSettle();

          final widget = widgetTester.widget<ExpenseImage>(find.byType(ExpenseImage));

          expect(widget.fit, BoxFit.fill);
        },
      );

      testWidgets(
        'Should promotion page aspect ratio option',
        (widgetTester) async {
          const chilText = 'Promotion Page';

          await widgetTester.pumpWidget(
            Wrapper(
              onTap: (context) {
                return ExpensePromotionPage.show(
                  context,
                  child: const Text(chilText),
                  sourceBanner: 'test/assets/image.png',
                );
              },
              child: Container(),
            ),
          );

          final button = find.byKey(const Key('wrapper-tap'));
          await widgetTester.tap(button);
          await widgetTester.pumpAndSettle();

          final widget = widgetTester.widget<ExpenseImage>(find.byType(ExpenseImage));

          expect(widget.aspectRatio, ExpenseImageAspectRatio.ratio_2x3);
        },
      );

      testWidgets(
        'Should promotion page close',
        (widgetTester) async {
          const chilText = 'Promotion Page';

          await widgetTester.pumpWidget(
            Wrapper(
              onTap: (context) {
                return ExpensePromotionPage.show(
                  context,
                  child: const Text(chilText),
                  sourceBanner: 'test/assets/image.png',
                );
              },
              child: Container(),
            ),
          );

          final button = find.byKey(const Key('wrapper-tap'));
          await widgetTester.tap(button);
          await widgetTester.pumpAndSettle();

          final buttonClose = find.byKey(
            const Key('promotion-page.button-close'),
          );

          expect(buttonClose, findsOneWidget);

          await widgetTester.tap(buttonClose);
          await widgetTester.pumpAndSettle();

          expect(buttonClose, findsNothing);
        },
      );
    },
  );

  group('Promotion Page Accessibility', () {
    testWidgets(
      'Should verify accessibility',
      (widgetTester) async {
        final SemanticsHandle handle = widgetTester.ensureSemantics();

        await widgetTester.pumpWidget(
          Wrapper(
            onTap: (context) {
              return ExpensePromotionPage.show(
                context,
                child: const Text('Promotion Page'),
                sourceBanner: 'test/assets/image.png',
              );
            },
            child: Container(),
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

        handle.dispose();
      },
    );
  });
}
