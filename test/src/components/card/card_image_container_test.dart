import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mude_core/core.dart';

import '../../../wrapper.dart';

void main() {
  group(
    'Card Image Container',
    () {
      testWidgets(
        'Should render card',
        (widgetTester) async {
          final key = UniqueKey();

          await widgetTester.pumpWidget(
            Wrapper(
              child: MudeCardImageContainer(
                key: key,
                src: 'test/assets/image.png',
              ),
            ),
          );

          expect(find.byKey(key), findsOneWidget);
          expect(find.byType(MudeImage), findsOneWidget);
        },
      );

      testWidgets(
        'Should card tap',
        (widgetTester) async {
          final key = UniqueKey();
          bool press = false;

          await widgetTester.pumpWidget(
            Wrapper(
              child: MudeCardImageContainer(
                key: key,
                src: 'test/assets/image.png',
                onPressed: () => press = true,
              ),
            ),
          );

          await widgetTester.tap(find.byKey(key));
          expect(press, isTrue);
        },
      );

      testWidgets(
        'Should card type container',
        (widgetTester) async {
          final key = UniqueKey();

          await widgetTester.pumpWidget(
            Wrapper(
              child: MudeCardImageContainer(
                key: key,
                src: 'test/assets/image.png',
                onPressed: () => debugPrint(''),
              ),
            ),
          );

          final image = widgetTester.widget<MudeImage>(find.byType(MudeImage));
          expect(image.borderRadius, isNull);
        },
      );
    },
  );

  group('Card Image Container Accessibility', () {
    testWidgets(
      'Should verify accessibility',
      (widgetTester) async {
        final SemanticsHandle handle = widgetTester.ensureSemantics();

        await widgetTester.pumpWidget(
          const Wrapper(
            child: MudeCardImageContainer(
              src: 'test/assets/image.png',
              semanticsLabel: 'Card image container',
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
