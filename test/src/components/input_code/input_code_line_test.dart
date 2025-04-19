import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:expense_core/core.dart';

import '../../../wrapper.dart';

void main() {
  group(
    'Input Code Accessibility',
    () {
      testWidgets(
        'Should verify accessibility',
        (widgetTester) async {
          final SemanticsHandle handle = widgetTester.ensureSemantics();

          await widgetTester.pumpWidget(
            Wrapper(
              child: ExpenseInputCodeLine(
                value: 'value',
                onChanged: (e) => debugPrint(''),
                semanticsLabel: 'semanticsLabel',
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

          // await expectLater(
          //   widgetTester,
          //   meetsGuideline(labeledTapTargetGuideline),
          // );

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
    'Input Code',
    () {
      testWidgets(
        'Should render input code',
        (widgetTester) async {
          final key = UniqueKey();
          String value = '';

          await widgetTester.pumpWidget(
            Wrapper(
              child: ExpenseInputCodeLine(
                key: key,
                value: value,
                onChanged: (e) => debugPrint(''),
              ),
            ),
          );

          expect(find.byKey(key), findsOneWidget);
        },
      );

      testWidgets(
        'Should input code showing description',
        (widgetTester) async {
          final key = UniqueKey();
          String value = '';
          const description = 'Description';

          await widgetTester.pumpWidget(
            Wrapper(
              child: ExpenseInputCodeLine(
                key: key,
                value: value,
                description: description,
                onChanged: (e) => debugPrint(''),
              ),
            ),
          );

          expect(find.text(description), findsOneWidget);
        },
      );

      testWidgets(
        'Should input code check items showing',
        (widgetTester) async {
          final key = UniqueKey();
          String value = '';
          const description = 'Description';

          await widgetTester.pumpWidget(
            Wrapper(
              child: ExpenseInputCodeLine(
                key: key,
                value: value,
                description: description,
                itemsCount: 5,
                onChanged: (e) => debugPrint(''),
              ),
            ),
          );

          final widgets = find.descendant(
            of: find.byType(Row),
            matching: find.byType(GestureDetector),
          );

          expect(widgetTester.elementList(widgets).length, 5);
        },
      );

      testWidgets(
        'Should input code tap',
        (widgetTester) async {
          final key = UniqueKey();
          ExpenseThemeManager? tokens;

          String value = '';
          const description = 'Description';

          await widgetTester.pumpWidget(
            Wrapper(
              onTokens: (t) => tokens = t,
              child: ExpenseInputCodeLine(
                key: key,
                value: value,
                description: description,
                itemsCount: 5,
                onChanged: (e) => debugPrint(''),
              ),
            ),
          );

          await widgetTester.press(find.byKey(key));
          await widgetTester.pump(const Duration(milliseconds: 200));

          final containers = find.descendant(
            of: find.byType(Row),
            matching: find.byType(Container),
          );
          final widget = widgetTester.widget<Container>(containers.first);
          final decoration = widget.decoration as BoxDecoration;
          expect(decoration.color, tokens!.alias.mixin.pressedOutline);
        },
      );

      testWidgets(
        'Should input code actived and focused',
        (widgetTester) async {
          final key = UniqueKey();
          ExpenseThemeManager? tokens;

          String value = '';
          const description = 'Description';

          await widgetTester.pumpWidget(
            Wrapper(
              onTokens: (t) => tokens = t,
              child: ExpenseInputCodeLine(
                key: key,
                value: value,
                description: description,
                onChanged: (e) => debugPrint(''),
              ),
            ),
          );

          final containers = find.descendant(
            of: find.byType(Row),
            matching: find.byType(Container),
          );

          await widgetTester.tap(containers.first);
          await widgetTester.pumpAndSettle();

          final widget = widgetTester.widget<Container>(containers.first);
          final decoration = widget.decoration as BoxDecoration;
          final border = decoration.border as Border;
          expect(border.bottom.color, tokens!.alias.color.active.borderColor);
        },
      );

      testWidgets(
        'Should input code obscure text',
        (widgetTester) async {
          final key = UniqueKey();
          ExpenseThemeManager? tokens;

          String value = '1';
          const description = 'Description';

          await widgetTester.pumpWidget(
            Wrapper(
              onTokens: (t) => tokens = t,
              child: ExpenseInputCodeLine(
                key: key,
                value: value,
                description: description,
                itemsCount: 5,
                onChanged: (e) => debugPrint(''),
                obscureText: true,
              ),
            ),
          );

          final widget = find.descendant(
            of: find.byType(Center),
            matching: find.byType(Container),
          );

          final container = widgetTester.widget<Container>(widget);
          final decoration = container.decoration as BoxDecoration;
          expect(decoration.color, tokens!.alias.color.active.placeholderColor);
        },
      );
    },
  );
}
