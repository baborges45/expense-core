// ignore_for_file: avoid_init_to_null

import 'package:expense_core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../wrapper.dart';

void main() {
  group(
    'Checkbox Accessibility',
    () {
      testWidgets(
        'Should verify accessibility',
        (widgetTester) async {
          final SemanticsHandle handle = widgetTester.ensureSemantics();

          await widgetTester.pumpWidget(
            Wrapper(
              child: ExpenseCheckbox(
                label: 'label',
                value: false,
                onChanged: (e) => debugPrint(''),
                semanticsLabel: 'a',
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
    'Checkbox',
    () {
      testWidgets(
        'Should be render correctly',
        (widgetTester) async {
          final key = UniqueKey();

          await widgetTester.pumpWidget(
            Wrapper(
              child: ExpenseCheckbox(
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
              child: ExpenseCheckbox(
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
        'Should be changing value on pressed',
        (widgetTester) async {
          final key = UniqueKey();
          bool value = false;

          void onChanged(bool? newValue) {
            value = newValue!;
          }

          await widgetTester.pumpWidget(
            Wrapper(
              child: ExpenseCheckbox(
                key: key,
                onChanged: onChanged,
                value: value,
              ),
            ),
          );

          await widgetTester.tap(find.byKey(key));
          expect(value, true);
        },
      );

      testWidgets(
        'Should be disabled unchecked',
        (widgetTester) async {
          final key = UniqueKey();
          bool value = false;

          void onChanged(bool? newValue) {
            value = newValue!;
          }

          await widgetTester.pumpWidget(
            Wrapper(
              child: ExpenseCheckbox(
                key: key,
                onChanged: onChanged,
                value: value,
                disabled: true,
              ),
            ),
          );

          await widgetTester.tap(find.byKey(key));
          await widgetTester.pumpAndSettle();

          expect(value, isFalse);
        },
      );

      testWidgets(
        'Should be disabled checked',
        (widgetTester) async {
          final key = UniqueKey();
          ExpenseThemeManager? tokens;

          bool value = true;
          const label = 'checkbox';

          void onChanged(bool? newValue) {
            value = newValue!;
          }

          await widgetTester.pumpWidget(
            Wrapper(
              onTokens: (t) => tokens = t,
              child: ExpenseCheckbox(
                key: key,
                label: label,
                onChanged: onChanged,
                value: value,
                disabled: true,
              ),
            ),
          );

          await widgetTester.tap(find.byKey(key));
          await widgetTester.pumpAndSettle();

          final widget = widgetTester.widget<Text>(find.text(label));
          final style = widget.style as TextStyle;

          expect(style.color, tokens!.alias.color.disabled.labelColor);
          expect(value, isTrue);
        },
      );

      testWidgets(
        'Should have an animation',
        (widgetTester) async {
          final key = UniqueKey();
          bool value = false;

          void onChanged(bool? newValue) {
            value = newValue!;
          }

          await widgetTester.pumpWidget(
            Wrapper(
              child: ExpenseCheckbox(
                key: key,
                onChanged: onChanged,
                value: value,
              ),
            ),
          );

          final animationFinder = find.byKey(const Key('checkbox.animation'));
          expect(animationFinder, findsNothing);

          final radioButtonFinder = find.byKey(key);

          await widgetTester.press(radioButtonFinder);
          await widgetTester.pump();
          expect(animationFinder, findsOneWidget);
        },
      );

      testWidgets(
        'Should have an animation inverse',
        (widgetTester) async {
          final key = UniqueKey();
          bool value = false;

          void onChanged(bool? newValue) {
            value = newValue!;
          }

          await widgetTester.pumpWidget(
            Wrapper(
              child: ExpenseCheckbox(
                key: key,
                onChanged: onChanged,
                value: value,
                inverse: true,
              ),
            ),
          );

          final animationFinder = find.byKey(const Key('checkbox.animation'));
          expect(animationFinder, findsNothing);

          final radioButtonFinder = find.byKey(key);

          await widgetTester.press(radioButtonFinder);
          await widgetTester.pump();
          expect(animationFinder, findsOneWidget);
        },
      );

      testWidgets(
        'Should be inverse',
        (widgetTester) async {
          final key = UniqueKey();
          ExpenseThemeManager? tokens;

          bool value = true;
          const label = 'Checkbox';

          void onChanged(bool? newValue) {
            value = newValue!;
          }

          await widgetTester.pumpWidget(
            Wrapper(
              onTokens: (t) => tokens = t,
              child: ExpenseCheckbox(
                key: key,
                label: label,
                onChanged: onChanged,
                value: value,
                inverse: true,
              ),
            ),
          );

          final checkboxBackground = find.byKey(
            const Key('checkbox.background'),
          );
          expect(checkboxBackground, findsOneWidget);

          final widget = widgetTester.widget<Container>(checkboxBackground);
          final decoration = widget.decoration as BoxDecoration;
          expect(decoration.color, tokens!.alias.color.inverse.bgColor);

          final text = widgetTester.widget<Text>(find.text(label));
          final style = text.style as TextStyle;
          expect(style.color, tokens!.alias.color.inverse.labelColor);
        },
      );

      testWidgets(
        'Should have checkbox is null',
        (widgetTester) async {
          final key = UniqueKey();
          bool? value = null;

          void onChanged(bool? newValue) {
            value = newValue!;
          }

          await widgetTester.pumpWidget(
            Wrapper(
              child: ExpenseCheckbox(
                key: key,
                onChanged: onChanged,
                value: value,
              ),
            ),
          );

          await widgetTester.tap(find.byKey(key));
          await widgetTester.pumpAndSettle();

          expect(value, isTrue);
        },
      );
    },
  );
}
