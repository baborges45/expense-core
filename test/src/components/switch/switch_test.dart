import 'package:expense_core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../wrapper.dart';

void main() {
  group(
    'Switch Accessibility',
    () {
      testWidgets(
        'Should verify accessibility',
        (widgetTester) async {
          final SemanticsHandle handle = widgetTester.ensureSemantics();
          await widgetTester.pumpWidget(
            Wrapper(
              child: ExpenseSwitch(
                value: false,
                onChanged: (e) => debugPrint(''),
                semanticsLabel: 'switch',
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
    'Switch',
    () {
      testWidgets(
        'Should verify switch on tap',
        (widgetTester) async {
          final key = UniqueKey();
          bool pressed = false;

          await widgetTester.pumpWidget(
            Wrapper(
              child: ExpenseSwitch(
                key: key,
                onChanged: (bool value) {
                  pressed = value;
                },
                value: pressed,
              ),
            ),
          );

          await widgetTester.tap(find.byKey(key));
          expect(pressed, isTrue);
        },
      );

      testWidgets(
        'Should verify switch was pressed',
        (widgetTester) async {
          final key = UniqueKey();
          ExpenseThemeManager? tokens;
          bool pressed = false;

          await widgetTester.pumpWidget(
            Wrapper(
              onTokens: (t) => tokens = t,
              child: ExpenseSwitch(
                key: key,
                onChanged: (bool value) {
                  pressed = value;
                },
                value: pressed,
              ),
            ),
          );

          await widgetTester.press(find.byKey(key));
          await widgetTester.pump(const Duration(milliseconds: 300));

          final container = find.byKey(const Key('switch.pressed'));
          final widget = widgetTester.widget<Container>(
            container.first,
          );
          final decoration = widget.decoration as BoxDecoration;

          expect(decoration.color, tokens!.alias.mixin.pressedOutline);
        },
      );

      testWidgets(
        'Should verify switch was pressed with inverse',
        (widgetTester) async {
          final key = UniqueKey();
          ExpenseThemeManager? tokens;
          bool pressed = false;

          await widgetTester.pumpWidget(
            Wrapper(
              onTokens: (t) => tokens = t,
              child: ExpenseSwitch(
                key: key,
                onChanged: (bool value) {
                  pressed = value;
                },
                value: pressed,
                inverse: true,
              ),
            ),
          );

          await widgetTester.press(find.byKey(key));
          await widgetTester.pump(const Duration(milliseconds: 300));

          final container = find.byKey(const Key('switch.pressed'));
          final widget = widgetTester.widget<Container>(
            container.first,
          );
          final decoration = widget.decoration as BoxDecoration;

          expect(decoration.color, tokens!.alias.mixin.pressedOutlineInverse);
        },
      );

      testWidgets(
        'Switch should be disabled with checked',
        (widgetTester) async {
          final key = UniqueKey();
          ExpenseThemeManager? tokens;
          bool pressed = true;

          await widgetTester.pumpWidget(
            Wrapper(
              onTokens: (t) => tokens = t,
              child: ExpenseSwitch(
                disabled: true,
                key: key,
                onChanged: (bool value) {
                  pressed = value;
                },
                value: pressed,
              ),
            ),
          );

          final containers = find.byKey(const Key('switch.background'));
          final container = widgetTester.widget<AnimatedContainer>(containers.first);
          final decoration = container.decoration as BoxDecoration;

          expect(decoration.color, tokens!.alias.color.disabled.bgColor);
        },
      );

      testWidgets(
        'Switch should be inverse',
        (widgetTester) async {
          final key = UniqueKey();

          bool pressed = false;

          await widgetTester.pumpWidget(
            Wrapper(
              child: ExpenseSwitch(
                key: key,
                onChanged: (bool value) {
                  pressed = value;
                },
                inverse: true,
                value: pressed,
              ),
            ),
          );

          final containers = find.byKey(const Key('switch.background'));
          final container = widgetTester.widget<AnimatedContainer>(containers.first);
          final decoration = container.decoration as BoxDecoration;

          expect(decoration.color, Colors.transparent);
        },
      );

      testWidgets(
        'Switch should be inverse with checked',
        (widgetTester) async {
          final key = UniqueKey();
          ExpenseThemeManager? tokens;

          bool pressed = true;

          await widgetTester.pumpWidget(
            Wrapper(
              onTokens: (t) => tokens = t,
              child: ExpenseSwitch(
                key: key,
                onChanged: (bool value) {
                  pressed = value;
                },
                inverse: true,
                value: pressed,
              ),
            ),
          );

          final containers = find.byKey(const Key('switch.background'));
          final container = widgetTester.widget<AnimatedContainer>(containers.first);
          final decoration = container.decoration as BoxDecoration;

          expect(decoration.color, tokens!.alias.color.inverse.bgColor);
        },
      );

      testWidgets(
        'Should switch background filled',
        (widgetTester) async {
          final key = UniqueKey();
          ExpenseThemeManager? tokens;

          await widgetTester.pumpWidget(
            Wrapper(
              onTokens: (t) => tokens = t,
              child: ExpenseSwitch(
                key: key,
                onChanged: (bool value) => debugPrint(''),
                value: true,
              ),
            ),
          );

          final containers = find.byKey(const Key('switch.background'));
          final container = widgetTester.widget<AnimatedContainer>(containers.first);
          final decoration = container.decoration as BoxDecoration;

          expect(decoration.color, tokens!.alias.color.selected.bgColor);
        },
      );

      testWidgets(
        'Should button tap cancel',
        (widgetTester) async {
          final key = UniqueKey();
          bool press = false;

          await widgetTester.pumpWidget(
            Wrapper(
              child: ExpenseSwitch(
                key: key,
                onChanged: (bool value) => press = value,
                value: press,
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
