import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mude_core/core.dart';

import '../../../wrapper.dart';

void main() {
  group(
    'Shorcut Image',
    () {
      testWidgets(
        'Should render shortcut',
        (widgetTester) async {
          const text = 'Text';

          await widgetTester.pumpWidget(
            Wrapper(
              child: MudeShortcutImage(
                label: text,
                description: text,
                onPressed: () => debugPrint(''),
                source: 'test/assets/image.png',
              ),
            ),
          );

          expect(find.text(text), findsOneWidget);
          expect(find.byType(Image), findsOneWidget);
        },
      );

      testWidgets(
        'Should shortcut tap',
        (widgetTester) async {
          final key = UniqueKey();
          const text = 'Text';
          bool press = false;

          await widgetTester.pumpWidget(
            Wrapper(
              child: MudeShortcutImage(
                key: key,
                source: 'test/assets/image.png',
                label: text,
                description: text,
                onPressed: () {
                  press = true;
                },
              ),
            ),
          );

          await widgetTester.tap(find.byKey(key));
          expect(press, isTrue);
        },
      );

      testWidgets(
        'Should shortcut disabled and not accept tap',
        (widgetTester) async {
          final key = UniqueKey();
          const text = 'Text';
          bool press = false;

          await widgetTester.pumpWidget(
            Wrapper(
              child: MudeShortcutImage(
                key: key,
                source: 'test/assets/image.png',
                label: text,
                description: text,
                disabled: true,
                onPressed: () {
                  press = true;
                },
              ),
            ),
          );

          await widgetTester.tap(find.byKey(key));
          expect(press, isFalse);
        },
      );

      testWidgets(
        'Should button tap cancel',
        (widgetTester) async {
          const text = 'Text';
          bool press = false;

          await widgetTester.pumpWidget(
            Wrapper(
              child: MudeShortcutImage(
                label: text,
                source: 'test/assets/image.png',
                description: text,
                onPressed: () => press = true,
                disabled: true,
              ),
            ),
          );

          // simulate gesture tap cancel
          final gesture = await widgetTester.startGesture(
            widgetTester.getCenter(find.byType(GestureDetector)),
            pointer: 7,
          );

          await gesture.moveBy(const Offset(0, 10));
          await gesture.cancel();

          expect(press, isFalse);
        },
      );
    },
  );

  group('Shorcut Image Accessibility', () {
    testWidgets(
      'Should verify accessibility',
      (widgetTester) async {
        final SemanticsHandle handle = widgetTester.ensureSemantics();
        const text = 'Text';

        await widgetTester.pumpWidget(
          Wrapper(
            child: MudeShortcutImage(
              label: text,
              description: text,
              source: 'test/assets/image.png',
              onPressed: () => debugPrint(''),
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
