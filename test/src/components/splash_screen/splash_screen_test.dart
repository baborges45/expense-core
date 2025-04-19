import 'package:flutter_test/flutter_test.dart';
import 'package:expense_core/core.dart';

import '../../../wrapper.dart';

void main() {
  group(
    'Splash screen',
    () {
      testWidgets(
        'Should splash screen ',
        (widgetTester) async {
          await widgetTester.pumpWidget(
            const Wrapper(
              child: ExpenseSplashScreen(
                logo: ExpenseBrand(type: ExpenseBrandType.logo),
              ),
            ),
          );

          final widget = find.byType(ExpenseSplashScreen);
          expect(widget, findsOneWidget);
        },
      );
    },
  );

  group('Splash screen Accessibility', () {
    testWidgets(
      'Should verify accessibility',
      (widgetTester) async {
        final SemanticsHandle handle = widgetTester.ensureSemantics();

        await widgetTester.pumpWidget(
          const Wrapper(
            child: ExpenseSplashScreen(
              logo: ExpenseBrand(type: ExpenseBrandType.logo),
              semanticsLabel: 'Splash screen',
              semanticsHint: 'Splash screen',
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
