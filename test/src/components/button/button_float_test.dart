import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:expense_core/core.dart';

import '../../../wrapper.dart';

void main() {
  group(
    'Button group Accessibility',
    () {
      testWidgets(
        'Should verify accessibility',
        (widgetTester) async {
          final SemanticsHandle handle = widgetTester.ensureSemantics();

          await widgetTester.pumpWidget(
            Wrapper(
              child: ExpenseButtonFloat(
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
    'Button Float',
    () {
      testWidgets(
        'Should render button with label',
        (widgetTester) async {
          const label = 'Button';

          await widgetTester.pumpWidget(
            Wrapper(
              child: ExpenseButtonFloat(
                label: label,
                onPressed: () => debugPrint(''),
              ),
            ),
          );

          final widget = find.text(label);
          expect(widget, findsOneWidget);
        },
      );

      testWidgets(
        'Should button tap',
        (widgetTester) async {
          const label = 'Button';
          bool press = false;
          final key = UniqueKey();

          await widgetTester.pumpWidget(
            Wrapper(
              child: ExpenseButtonFloat(
                key: key,
                label: label,
                onPressed: () => press = true,
              ),
            ),
          );

          await widgetTester.tap(find.byKey(key));
          expect(press, isTrue);
        },
      );

      testWidgets(
        'Should button disabled and not accept tap',
        (widgetTester) async {
          const label = 'Button';
          bool press = false;
          final key = UniqueKey();

          await widgetTester.pumpWidget(
            Wrapper(
              child: ExpenseButtonFloat(
                key: key,
                label: label,
                disabled: true,
                onPressed: () => press = true,
              ),
            ),
          );

          await widgetTester.tap(find.byKey(key));
          expect(press, isFalse);
        },
      );

      testWidgets(
        'Should button loading and not accept tap',
        (widgetTester) async {
          const label = 'Button';
          bool press = false;
          final key = UniqueKey();

          await widgetTester.pumpWidget(
            Wrapper(
              child: ExpenseButtonFloat(
                key: key,
                label: label,
                loading: true,
                onPressed: () => press = true,
              ),
            ),
          );

          // dont accept tap
          await widgetTester.tap(find.byKey(key));
          expect(press, isFalse);

          // showing loading widget
          final widget = find.byKey(const Key('button-loading'));
          expect(widget, findsOneWidget);
        },
      );

      testWidgets(
        'Should button showing icon and text label',
        (widgetTester) async {
          const label = 'Button';

          final key = UniqueKey();

          await widgetTester.pumpWidget(
            Wrapper(
              child: ExpenseButtonFloat(
                key: key,
                label: label,
                loading: true,
                icon: ExpenseIcons.userLine,
                onPressed: () => debugPrint(''),
              ),
            ),
          );

          // showing icon
          final widgetIcon = find.byKey(const Key('ds-button-icon'));
          expect(widgetIcon, findsOneWidget);

          // showing text label
          final widgetText = find.text(label);
          expect(widgetText, findsOneWidget);
        },
      );
    },
  );
}
