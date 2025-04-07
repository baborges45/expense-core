import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mude_core/core.dart';

import '../../../wrapper.dart';

void main() {
  group(
    'Chip Filter',
    () {
      testWidgets(
        'Should be render correctly',
        (widgetTester) async {
          final key = UniqueKey();

          await widgetTester.pumpWidget(
            Wrapper(
              child: MudeChipFilter(
                key: key,
                label: '',
                onPressed: () => debugPrint(''),
              ),
            ),
          );

          expect(find.byKey(key), findsOneWidget);
        },
      );

      testWidgets(
        'Should be render with a label',
        (widgetTester) async {
          final key = UniqueKey();

          await widgetTester.pumpWidget(
            Wrapper(
              child: MudeChipFilter(
                key: key,
                label: 'Test',
                onPressed: () => debugPrint(''),
              ),
            ),
          );

          expect(find.text('Test'), findsOneWidget);
        },
      );

      testWidgets(
        'Should change value on press',
        (widgetTester) async {
          final key = UniqueKey();
          bool value = false;

          await widgetTester.pumpWidget(
            Wrapper(
              child: MudeChipFilter(
                key: key,
                label: '',
                onPressed: () {
                  value = true;
                },
              ),
            ),
          );

          await widgetTester.tap(find.byKey(key));
          expect(value, true);
        },
      );

      testWidgets(
        'Should be inverse',
        (widgetTester) async {
          final key = UniqueKey();
          MudeThemeManager? tokens;

          await widgetTester.pumpWidget(
            Wrapper(
              onTokens: (t) => tokens = t,
              child: MudeChipFilter(
                key: key,
                label: '',
                onPressed: () => debugPrint(''),
              ),
            ),
          );

          final widget = widgetTester.widget<Container>(
            find.byKey(const Key('chip.background')),
          );

          final decoration = widget.decoration as BoxDecoration;
          expect(decoration.color, tokens!.alias.color.inverse.bgColor);
        },
      );

      testWidgets(
        'Should chip filter tap cancel',
        (widgetTester) async {
          final key = UniqueKey();
          bool press = false;

          await widgetTester.pumpWidget(
            Wrapper(
              child: MudeChipFilter(
                key: key,
                label: '',
                onPressed: () => debugPrint(''),
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

  group('Chip Filter Accessibility', () {
    testWidgets(
      'Should verify accessibility',
      (widgetTester) async {
        final SemanticsHandle handle = widgetTester.ensureSemantics();

        await widgetTester.pumpWidget(
          Wrapper(
            child: MudeChipFilter(
              label: 'Chip Filter',
              onPressed: () => debugPrint(''),
              semanticsLabel: 'Chip Filter',
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
