import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:expense_core/core.dart';

import '../../../wrapper.dart';

void main() {
  group('DatePicker', () {
    testWidgets(
      'Should render date picker empty date selected',
      (widgetTester) async {
        final key = UniqueKey();
        List<DateTime?> date = [];

        await widgetTester.pumpWidget(
          Wrapper(
            child: ExpenseDatePicker(
              key: key,
              value: date,
              onValueChanged: (value) => date = value,
            ),
          ),
        );

        expect(date, isEmpty);
      },
    );

    testWidgets(
      'Should render date picker selected',
      (widgetTester) async {
        final key = UniqueKey();
        List<DateTime?> date = [];

        await widgetTester.pumpWidget(
          Wrapper(
            child: ExpenseDatePicker(
              key: key,
              value: date,
              onValueChanged: (value) => date = value,
            ),
          ),
        );

        final dayText = DateTime.now().day;
        final dayPicker = find.text(dayText.toString());

        final dayWidget = find.ancestor(
          of: dayPicker,
          matching: find.byType(GestureDetector),
        );

        await widgetTester.tap(dayWidget);
        await widgetTester.pumpAndSettle();

        final widget = find.byKey(const Key('calendar-day-picker.selected'));

        expect(widget, findsOneWidget);
      },
    );

    testWidgets(
      'Should render date picker change mode',
      (widgetTester) async {
        final key = UniqueKey();
        List<DateTime?> date = [];

        await widgetTester.pumpWidget(
          Wrapper(
            child: ExpenseDatePicker(
              key: key,
              value: date,
              onValueChanged: (value) => date = value,
            ),
          ),
        );

        final gesture = find.byKey(const Key('calendar-mode.gesture'));

        await widgetTester.tap(gesture);
        await widgetTester.pumpAndSettle();

        final yearText = DateTime.now().year;
        final widget = find.text(yearText.toString());

        expect(widget, findsOneWidget);
      },
    );

    testWidgets(
      'Should render date picker change month',
      (widgetTester) async {
        final key = UniqueKey();
        List<DateTime?> date = [];
        DateTime? month;

        await widgetTester.pumpWidget(
          Wrapper(
            child: ExpenseDatePicker(
              key: key,
              value: date,
              onValueChanged: (value) => date = value,
              onDisplayedMonthChanged: (value) => month = value,
            ),
          ),
        );

        final button = find.byType(ExpenseButtonIcon);
        await widgetTester.tap(button.last);
        await widgetTester.pumpAndSettle();

        expect(month, isNotNull);
      },
    );

    testWidgets(
      'Should render date picker change year',
      (widgetTester) async {
        final key = UniqueKey();
        List<DateTime?> date = [];

        await widgetTester.pumpWidget(
          Wrapper(
            child: ExpenseDatePicker(
              key: key,
              value: date,
              onValueChanged: (value) => date = value,
            ),
          ),
        );

        final gesture = find.byKey(const Key('calendar-mode.gesture'));

        await widgetTester.tap(gesture);
        await widgetTester.pumpAndSettle();

        final yearText = DateTime.now().add(const Duration(days: 365 * 2));
        final yearButton = find.ancestor(
          of: find.text(yearText.year.toString()),
          matching: find.byType(GestureDetector),
        );

        await widgetTester.tap(yearButton);
        await widgetTester.pumpAndSettle();

        expect(yearButton, findsNothing);
      },
    );

    testWidgets(
      'Should render date picker type multi',
      (widgetTester) async {
        final key = UniqueKey();
        List<DateTime?> date = [
          DateTime.now().add(const Duration(days: 2)),
          DateTime.now().add(const Duration(days: 5)),
        ];

        await widgetTester.pumpWidget(
          Wrapper(
            child: ExpenseDatePicker(
              key: key,
              value: date,
              onValueChanged: (value) => date = value,
              type: ExpenseDatePickerType.multi,
            ),
          ),
        );

        final finder = find.byKey(const Key('calendar-day-picker.selected'));
        final widgets = widgetTester.widgetList(finder);

        expect(widgets.length, date.length);
      },
    );

    testWidgets(
      'Should render date picker type multi',
      (widgetTester) async {
        final key = UniqueKey();
        List<DateTime?> date = [
          DateTime.now().add(const Duration(days: 2)),
        ];

        await widgetTester.pumpWidget(
          Wrapper(
            child: ExpenseDatePicker(
              key: key,
              value: date,
              onValueChanged: (value) => date = value,
              type: ExpenseDatePickerType.multi,
            ),
          ),
        );

        final day = DateTime.now().add(const Duration(days: 2));
        final dayWidget = find.ancestor(
          of: find.text(day.day.toString()),
          matching: find.byType(GestureDetector),
        );

        await widgetTester.tap(dayWidget);
        await widgetTester.pumpAndSettle();

        final finder = find.byKey(const Key('calendar-day-picker.selected'));
        final widgets = widgetTester.widgetList(finder);

        expect(widgets.length, 0);
      },
    );

    testWidgets(
      'Should render date picker type range',
      (widgetTester) async {
        final key = UniqueKey();
        List<DateTime?> date = [
          DateTime.now().add(const Duration(days: 2)),
          DateTime.now().add(const Duration(days: 5)),
        ];

        await widgetTester.pumpWidget(
          Wrapper(
            child: ExpenseDatePicker(
              key: key,
              value: date,
              onValueChanged: (value) => date = value,
              type: ExpenseDatePickerType.range,
            ),
          ),
        );

        final finder = find.byKey(
          const Key('calendar-day-picker.selected-range'),
        );
        final widgets = widgetTester.widgetList(finder);

        expect(widgets.length, 4);
      },
    );
  });

  group('DatePicker Accessibility', () {
    testWidgets(
      'Should verify accessibility',
      (widgetTester) async {
        final SemanticsHandle handle = widgetTester.ensureSemantics();

        List<DateTime?> date = [];

        await widgetTester.pumpWidget(
          Wrapper(
            child: ExpenseDatePicker(
              value: date,
              onValueChanged: (value) => date = value,
              semanticsLabel: 'Calendário',
              semanticsHint: 'Calendário hint',
            ),
          ),
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
