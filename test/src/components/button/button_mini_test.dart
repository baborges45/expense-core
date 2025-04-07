import 'package:mude_core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../wrapper.dart';

void main() {
  group(
    'Button Mini Accessibility',
    () {
      testWidgets(
        'Should verify accessibility',
        (widgetTester) async {
          final SemanticsHandle handle = widgetTester.ensureSemantics();

          await widgetTester.pumpWidget(
            Wrapper(
              child: MudeButtonMini(
                label: 'label',
                onPressed: () => debugPrint(''),
              ),
            ),
          );

          await expectLater(
            widgetTester,
            meetsGuideline(androidTapTargetGuideline),
          );

          await expectLater(
            widgetTester,
            meetsGuideline(iOSTapTargetGuideline),
          );

          await expectLater(
            widgetTester,
            meetsGuideline(labeledTapTargetGuideline),
          );

          await expectLater(
            widgetTester,
            meetsGuideline(textContrastGuideline),
          );

          handle.dispose();
        },
      );
    },
  );

  group(
    'Button Mini',
    () {
      testWidgets(
        'Should render button with label',
        (widgetTester) async {
          const label = 'Button';

          await widgetTester.pumpWidget(
            Wrapper(
              child: MudeButtonMini(
                label: label,
                onPressed: () => debugPrint(''),
              ),
            ),
          );

          var widget = find.text(label);
          expect(widget, findsOneWidget);
        },
      );

      testWidgets(
        'Should button disabled and not tap',
        (widgetTester) async {
          final key = UniqueKey();
          const label = 'Button';
          bool press = false;

          await widgetTester.pumpWidget(
            Wrapper(
              child: MudeButtonMini(
                key: key,
                label: label,
                disabled: true,
                onPressed: () {
                  press = true;
                },
              ),
            ),
          );

          await widgetTester.tap(find.byKey(key));
          expect(press, false);
        },
      );

      testWidgets(
        'Should button tap',
        (widgetTester) async {
          final key = UniqueKey();
          const label = 'Button';
          bool press = false;

          await widgetTester.pumpWidget(
            Wrapper(
              child: MudeButtonMini(
                key: key,
                label: label,
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
        'Should button inverse color',
        (widgetTester) async {
          final key = UniqueKey();
          const label = 'Button';
          MudeThemeManager? tokens;

          await widgetTester.pumpWidget(
            Wrapper(
              onTokens: (t) => tokens = t,
              child: MudeButtonMini(
                key: key,
                label: label,
                inverse: true,
                onPressed: () => debugPrint(''),
              ),
            ),
          );

          final widget = find.descendant(
            of: find.byKey(key),
            matching: find.text(label),
          );

          var color = widgetTester.widget<Text>(widget).style!.color;
          expect(color, tokens!.alias.color.inverse.labelColor);
        },
      );

      testWidgets(
        'Should button tap cancel',
        (widgetTester) async {
          final key = UniqueKey();
          const label = 'Button';
          bool press = false;

          await widgetTester.pumpWidget(
            Wrapper(
              child: MudeButtonMini(
                key: key,
                label: label,
                inverse: true,
                onPressed: () => press = true,
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
}
