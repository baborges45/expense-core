import 'package:expense_core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../wrapper.dart';

void main() {
  group(
    'Radio Button Accessibility',
    () {
      testWidgets(
        'Should verify accessibility',
        (widgetTester) async {
          final SemanticsHandle handle = widgetTester.ensureSemantics();
          await widgetTester.pumpWidget(
            Wrapper(
              child: ExpenseRadioButton(
                value: false,
                onChanged: (value) => debugPrint(''),
                semanticsLabel: 'radio',
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
    'Radio Button',
    () {
      testWidgets(
        'Should be render correctly',
        (widgetTester) async {
          final key = UniqueKey();

          await widgetTester.pumpWidget(
            Wrapper(
              child: ExpenseRadioButton(
                key: key,
                onChanged: (value) => debugPrint(''),
                value: null,
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
              child: ExpenseRadioButton(
                key: key,
                onChanged: (value) => debugPrint(''),
                value: null,
                label: 'Label',
              ),
            ),
          );

          expect(find.text('Label'), findsOneWidget);
        },
      );

      testWidgets(
        'Should be inverse',
        (widgetTester) async {
          final key = UniqueKey();
          ExpenseThemeManager? tokens;
          await widgetTester.pumpWidget(
            Wrapper(
              onTokens: (t) => tokens = t,
              child: ExpenseRadioButton(
                key: key,
                onChanged: (value) => debugPrint(''),
                value: 'a',
                groupValue: 'a',
                label: 'Label',
                inverse: true,
              ),
            ),
          );
          final widget = widgetTester.widget<Container>(
            find.byKey(const Key('radio_button.container')),
          );
          final decoration = widget.decoration as BoxDecoration;
          expect(decoration.color, tokens?.alias.color.inverse.bgColor);
        },
      );

      testWidgets(
        'Should have an onpress animation inverse',
        (widgetTester) async {
          final key = UniqueKey();
          await widgetTester.pumpWidget(
            Wrapper(
              child: ExpenseRadioButton(
                key: key,
                onChanged: (value) => debugPrint(''),
                value: 'a',
                groupValue: 'a',
                label: 'Label',
                inverse: true,
              ),
            ),
          );

          final animationFinder = find.byKey(const Key('radio_button.animation'));
          expect(animationFinder, findsNothing);

          final radioButtonFinder = find.byKey(const Key('radio_button.container'));

          await widgetTester.press(radioButtonFinder);
          await widgetTester.pump();
          expect(animationFinder, findsOneWidget);
        },
      );

      testWidgets(
        'Should have an onpress animation',
        (widgetTester) async {
          final key = UniqueKey();
          await widgetTester.pumpWidget(
            Wrapper(
              child: ExpenseRadioButton(
                key: key,
                onChanged: (value) => debugPrint(''),
                value: 'a',
                groupValue: 'a',
                label: 'Label',
              ),
            ),
          );

          final animationFinder = find.byKey(const Key('radio_button.animation'));
          expect(animationFinder, findsNothing);

          final radioButtonFinder = find.byKey(const Key('radio_button.container'));

          await widgetTester.press(radioButtonFinder);
          await widgetTester.pump();
          expect(animationFinder, findsOneWidget);
        },
      );

      testWidgets(
        'Should be changing value on pressed',
        (widgetTester) async {
          final keyA = UniqueKey();
          final keyB = UniqueKey();

          late String groupValue = 'a';

          onChanged(value) {
            groupValue = value!;
          }

          await widgetTester.pumpWidget(
            Wrapper(
              child: Column(
                children: [
                  ExpenseRadioButton(
                    key: keyA,
                    onChanged: onChanged,
                    value: 'a',
                    groupValue: groupValue,
                  ),
                  ExpenseRadioButton(
                    key: keyB,
                    onChanged: onChanged,
                    value: 'b',
                    groupValue: groupValue,
                  ),
                ],
              ),
            ),
          );

          await widgetTester.tap(find.byKey(keyB));
          expect(groupValue, 'b');
        },
      );

      testWidgets(
        'Should be disabled',
        (widgetTester) async {
          final keyA = UniqueKey();
          final keyB = UniqueKey();
          final keyC = UniqueKey();
          late String groupValue = 'b';

          onChanged(value) {
            groupValue = value!;
          }

          await widgetTester.pumpWidget(
            Wrapper(
              child: Column(
                children: [
                  ExpenseRadioButton(
                    key: keyA,
                    onChanged: onChanged,
                    value: 'a',
                    groupValue: groupValue,
                  ),
                  ExpenseRadioButton(
                    key: keyB,
                    onChanged: onChanged,
                    value: 'b',
                    disabled: true,
                    groupValue: groupValue,
                  ),
                  ExpenseRadioButton(
                    key: keyC,
                    onChanged: onChanged,
                    value: 'c',
                    groupValue: groupValue,
                  ),
                ],
              ),
            ),
          );
          await widgetTester.tap(find.byKey(keyA));
          expect(groupValue, 'a');
          await widgetTester.tap(find.byKey(keyB));
          expect(groupValue, 'a');
          await widgetTester.tap(find.byKey(keyC));
          expect(groupValue, 'c');
        },
      );

      testWidgets(
        'Should have a label with disabled color',
        (widgetTester) async {
          final key = UniqueKey();
          late String groupValue = 'b';

          onChanged(value) {
            groupValue = value!;
          }

          await widgetTester.pumpWidget(
            Wrapper(
              child: Column(
                children: [
                  ExpenseRadioButton(
                    key: key,
                    onChanged: onChanged,
                    value: 'a',
                    groupValue: groupValue,
                    disabled: true,
                    label: 'Hahaha',
                  ),
                ],
              ),
            ),
          );

          expect(
            find.byKey(const Key('radio_button.label_disabled')),
            findsOneWidget,
          );
        },
      );

      testWidgets(
        'Should set groupValue a null value',
        (widgetTester) async {
          final keyA = UniqueKey();
          final keyB = UniqueKey();

          late String? groupValue = 'a';

          onChanged(value) {
            groupValue = value;
          }

          await widgetTester.pumpWidget(
            Wrapper(
              child: Column(
                children: [
                  ExpenseRadioButton(
                    key: keyA,
                    onChanged: onChanged,
                    value: null,
                    groupValue: groupValue,
                  ),
                  ExpenseRadioButton(
                    key: keyB,
                    onChanged: onChanged,
                    value: 'b',
                    groupValue: groupValue,
                  ),
                ],
              ),
            ),
          );
          await widgetTester.tap(find.byKey(keyA));
          expect(groupValue, null);
          await widgetTester.tap(find.byKey(keyB));
          expect(groupValue, 'b');
        },
      );
    },
  );
}
